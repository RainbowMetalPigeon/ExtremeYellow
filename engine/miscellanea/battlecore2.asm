; wild mon or link battle enemy ran from battle
_EnemyRan:
	call LoadScreenTilesFromBuffer1
	ld a, [wLinkState]
	cp LINK_STATE_BATTLING
	ld hl, WildRanText
	jr nz, .printText
; link battle
	xor a
	ld [wBattleResult], a
	ld hl, EnemyRanText
.printText
	call PrintText
	ld a, SFX_RUN
	call PlaySoundWaitForCurrent
	xor a
	ldh [hWhoseTurn], a
	jpfar AnimationSlideEnemyMonOff

WildRanText:
	text_far _WildRanText
	text_end

EnemyRanText:
	text_far _EnemyRanText
	text_end

; ==========================================================

CheckWeathersAndTerrainsForBallAndPulse:
	ldh a, [hWhoseTurn]
	and a
	ld hl, wPlayerMoveNum
	jp z, .player
	ld hl, wEnemyMoveNum
.player
; hl points to the move number
	ld a, [hl]
	cp WEATHER_BALL
	jr nz, .checkTerrainPulse
; it's Weather Ball; check if there's an active weather
	inc hl
	inc hl ; now hl points to the move power
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	ld a, FIRE
	jr nz, .weather
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	ld a, WATER
	jr nz, .weather
	CheckEvent EVENT_WEATHER_SANDSTORM
	ld a, ROCK
	jr nz, .weather
	CheckEvent EVENT_WEATHER_HAIL
	ld a, ICE
	ret z ; no active weather
.weather
	ld [hl], 100
	inc hl ; now hl points to the move type
	ld [hl], a
	ret

.checkTerrainPulse
	cp TERRAIN_PULSE
	ret nz
; it's Terrain Pulse: check if the user is FLYING
	push hl
	callfar CheckIfTurnPokemonIsFlying ; z flag = FLYING
	pop hl
	ret z
; user is grounder: check if there's an active terrain
	inc hl
	inc hl ; now hl points to the move power
	CheckEvent EVENT_TERRAIN_GRASSY
	ld a, GRASS
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_ELECTRIC
	ld a, ELECTRIC
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_MISTY
	ld a, FAIRY
	jr nz, .terrain
	CheckEvent EVENT_TERRAIN_PSYCHIC
	ld a, PSYCHIC_TYPE
	ret z ; no active terrain
.terrain
	ld [hl], 100
	inc hl ; now hl points to the move type
	ld [hl], a
	ret

; ==========================================================

ApplyEntryHazardsPlayer::
	SetEvent EVENT_HAZARDS_DAMAGING_PLAYER

	ld b, FLYING
	call CheckIfPlayerPokemonIsCertainType ; z = FLYING
	jp z, .checkStealthRock ; skip grounded hazards
	; fallthrough

.entryHazardsCore
	ld a, [wHazardsSpikesPlayerSide]
	and a
	jr z, .checkToxicSpikes
; apply SPIKES
	ld hl, HurtBySpikesText
	call PrintText
	ld a, [wHazardsSpikesPlayerSide] ; re-load
	cp 3
	jr z, .spikes3Layers
	cp 2
	jr z, .spikes2Layers
; 1 layer of spikes
	call HandleHazards_DecreaseHP_1o8
	jr .checkToxicSpikes
.spikes2Layers
	call HandleHazards_DecreaseHP_1o6
	jr .checkToxicSpikes
.spikes3Layers
	call HandleHazards_DecreaseHP_1o4
	; fallthrough

.checkToxicSpikes
	ld a, [wHazardsToxicSpikesPlayerSide]
	and a
	jr z, .checkStickyWeb
; apply TOXIC_SPIKES
; check if the grounded entrying mon is steel (only in inverse) or poison (always)
	ld a, [wInverseBattle]
	and a
	jr nz, .inverseBattle
	ld b, STEEL
	call CheckIfPlayerPokemonIsCertainType ; z = yes
	jr z, .checkStickyWeb
.inverseBattle
	ld b, POISON
	call CheckIfPlayerPokemonIsCertainType ; z = yes
	jr nz, .entryingMonNotPoison
; entrying grounded mon is poison: it absorbs the toxic spikes
	xor a
	ld [wHazardsToxicSpikesPlayerSide], a
	ld hl, AbsorbsTheToxicSpikesText
	call PrintText
	jr .checkStickyWeb
.entryingMonNotPoison
; check if already poisoned; if yes, skip this
	ld hl, wBattleMonStatus
	bit PSN, [hl]
	jr nz, .checkStickyWeb
; not already poisoned
	ld hl, PoisonedByToxicSpikesText
	call PrintText
	ld a, [wHazardsToxicSpikesPlayerSide] ; re-load
	cp 1
	jr z, .toxicSpikes1Layer
; 2 layers of toxic spikes
	ld hl, wPlayerBattleStatus3
	ld de, wPlayerToxicCounter
	set BADLY_POISONED, [hl] ; set Toxic battstatus
	xor a
	ld [de], a
.toxicSpikes1Layer ; fallthrough
	ld hl, wBattleMonStatus
	set PSN, [hl] ; mon is now poisoned (PSN=3)
	; fallthrough

.checkStickyWeb
	ld a, [wHazardsStickyWebPlayerSide]
	and a
	jr z, .checkStealthRock
; apply STICKY_WEB
	ld hl, StuckInWebText
	call PrintText
	ld a, 6
	ld [wPlayerMonSpeedMod], a
	; fallthrough

.checkStealthRock
	ld a, [wHazardsStealthRockPlayerSide]
	and a
	ret z
; apply STEALTH_ROCK
	ld a, ROCK
	ld [wEnemyMoveType], a
	callfar AIGetTypeEffectiveness ; abused, but if it works it works
	                               ; result stored in [wTypeEffectiveness]
	ld a, [wTypeEffectiveness] ; (1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective)
	and a
	ret z ; effectiveness = 0, possible only with randomizer, do nothing, we're done here
	push af
	ld hl, HurtByRocksText
	call PrintText
	pop af
	cp 16
	jr z, .effDoubleSuper
	cp 8
	jr z, .effSuper
	cp 4
	jr z, .effNormal
	cp 2
	jr z, .effNotVery
; double not very effective
	call HandleHazards_DecreaseHP_1o32
	ret
.effNotVery
	call HandleHazards_DecreaseHP_1o16
	ret
.effNormal
	call HandleHazards_DecreaseHP_1o8
	ret
.effSuper
	call HandleHazards_DecreaseHP_1o4
	ret
.effDoubleSuper
	call HandleHazards_DecreaseHP_1o2
	ret

HurtBySpikesText::
	text_far _HurtBySpikesText
	text_end

PoisonedByToxicSpikesText::
	text_far _PoisonedByToxicSpikesText
	text_end

AbsorbsTheToxicSpikesText::
	text_far _AbsorbsTheToxicSpikesText
	text_end

StuckInWebText::
	text_far _StuckInWebText
	text_end

HurtByRocksText::
	text_far _HurtByRocksText
	text_end

; ----------------------------------------------------------

ApplyEntryHazardsEnemy::
	ResetEvent EVENT_HAZARDS_DAMAGING_PLAYER

	ld b, FLYING
	call CheckIfEnemyPokemonIsCertainType ; z = FLYING
	jp z, .checkStealthRock ; skip grounded hazards
	; fallthrough

.entryHazardsCore
	ld a, [wHazardsSpikesEnemySide]
	and a
	jr z, .checkToxicSpikes
; apply SPIKES
	ld hl, HurtBySpikesText
	call PrintText
	ld a, [wHazardsSpikesEnemySide] ; re-load
	cp 3
	jr z, .spikes3Layers
	cp 2
	jr z, .spikes2Layers
; 1 layer of spikes
	call HandleHazards_DecreaseHP_1o8
	jr .checkToxicSpikes
.spikes2Layers
	call HandleHazards_DecreaseHP_1o6
	jr .checkToxicSpikes
.spikes3Layers
	call HandleHazards_DecreaseHP_1o4
	; fallthrough

.checkToxicSpikes
	ld a, [wHazardsToxicSpikesEnemySide]
	and a
	jr z, .checkStickyWeb
; apply TOXIC_SPIKES
; check if the grounded entrying mon is steel (only in inverse) or poison (always)
	ld a, [wInverseBattle]
	and a
	jr nz, .inverseBattle
	ld b, STEEL
	call CheckIfEnemyPokemonIsCertainType ; z = yes
	jr z, .checkStickyWeb
.inverseBattle
	ld b, POISON
	call CheckIfEnemyPokemonIsCertainType ; z = yes
	jr nz, .entryingMonNotPoison
; entrying grounded mon is poison: it absorbs the toxic spikes
	xor a
	ld [wHazardsToxicSpikesEnemySide], a
	ld hl, AbsorbsTheToxicSpikesText
	call PrintText
	jr .checkStickyWeb
.entryingMonNotPoison
; check if already poisoned; if yes, skip this
	ld hl, wEnemyMonStatus
	bit PSN, [hl]
	jr nz, .checkStickyWeb
; not already poisoned
	ld hl, PoisonedByToxicSpikesText
	call PrintText
	ld a, [wHazardsToxicSpikesEnemySide] ; re-load
	cp 1
	jr z, .toxicSpikes1Layer
; 2 layers of toxic spikes
	ld hl, wEnemyBattleStatus3
	ld de, wEnemyToxicCounter
	set BADLY_POISONED, [hl] ; set Toxic battstatus
	xor a
	ld [de], a
.toxicSpikes1Layer ; fallthrough
	ld hl, wEnemyMonStatus
	set PSN, [hl] ; mon is now poisoned (PSN=3)
	; fallthrough

.checkStickyWeb
	ld a, [wHazardsStickyWebEnemySide]
	and a
	jr z, .checkStealthRock
; apply STICKY_WEB
	ld hl, StuckInWebText
	call PrintText
	ld a, 6
	ld [wEnemyMonSpeedMod], a
	; fallthrough

.checkStealthRock
	ld a, [wHazardsStealthRockEnemySide]
	and a
	ret z
; apply STEALTH_ROCK
	ld a, ROCK
	ld [wEnemyMoveType], a
; we need to fake the types of battle/enemy mon for the AI function to work as intended
	ld a, [wBattleMonType1]
	ld [wUniQuizAnswer], a
	ld a, [wEnemyMonType1]
	ld [wBattleMonType1], a
	ld a, [wBattleMonType2]
	ld [wUniQuizAnswer+1], a
	ld a, [wEnemyMonType2]
	ld [wBattleMonType2], a
; let's call the bastardized function
	callfar AIGetTypeEffectiveness ; abused, but if it works it works
	                               ; result stored in [wTypeEffectiveness]
; restore the real types of battle/enemy mon
	ld a, [wUniQuizAnswer]
	ld [wBattleMonType1], a
	ld a, [wUniQuizAnswer+1]
	ld [wBattleMonType2], a
; back on track
	ld a, [wTypeEffectiveness] ; (1 double not effective, 2 not effective, 4 neutral, 8 super effective, 16 double super effective)
	and a
	ret z ; effectiveness = 0, possible only with randomizer, do nothing, we're done here
	push af
	ld hl, HurtByRocksText
	call PrintText
	pop af
	cp 16
	jr z, .effDoubleSuper
	cp 8
	jr z, .effSuper
	cp 4
	jr z, .effNormal
	cp 2
	jr z, .effNotVery
; double not very effective
	call HandleHazards_DecreaseHP_1o32
	ret
.effNotVery
	call HandleHazards_DecreaseHP_1o16
	ret
.effNormal
	call HandleHazards_DecreaseHP_1o8
	ret
.effSuper
	call HandleHazards_DecreaseHP_1o4
	ret
.effDoubleSuper
	call HandleHazards_DecreaseHP_1o2
	ret

; ----------------------------------------------------------

; inputs: b = the type we want to check
; output: z if the mon is FLYING, nz if it's not
; modifies: z flag, a, hl
CheckIfPlayerPokemonIsCertainType:: ; z flag = FLYING
	ld hl, wBattleMonType1
	ld a, [hli] ; a is the first type of the attacking mon, hl+=1
	cp b
	ret z
	ld a, [hl] ; a is the second type of the attacking mon
	cp b
	ret

CheckIfEnemyPokemonIsCertainType:: ; z flag = FLYING
	ld hl, wEnemyMonType1
	ld a, [hli] ; a is the first type of the attacking mon, hl+=1
	cp b
	ret z
	ld a, [hl] ; a is the second type of the attacking mon
	cp b
	ret

; ----------------------------------------------------------

; expects EVENT_HAZARDS_DAMAGING_PLAYER to be properly set or reset
HandleHazards_DecreaseHP_1o2:
	ld d, 1
	jr HandleHazards_DecreaseHP_Core
HandleHazards_DecreaseHP_1o4:
	ld d, 2
	jr HandleHazards_DecreaseHP_Core
HandleHazards_DecreaseHP_1o8:
	ld d, 3
	jr HandleHazards_DecreaseHP_Core
HandleHazards_DecreaseHP_1o16:
	ld d, 4
	jr HandleHazards_DecreaseHP_Core
HandleHazards_DecreaseHP_1o32:
	ld d, 5
HandleHazards_DecreaseHP_Core:
	CheckEvent EVENT_HAZARDS_DAMAGING_PLAYER
	ld hl, wBattleMonHP
	jr nz, .victimIsPlayer
	ld hl, wEnemyMonHP
.victimIsPlayer
	push hl
	ld bc, $e      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
.loopOfHalving ; expects max HP < 1024, and anyway is less than 999, and 721 in pratice
	srl b
	rr c
	dec d
	jr nz, .loopOfHalving
; out of the loopino of halving
	ld a, c
	and a
	jr nz, .nonZeroDamage
	inc c         ; damage is at least 1
.nonZeroDamage
	pop hl
	inc hl
	ld a, [hl]    ; subtract total damage from current HP
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .noOverkill
	xor a         ; overkill: zero HP
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wHPBarNewHP+1], a
.noOverkill
	call UpdateAppropriateMonHPBar
	ret

HandleHazards_DecreaseHP_1o6:
	CheckEvent EVENT_HAZARDS_DAMAGING_PLAYER
	ld hl, wBattleMonHP
	jr nz, .victimIsPlayer
	ld hl, wEnemyMonHP
.victimIsPlayer
	push hl
	ld bc, $e      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
; divide MaxHP by 4
	srl b
	rr c
	srl b
	rr c ; MaxHP/4, now it's all in c
	push bc ; basically just to preserve b=0
; now divide them by 3 and multiply by 2
	ld a, c
	ld c, 3
	call SimpleDivide ; Divide a by c. Return quotient b and remainder a
; now b contains MaxHP/12
	ld a, b
	ld c, 2
	call SimpleMultiply ; Return a * c in a
; now a contains MaxHP/6
	pop bc ; basically just to preserve b=0
	ld c, a ; reversed
	and a
	jr nz, .nonZeroDamage
	inc c         ; damage is at least 1
.nonZeroDamage
	pop hl
	inc hl
	ld a, [hl]    ; subtract total damage from current HP
	ld [wHPBarOldHP], a
	sub c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	sbc b
	ld [hl], a
	ld [wHPBarNewHP+1], a
	jr nc, .noOverkill
	xor a         ; overkill: zero HP
	ld [hli], a
	ld [hl], a
	ld [wHPBarNewHP], a
	ld [wHPBarNewHP+1], a
.noOverkill
	call UpdateAppropriateMonHPBar
	ret

UpdateBattleMonHPBar::
	hlcoord 10, 9    ; tile pointer to player HP bar
	ld a, $1
	jr UpdateHPBarCommon
UpdateEnemyMonHPBar::
	hlcoord 2, 2     ; tile pointer to enemy HP bar
	xor a
UpdateHPBarCommon:
	ld [wHPBarType], a
	predef UpdateHPBar2
	ret

UpdateAppropriateMonHPBar:
	CheckEvent EVENT_HAZARDS_DAMAGING_PLAYER
	jr nz, .victimIsPlayer
	call UpdateEnemyMonHPBar
	ret
.victimIsPlayer
	call UpdateBattleMonHPBar
	ret

; ----------------------------------------------------------

; simple multiply and divide from crystal
; added call-far-able versions

; Return a * c.
SimpleMultiply:
	and a
	ret z
	push bc
	ld b, a
	xor a
.loop
	add c
	dec b
	jr nz, .loop
	pop bc
	ret

; Divide a by c. Return quotient b and remainder a.
SimpleDivide:
	ld b, 0
.loop
	inc b
	sub c
	jr nc, .loop
	dec b
	add c
	ret

; Return d * e in d.
SimpleMultiplyCallfarable::
	ld a, d
	ld c, e
	call SimpleMultiply
	ld d, a
	ret

; Divide d by e. Return quotient d and remainder e.
SimpleDivideCallfarable::
	ld a, d
	ld c, e
	call SimpleDivide
	ld d, b
	ld e, a
	ret

; ----------------------------------------------------------
