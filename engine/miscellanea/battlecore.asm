; base power: min(150 , 25xTargetSpeed/UserSpeed+1)
CalculateGyroBallBasePower::
	ldh a, [hWhoseTurn]
	and a
	ld de, wBattleMonSpeed ; player speed value
	ld hl, wEnemyMonSpeed ; enemy speed value
	jr z, .player
	ld de, wEnemyMonSpeed ; enemy speed value
	ld hl, wBattleMonSpeed ; player speed value
.player
	; de points to the user speed
	; hl points to the target speed

; calculate UserSpeed/5 first, and store it in a temporary 1 byte for later
	push hl ; preserve hl for later
	; put de in hl for the Divide
	ld h, d
	ld l, e
	ld a, 5 ; we divide by 5
	ldh [hDivisor], a
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2 ; 2? 4? TBV
	call Divide
	ldh a, [hQuotient + 3] ; only this one because it's just 1 byte, right?
	ld [wMultipurposeTemporaryStorage], a ; store temporarily the divided speed to use it later as a 1-byte divider
	                    ; let's use any one gabbo wram byte
	pop hl ; restore hl

; now we multiply the target speed by 25/5=5 (/5 because we already divided the user speed by 5)
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	xor a
	ldh [hMultiplicand], a

	ld a, 5
	ldh [hMultiplier], a
	call Multiply

;; testing
;	ld a, [hProduct]
;	ld a, [hProduct+1]
;	ld a, [hProduct+2]
;	ld a, [hProduct+3]

; now we gotta divide this result by the UserSpeed/5, temporarily stored in wMultipurposeTemporaryStorage
	ld a, [wMultipurposeTemporaryStorage]
	and a
	jr nz, .continue1
	ld a, 1 ; divisor can't be 0
.continue1
	ldh [hDivisor], a

	ld b, 4 ; 2? 4? TBV

	call Divide ; max result should be 6243, so we need to check 2 bytes of result

;; testing
;	ld a, [hQuotient]
;	ld a, [hQuotient+1]
;	ld a, [hQuotient+2]
;	ld a, [hQuotient+3]

; if the more significant byte is not 0, it means the result is surely above 255, so we get 150 as base power
	ldh a, [hQuotient + 2]
	and a
	jr nz, .load150AsBasePower

; the result is between 0 and 255
	ldh a, [hQuotient + 3]
	inc a ; +1
	jr z, .load150AsBasePower ; if it was 255 and so we overflew
	cp 150
	jr nc, .load150AsBasePower ; nc if a-150>=0, in which case we fix base power at 150
	ld d, a
	ret

.load150AsBasePower
	ld d, 150
	ret

; ===========================================================================

; GCS original
;FlailReversalPower:
;	; hp bar pixels, power
;	db HP_BAR_LENGTH_PX / 48,   200
;	db HP_BAR_LENGTH_PX / 12,   150
;	db HP_BAR_LENGTH_PX / 5,    100
;	db HP_BAR_LENGTH_PX / 3,     80
;	db HP_BAR_LENGTH_PX * 2 / 3, 40
;	db HP_BAR_LENGTH_PX,         20

FlailHPFractionsAndPowers: ; Extreme Yellow custom round fractions
	db 20, 200
	db 10, 150
	db  5, 100
	db  3,  80
	db  2,  40
	db  1,  20
	db -1

CalculateFlailBasePower::
	ld hl, FlailHPFractionsAndPowers
.loop
	ld a, [hli] ; a contains the fraction
	cp -1       ; should be useless but you never know
	jr z, .conclude
	push hl     ; hl points to the BP
	call CheckIfHPIsBelowFraction
	pop hl
	; c flag is set if we are below the threshold
	jr nc, .iterate ; not the right fraction, too many HP left
; we are below the currently checked threshold
	ld a, [hl]
	ld d, a
	ret
.iterate
	inc hl
	jr .loop
.conclude
	ld d, 20
	ret

CheckIfHPIsBelowFraction::
; return carry if player or enemy trainer's current HP is below 1 / a of the maximum
; used for FLAIL
	ldh [hDivisor], a
; turn-deciding code
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonMaxHP
	jr z, .player1
	ld hl, wEnemyMonMaxHP
.player1
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 3]
	ld c, a
	ldh a, [hQuotient + 2]
	ld b, a
; turn-deciding code
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonHP + 1
	jr z, .player2
	ld hl, wEnemyMonHP + 1
.player2
	ld a, [hld]
	ld e, a
	ld a, [hl]
	ld d, a
	ld a, d
	sub b
	ret nz
	ld a, e
	sub c
	ret

; ===========================================================================

WantToSurrenderFromTrainerBattle::
	ld a, [wCurMap]
	cp OAKS_LAB
	jr z, .cannotSurrender
	cp HAUNTED_ISLAND_OF_NUMBERS
	jr nz, .canSurrender
.cannotSurrender
	dec a ; to set the nz flag
	ret
.canSurrender
	ld hl, WannaSurrenderText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret nz
	ld hl, AreYouSureText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

WannaSurrenderText:
	text_far _WannaSurrenderText
	text_end

AreYouSureText:
	text_far _AreYouSureText
	text_end

; to handle randomization: type chart ==========================================

; function to tell how effective the type of an enemy attack is on the player's current pokemon
; when the type chart is randomized
; the result is stored in [wTypeEffectiveness]
; (0 is not effective, 1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective)
AIGetTypeEffectivenessRandomizedChart::
	ld a, [wEnemyMoveType]
	ld b, a                    ; b = type of enemy move

	ld a, 10
	ld [wTypeEffectiveness], a ; initialize to neutral effectiveness

; get type effectiveness

	ld a, [wBattleMonType1]
	ld d, a ; d = type 1 of player's pokemon

	call GetRandomizedTypeMatchup ; b=atk type, d=def type, out=effectiveness in a
	ld [wTypeEffectiveness], a

	ld a, 5 ; we divide by 5
	ldh [hDivisor], a
	ld a, [wTypeEffectiveness]
	ldh [hDividend], a
	ld b, 1
	call Divide ; we divide the type effectivness by 5: 0 for not effective, 1 for not very, 2 for normal, 4 for super
	; now [hQuotient + 3] contains the scaled-down effectiveness

; testing
	ldh a, [hQuotient]
	ldh a, [hQuotient+1]
	ldh a, [hQuotient+2]
	ldh a, [hQuotient+3]

	ld a, [wBattleMonType2]
	ld d, a
	ld a, [wBattleMonType1]
	cp d
	jr nz, .secondTypeCheck
; we don't check the same type twice for a monotype mon
	ldh a, [hQuotient+3]
	add a ; we double the current value, i.e. we multiply by 2, which happens to be the neutral damage of the "copy" of the only one type we have
	jr .completing

.secondTypeCheck
	; d = type 2 of player's pokemon

	ld a, 10
	ld [wTypeEffectiveness], a ; initialize to neutral effectiveness (in case we find no matches)

	call GetRandomizedTypeMatchup ; b=atk type, d=def type, out=effectiveness in a
	ld [wTypeEffectiveness], a

	xor a
	ldh [hMultiplicand], a
	ld a, [wTypeEffectiveness]
	ldh [hMultiplier], a
	call Multiply ; we have Effectivness1 / 5 * Effectivness2, which is at most 4*20=80<255, so still 1 byte

; testing
	ldh a, [hProduct]
	ldh a, [hProduct+1]
	ldh a, [hProduct+2]
	ldh a, [hProduct+3]

	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide

; testing
	ldh a, [hQuotient]
	ldh a, [hQuotient+1]
	ldh a, [hQuotient+2]
	ldh a, [hQuotient+3]

	ldh a, [hQuotient + 3] ; now a contains Effectivness1 / 5 * Effectivness2 / 5:
						   ; 0 for not effective
						   ; 1 for 1/4
						   ; 2 for 1/2
						   ; 4 for 1
						   ; 8 for 2
						   ; 16 for 4
.completing
	ld [wTypeEffectiveness], a
	ret

; -------------------------------------------------------

CalculateDamageAndMessageForRandomizatedTypeChart::
; values for player turn
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wPlayerMoveType]
	ld [wMoveType], a
	ldh a, [hWhoseTurn]
	and a
	jr z, .next
; values for enemy turn
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wEnemyMoveType]
	ld [wMoveType], a
.next
	ld a, [wMoveType]
	ld b, a    ; b = type of the move

; here b = type attack, d = type 1 defender, e = type 2 defender

	push bc
	push de

.doAllTheThings
	call GetRandomizedTypeMatchup ; b=atk type, d=def type, out=effectiveness in a
; handle type effectiveness message
	push af
	ld a, [wDamageMultipliers]
	and $80
	ld b, a
	pop af
	ldh [hMultiplier], a
	and a  ; cp NO_EFFECT
	jr z, .gotMultiplier
	cp NOT_VERY_EFFECTIVE
	jr nz, .nothalf
	ld a, [wDamageMultipliers]
	and $7f
	srl a
	jr .gotMultiplier
.nothalf
	cp SUPER_EFFECTIVE
	jr nz, .gotMultiplier
	ld a, [wDamageMultipliers]
	and $7f
	sla a
.gotMultiplier
	add b
	ld [wDamageMultipliers], a
; do the math: multiply
	xor a
	ldh [hMultiplicand], a
	ld hl, wDamage
	ld a, [hli]
	ldh [hMultiplicand + 1], a
	ld a, [hld]
	ldh [hMultiplicand + 2], a
	call Multiply
; do the math: divide by 10
	ld a, EFFECTIVE
	ldh [hDivisor], a
	ld b, $04
	call Divide
; check if the damage is 0
	ldh a, [hQuotient + 2]
	ld [hli], a
	ld b, a
	ldh a, [hQuotient + 3]
	ld [hl], a
	or b ; is damage 0?
	jr nz, .skipTypeImmunity
.typeImmunity
; if damage is 0, make the move miss
; this only occurs if a move that would do 2 or 3 damage is 0.25x effective against the target
	inc a
	ld [wMoveMissed], a
.skipTypeImmunity
	CheckEvent EVENT_SECOND_HANDLING_RANDOM_CHART
	jr nz, .defendingMonIsMonoType

	pop de
	pop bc

	ld a, e
	cp d
	jr z, .defendingMonIsMonoType

	ld d, a
	SetEvent EVENT_SECOND_HANDLING_RANDOM_CHART
	jr .doAllTheThings ; b=atk type, d=def type, out=effectiveness in a

.defendingMonIsMonoType
	ResetEvent EVENT_SECOND_HANDLING_RANDOM_CHART
	ret

; -------------------------------------------------------

; b: attacking type
; d: defending type (needs to be loaded properly, one defending type at the time)
; output: effectiveness in a
GetRandomizedTypeMatchup:
	ld a, [wCurOpponent]
	cp OPP_GONQUE
	jr nz, .nonGonqueRandomization
    ld a, [wRandomMemoryAddressForGonqueChartRandomization]
    ld h, a
    ld a, [wRandomMemoryAddressForGonqueChartRandomization+1]
    ld l, a
	jr .addressFound
.nonGonqueRandomization
    ld a, [wRandomMemoryAddressForTypeChartRandomization]
    ld h, a
    ld a, [wRandomMemoryAddressForTypeChartRandomization+1]
    ld l, a
    ; hl is the random address chosen when we randomized the type chart
; (scaled) offensive type is multiplied by 19 (BIRD too), (scaled) defensive type by 1
; both are added to the address
.addressFound
    ld a, b
    cp TYPELESS ; TYPELESS is always neutral towards everything
    jr z, .handleTypeless
    push bc
    push de ; preserve the original types for the final "special type check"
    call RescaleTypes ; a contains the re-scaled offensive type
    ld bc, 19
    call AddNTimes ; add bc to hl a times
    ld a, d
    call RescaleTypes ; a contains the re-scaled defensive type
    ld bc, 1
    call AddNTimes ; add bc to hl a times
    ; hl points to the memory address, unique for this offensive-defensive type combo
    ld a, [hl]
    call ConvertRandomNumberIntoEffectiveness
    ld [wMultipurposeTemporaryStorage], a
    pop de
    pop bc ; restore the original types for the final "special type check"
    call HandleSpecialTypeCombos ; returns the effectiveness in a
    ret
.handleTypeless
    ld a, EFFECTIVE
    ret

; -------------------------------------------------------

; re-scale types in a [0;18] range (BIRD too)
; input: a is the type
; ouput: a is the rescale type
RescaleTypes:
    cp GROUND2
    jr nz, .notGround2
    ld a, GROUND
    jr .continueRescaling
.notGround2
    cp ICE2
    jr nz, .continueRescaling
    ld a, ICE
.continueRescaling
    cp FIRE
    ret c ; do nothing more if it's a physical move
          ; GROUND2 handled above, and TYPELESS beforehand
; special move, needs to be -10ed
    sub 10
    ret

; -------------------------------------------------------

; input: a, random value
; output: a, effectiveness value
; 25% EFFECTIVE, 35% SUPER_EFFECTIVE, 35% NOT_VERY_EFFECTIVE, 5% NO_EFFECT
; [0,64] EFFECTIVE, [65,154] SUPER_EFFECTIVE, [154,243] NOT_VERY_EFFECTIVE, [244,255] NO_EFFECT
; keeps inverse battles into account already
ConvertRandomNumberIntoEffectiveness:
    cp 244
    jr nc, .noEffect
    cp 154
    jr nc, .notVeryEffective
    cp 65
    jr nc, .superEffective
; normal effective
    ld a, EFFECTIVE
    ret
.noEffect
    ld b, NO_EFFECT
    jr .checkInverse
.notVeryEffective
    ld b, NOT_VERY_EFFECTIVE
    jr .checkInverse
.superEffective
    ld b, SUPER_EFFECTIVE
;    jr .checkInverse
.checkInverse
    ld a, [wInverseBattle] ; 0=normal, 1=inverse
    and a
    jr z, .normalBattle
; inverse battle and not normal effectiveness
    ld a, b
    cp EFFECTIVE ; it cannot be exactly it, it's either more or less
    jr c, .littleEffective
; it's an inverse battle and the base effectiveness would be super effective, let's swap it
    ld b, NOT_VERY_EFFECTIVE
    jr .normalBattle
.littleEffective ; it's an inverse battle and the base effectiveness would be not very effective or no effect, let's swap it
    ld b, SUPER_EFFECTIVE
.normalBattle
    ld a, b
    ret

; -------------------------------------------------------

; inputs: b=offensive type; d=defensive type, BEFORE rescaling
HandleSpecialTypeCombos:
    ld a, b ; a holds the offensive type
    cp GROUND2
    jr nz, .notGround2
; offensive is GROUND2, let's check if defensive is FLYING
    ld a, d
    cp FLYING
    jr nz, .notSpecialCombo
; offensive GROUND2, defensive FLYING: if random effectivness is less than EFFECTIVE, make it EFFECTIVE
    ld a, [wMultipurposeTemporaryStorage]
    cp EFFECTIVE
    ret nc
    ld a, EFFECTIVE
    ret
.notGround2
    cp ICE2
    jr nz, .notSpecialCombo
; offensive is ICE2, let's check if defensive is WATER
    ld a, d
    cp WATER
    jr nz, .notSpecialCombo
; offensive ICE2, defensive WATER, make this SUPER_EFFECTIVE
    ld a, SUPER_EFFECTIVE
    ret
.notSpecialCombo
    ld a, [wMultipurposeTemporaryStorage]
    ret

; ===========================================================================

; input: d holds the current base power
; output: d holds the modifier base power
BasePowerModifierWeatherTerrain_Player:
	ld hl, wPlayerMoveNum
	jr PerformChecks
BasePowerModifierWeatherTerrain_Enemy:
	ld hl, wEnemyMoveNum
PerformChecks:

; Solarbeam check
	ld a, [hl]
	cp SOLARBEAM
	jr nz, .notSolarBeam
; Solarbeam, let's check for Rain Dance and Sandstorm and Hail
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	jr nz, .halveSolarBeam
	CheckEvent EVENT_WEATHER_SANDSTORM
	jr nz, .halveSolarBeam
	CheckEvent EVENT_WEATHER_HAIL
	jr z, .generalTypesChecks
.halveSolarBeam
	srl d ; halve Solarbeam's power
	jr .generalTypesChecks ; here we need to continue because there may be a Grassy Terrain on
.notSolarBeam

; Earthquake check
	ld a, [hl]
	cp EARTHQUAKE
	jr nz, .generalTypesChecks
; Earthquake, let's check for Grassy Terrain
	CheckEvent EVENT_TERRAIN_GRASSY
	ret z ; doesn't make sense to continue, because if it's Earthquake it's not modified by any other weather or terrain
	srl d ; halve Earthquake's power
	ret ; see two lines above

; general types checks
.generalTypesChecks
	push de
	ld de, wPlayerMoveType - wPlayerMoveNum
	add hl, de
	pop de
; with the above, we moved the hl to point to the move type rather than its number
	ld a, [hl] ; a = move type
	cp FIRE
	jr z, .fire
	cp WATER
	jr z, .water

	cp ELECTRIC
	jr z, .electric
	cp GRASS
	jr z, .grass
	cp PSYCHIC_TYPE
	jr z, .psychic
	cp DRAGON
	jr z, .dragon
	ret

.fire
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	jr z, .fire_CheckRainDance
	jr .addHalfToBasePowerInD
.fire_CheckRainDance
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	ret z
	jr .subtractHalfFromBasePowerInD

.water
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	jr z, .water_checkSunnyDay
	jr .addHalfToBasePowerInD
.water_checkSunnyDay
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ret z
	jr .subtractHalfFromBasePowerInD

; for the terrains: check if the user is part Flying: if so, let's skip the next checks
; except for Misty Terrains, which affects the defender, so we swap the check
; terrains only affect grounded pokemon, and we don't consider Levitating ones

.electric
	CheckEvent EVENT_TERRAIN_ELECTRIC
	ret z
	call CheckIfTurnPokemonIsFlying ; z flag = FLYING
	ret z
	jr .addHalfToBasePowerInD

.grass
	CheckEvent EVENT_TERRAIN_GRASSY
	ret z
	call CheckIfTurnPokemonIsFlying
	ret z
	jr .addHalfToBasePowerInD

.psychic
	CheckEvent EVENT_TERRAIN_PSYCHIC
	ret z
	call CheckIfTurnPokemonIsFlying
	ret z
	jr .addHalfToBasePowerInD

.dragon
	CheckEvent EVENT_TERRAIN_MISTY
	ret z
	call CheckIfNonTurnPokemonIsFlying ; this is the opposite of the three other terrains
	ret z
	jr .subtractHalfFromBasePowerInD

.subtractHalfFromBasePowerInD
	srl d
	ret

.addHalfToBasePowerInD
	ld a, d
	srl a
	add d
	ld d, a
	ret

; ===========================================================================

; inputs: none
; output: z if the mon is FLYING, nz if it's not
; modifies: z flag, a, hl
CheckIfTurnPokemonIsFlying:: ; z flag = FLYING
	ldh a, [hWhoseTurn]
	and a
	ld hl, wBattleMonType1
	jr z, .playersVariables
	ld hl, wEnemyMonType1
.playersVariables
	ld a, [hli] ; a is the first type of the attacking mon, hl+=1
	cp FLYING
	ret z
	ld a, [hl] ; a is the second type of the attacking mon
	cp FLYING
	ret

; same as above
CheckIfNonTurnPokemonIsFlying:: ; z flag = FLYING
	ldh a, [hWhoseTurn]
	and a
	ld hl, wEnemyMonType1
	jr z, .playersVariables
	ld hl, wBattleMonType1
.playersVariables
	ld a, [hli] ; a is the first type of the attacking mon, hl+=1
	cp FLYING
	ret z
	ld a, [hl] ; a is the second type of the attacking mon
	cp FLYING
	ret

; ===========================================================================

HandleWeatherBallAndTerrainPulseAnimation::
	xor a
	ld [wAnimationType], a
	ldh a, [hWhoseTurn]
	and a
	ld de, wEnemyBattleStatus1
	ld hl, wPlayerMoveNum
	jr z, .player
	ld de, wEnemyBattleStatus1
	ld hl, wEnemyMoveNum
.player
	ld a, [de]
	bit INVULNERABLE, a ; fly/dig
	ret nz
	ld a, [wMoveMissed]
	and a
	ret nz

; let's check if it's one of the two moves of interest
	ld a, [hl]
	cp WEATHER_BALL
	jr z, .isWeatherBall
	cp TERRAIN_PULSE
	ret nz

; it's Terrain Pulse: check if user is FLYING
	call CheckIfTurnPokemonIsFlying
	ret z
; let's check if there's a terrain active
	CheckEvent EVENT_TERRAIN_GRASSY
	ld a, PETAL_DANCE
	jr nz, .playExtraAnimation
	CheckEvent EVENT_TERRAIN_ELECTRIC
	ld a, THUNDERBOLT
	jr nz, .playExtraAnimation
	CheckEvent EVENT_TERRAIN_MISTY
	ld a, PLAY_ROUGH
	jr nz, .playExtraAnimation
	CheckEvent EVENT_TERRAIN_PSYCHIC
	ld a, CONFUSION
	jr nz, .playExtraAnimation
	ret ; no active terrain

.isWeatherBall
; let's check if there's a weather active
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ld a, FIRE_PUNCH
	jr nz, .playExtraAnimation
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	ld a, WATER_GUN
	jr nz, .playExtraAnimation
	CheckEvent EVENT_WEATHER_SANDSTORM
	ld a, ROCK_THROW
	jr nz, .playExtraAnimation
	CheckEvent EVENT_WEATHER_HAIL
	ld a, ICE_PUNCH
	ret z ; no active weather
.playExtraAnimation
	jp PlayMoveAnimationCopyCopy ; in handlepoisonburnleechseed file, same bank

; ===========================================================================

BasePowerModifierMoves_Player::
	ld bc, wPlayerMoveNum
	ld hl, wEnemyMonMinimized
	jr BasePowerModifier_Core

BasePowerModifierMoves_Enemy::
	ld bc, wEnemyMoveNum
	ld hl, wPlayerMonMinimized

BasePowerModifier_Core:
	ld a, [bc] ; move ID
	cp STOMP
	jr nz, .checkEarthquake
; it is STOMP; check if target is minimized
	ld a, [hl]
	and a
	ret z
; user uses STOMP and target is minimized
	rl d
	ret

	; TBE
.checkEarthquake ; DIG
.checkSurf ; WHIRLPOOL, DIVE
	
	ret

; ===========================================================================

ModifyMoveAccuracy::
; handle STOMP
	; TBE
; handle weathers
	ld hl, wPlayerMoveNum
	ld de, wPlayerMoveAccuracy
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	jr z, .playersTurnWeather
	ld hl, wEnemyMoveNum
	ld de, wEnemyMoveAccuracy
.playersTurnWeather
	ld a, [hl] ; a is the move number
	cp THUNDER
	jr z, .thunderOrHurricane
	cp HURRICANE
	jr z, .thunderOrHurricane
	cp BLIZZARD
	jr z, .blizzard
	jr .resetCarryFlagToNotSkipAccuracy

	; TBE: STOMP, EARTHQUAKE, etc

.thunderOrHurricane
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	jr z, .checkForRainDance
	ld a, 128 ; TBE
	ld [de], a ; set base accuracy of the move to 50% if under sun
	jr .resetCarryFlagToNotSkipAccuracy
.checkForRainDance
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	jr z, .resetCarryFlagToNotSkipAccuracy
	jr .scfToSkipAccuracy ; skip accuracy check if it's raining and we're using Thunder/Hurricane
.blizzard
	CheckEvent EVENT_WEATHER_HAIL
	jr z, .resetCarryFlagToNotSkipAccuracy

.scfToSkipAccuracy
	scf
	ret
.resetCarryFlagToNotSkipAccuracy
	xor a
	ret

; ===========================================================================

/*
CheckIfSkippingInvulnerability::
; EARTHQUAKE, WHIRLPOOL, SURF
; THUNDER and HURRICANE are a special case as they also needs to be handled by weathers
	wEnemyMonMinimized
	wPlayerMonMinimized

	ld hl, wPlayerBattleStatus1
	ld hl, wEnemyBattleStatus1
	bit INVULNERABLE, a ; fly/dig/dive

*/
