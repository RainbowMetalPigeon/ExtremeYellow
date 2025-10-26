HandlePoisonBurnLeechSeed::
	call HandleWeatherCounter   ; new, to handle weather counter
	                            ; but only if the current mon did not KO its opponent
	                            ; that's why it's here
	call HandleTerrainCounter   ; same for terrains
	call HandleTrickRoomCounter ; same for trick room

; new, give a chance to Starter Pikachu to heal itself
	callfar IsThisPartymonStarterPikachu ; edited, was the other version
	jr nc, .vanilla ; no starter Pikachu
	ld a, [wPikachuHappiness]
	cp 200
	jr c, .vanilla ; not happy enough to shrug off conditions
	ld a, [wBattleMonStatus]
	and a
	jp nz, .hasConditionsToHeal
; if we are here, Pikachu isn't statused, check for Leech Seed and Confusion
	ld a, [wPlayerBattleStatus2]
	bit SEEDED, a
	jr nz, .hasConditionsToHeal
	bit BEING_CURSED, a
	jr nz, .hasConditionsToHeal
; if here, no statuses nor seeds nor curse, check for Confusion
	ld hl, wPlayerBattleStatus1
	bit CONFUSED, [hl] ; set the zero flag if bit not set
	jr z, .vanilla ; not confused either, so back to normal stuff, could jump furher away but need to check too many things
.hasConditionsToHeal
	call BattleRandom2 ; edited for moving this into its own file
	cp 25 percent
	jr nc, .vanilla ; nothing happens
; 25% chance to heal itself from all conditions
	xor a
	ld [wBattleMonStatus], a ; heal status
	ld hl, wPlayerBattleStatus1
	res CONFUSED, [hl] ; heal confusion
	ld hl, wPlayerBattleStatus2
	res SEEDED, [hl] ; remove seeds
	res BEING_CURSED, [hl] ; remove curse
	ld hl, wPlayerBattleStatus3
	res BADLY_POISONED, [hl] ; removed toxic flag jic
	ld hl, PikachuHealItself
	call PrintText
.vanilla

; back to vanilla
	ld hl, wBattleMonHP
	ld de, wBattleMonStatus
	ldh a, [hWhoseTurn] ; 0=player, 1=enemy
	and a
	jr z, .playersTurn
	ld hl, wEnemyMonHP
	ld de, wEnemyMonStatus
.playersTurn
	ld a, [de]
	and (1 << BRN) | (1 << PSN)
	jr z, .notBurnedOrPoisoned
	push hl
	ld hl, HurtByPoisonText
	ld a, [de]
	and 1 << BRN
	jr z, .poisoned
	ld hl, HurtByBurnText
.poisoned
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BURN_PSN_ANIM
	call PlayAltAnimationCopy ; edited ; play burn/poison animation ; edited for moving this into its own file
	pop hl
	call HandlePoisonBurnLeechSeed_DecreaseOwnHP
.notBurnedOrPoisoned
	ld de, wPlayerBattleStatus2
	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn2
	ld de, wEnemyBattleStatus2
.playersTurn2
	ld a, [de]

; new, to handle CURSE
	push af
	push hl
	ld h, d
	ld l, e
	bit BEING_CURSED, [hl] ; BIT u3,r8 : test bit u3 in register r8, set the zero flag if bit not set
	pop hl
	jr z, .notCursed
	push hl
	ld hl, HurtByCurseText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BURN_PSN_ANIM
	call PlayAltAnimationCopy ; edited ; play burn/poison animation ; TBE? ; edited for moving this into its own file
	pop hl
	push hl ; ?
	call HandleCurse_DecreaseOwnHP
	pop hl ; ?
.notCursed
	pop af
; end of the CURSE block

; new, to handle grassy terrain
	push af
	CheckEvent EVENT_ENABLE_TERRAIN_HEALING
	jr z, .dontHandleTerrainHealing
	push hl
	CheckEvent EVENT_TERRAIN_GRASSY
	jr z, .noGrassyTerrainHealing
; player, check if grounded
	ld hl, wBattleMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp FLYING
	jr z, .grassyTerrainCheckEnemy
	ld a, [hl]
	cp FLYING
	jr z, .grassyTerrainCheckEnemy
; player, check if full HP
	ld hl, wBattleMonMaxHP
	ld de, wBattleMonHP
	ld a, [de]
	cp [hl]
	jr nz, .healPlayer
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr z, .grassyTerrainCheckEnemy
.healPlayer
; player healed by terrain
	call MakeTurnIntoPlayersTurn
	ld hl, HealedByGrassyTerrainText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, XSTATITEM_ANIM
	call PlayAltAnimationCopy
	call HandleTerrain_IncreasePlayerHP
	call RestoreRealTurn
; enemy, check if grounded
.grassyTerrainCheckEnemy
	ld hl, wEnemyMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp FLYING
	jr z, .noGrassyTerrainHealing
	ld a, [hl]
	cp FLYING
	jr z, .noGrassyTerrainHealing
; enemy, check if full HP
	ld hl, wEnemyMonMaxHP
	ld de, wEnemyMonHP
	ld a, [de]
	cp [hl]
	jr nz, .healEnemy
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr z, .noGrassyTerrainHealing
.healEnemy
; enemy damaged by Hail
	call MakeTurnIntoEnemysTurn
	ld hl, HealedByGrassyTerrainText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, XSTATITEM_ANIM
	call PlayAltAnimationCopy
	call HandleTerrain_IncreaseEnemyHP
	call RestoreRealTurn
.noGrassyTerrainHealing
	ResetEvent EVENT_ENABLE_TERRAIN_HEALING
	pop hl
.dontHandleTerrainHealing
	pop af
; end of the grassy terrain block

; new, to handle weathers
; we need to check if we are at the very end of the turn
	push af
	CheckEvent EVENT_ENABLE_WEATHER_DAMAGE
	jp z, .dontHandleWeatherDamage
	push hl
	CheckEvent EVENT_WEATHER_SANDSTORM
	jr z, .checkHail
; Sandstorm, player
	ld hl, wBattleMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp ROCK
	jr z, .sandstormCheckEnemy
	ld a, [hl]
	cp ROCK
	jr z, .sandstormCheckEnemy
; player damaged by Sandstorm
	call MakeTurnIntoPlayersTurn
	ld hl, HurtBySandstormText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BLINK_POKEMON
	call PlayAltAnimationCopy
	call HandleWeather_DecreasePlayerHP
	call RestoreRealTurn
; Sandstorm, enemy
.sandstormCheckEnemy
	ld hl, wEnemyMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp ROCK
	jr z, .noDamagingWeathers
	ld a, [hl]
	cp ROCK
	jr z, .noDamagingWeathers
; enemy damaged by Sandstorm
	call MakeTurnIntoEnemysTurn
	ld hl, HurtBySandstormText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BLINK_POKEMON
	call PlayAltAnimationCopy
	call HandleWeather_DecreaseEnemyHP
	call RestoreRealTurn
	jr .noDamagingWeathers
.checkHail
	CheckEvent EVENT_WEATHER_HAIL
	jr z, .noDamagingWeathers
; Hail, player
	ld hl, wBattleMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp ICE
	jr z, .hailCheckEnemy
	ld a, [hl]
	cp ICE
	jr z, .hailCheckEnemy
; player damaged by Hail
	call MakeTurnIntoPlayersTurn
	ld hl, HurtByHailText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BLINK_POKEMON
	call PlayAltAnimationCopy
	call HandleWeather_DecreasePlayerHP
	call RestoreRealTurn
; Hail, enemy
.hailCheckEnemy
	ld hl, wEnemyMonType1
	ld a, [hli] ; a=type1, hl->type2
	cp ROCK
	jr z, .noDamagingWeathers
	ld a, [hl]
	cp ROCK
	jr z, .noDamagingWeathers
; enemy damaged by Hail
	call MakeTurnIntoEnemysTurn
	ld hl, HurtByHailText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, BLINK_POKEMON
	call PlayAltAnimationCopy
	call HandleWeather_DecreaseEnemyHP
	call RestoreRealTurn
.noDamagingWeathers
	ResetEvent EVENT_ENABLE_WEATHER_DAMAGE
	pop hl
.dontHandleWeatherDamage
	pop af
; BTV

; back to vanilla
	add a
	jr nc, .notLeechSeeded
	push hl
	ldh a, [hWhoseTurn]
	push af
	xor $1
	ldh [hWhoseTurn], a
	xor a
	ld [wAnimationType], a
	ld a, ABSORB
	call PlayMoveAnimationCopyCopy ; play leech seed animation (from opposing mon) ; edited for moving this into its own file
	pop af
	ldh [hWhoseTurn], a
	pop hl
	call HandlePoisonBurnLeechSeed_DecreaseOwnHP
	call HandlePoisonBurnLeechSeed_IncreaseEnemyHP
	push hl
	ld hl, HurtByLeechSeedText
	call PrintText
	pop hl
.notLeechSeeded
	ld a, [hli]
	or [hl]
	ret nz          ; test if fainted
	callfar DrawHUDsAndHPBars ; edited into a callfar for moving this into its own file
	ld c, 20
	call DelayFrames
	xor a
	ret

HurtByPoisonText:
	text_far _HurtByPoisonText
	text_end

HurtByBurnText:
	text_far _HurtByBurnText
	text_end

HurtByLeechSeedText:
	text_far _HurtByLeechSeedText
	text_end

HurtByCurseText: ; new
	text_far _HurtByCurseText
	text_end

PikachuHealItself: ; new
	text_far _PikachuHealItself
	text_end

; decreases the mon's current HP by 1/8 (it was 1/16) of the Max HP (multiplied by number of toxic ticks if active)
; note that the toxic ticks are considered even if the damage is not poison (hence the Leech Seed glitch)
; hl: HP pointer
; bc (out): total damage
HandlePoisonBurnLeechSeed_DecreaseOwnHP:
	push hl
	push hl
	ld bc, $e      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c
	srl c         ; c = max HP/8 (assumption: HP < 1024)	new
;	srl c         ; c = max HP/16 (assumption: HP < 1024)
	ld a, c
	and a
	jr nz, .nonZeroDamage
	inc c         ; damage is at least 1
.nonZeroDamage
	ld hl, wPlayerBattleStatus3
	ld de, wPlayerToxicCounter
	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn
	ld hl, wEnemyBattleStatus3
	ld de, wEnemyToxicCounter
.playersTurn
	bit BADLY_POISONED, [hl]
	jr z, .noToxic
	ld a, [de]    ; increment toxic counter
	inc a
	ld [de], a
	ld hl, 0
.toxicTicksLoop
	add hl, bc
	dec a
	jr nz, .toxicTicksLoop
	ld b, h       ; bc = damage * toxic counter
	ld c, l
.noToxic
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
	call UpdateCurMonHPBar
	pop hl
	ret

HandleCurse_DecreaseOwnHP: ; new
	push hl
	push hl
	ld bc, $e      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c          ; bc = max HP/4 (assumption: HP < 1024)
;	srl c         ; c = max HP/8 (assumption: HP < 1024)
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
	call UpdateCurMonHPBar
	pop hl
	ret

; adds bc to enemy HP
; bc isn't updated if HP subtracted was capped to prevent overkill
HandlePoisonBurnLeechSeed_IncreaseEnemyHP:
	push hl
	ld hl, wEnemyMonMaxHP
	ldh a, [hWhoseTurn]
	and a
	jr z, .playersTurn
	ld hl, wBattleMonMaxHP
.playersTurn
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de           ; skip back from max hp to current hp
	ld a, [hl]
	ld [wHPBarOldHP], a ; add bc to current HP
	add c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	adc b
	ld [hli], a
	ld [wHPBarNewHP+1], a
	ld a, [wHPBarMaxHP]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wHPBarMaxHP+1]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .noOverfullHeal
	ld a, b                ; overfull heal, set HP to max HP
	ld [hli], a
	ld [wHPBarNewHP+1], a
	ld a, c
	ld [hl], a
	ld [wHPBarNewHP], a
.noOverfullHeal
	ldh a, [hWhoseTurn]
	xor $1
	ldh [hWhoseTurn], a
	call UpdateCurMonHPBar
	ldh a, [hWhoseTurn]
	xor $1
	ldh [hWhoseTurn], a
	pop hl
	ret

UpdateCurMonHPBar::
	hlcoord 10, 9    ; tile pointer to player HP bar
	ldh a, [hWhoseTurn]
	and a
	ld a, $1
	jr z, .playersTurn
	hlcoord 2, 2    ; tile pointer to enemy HP bar
	xor a
.playersTurn
	push bc ; really necessary now?
	ld [wHPBarType], a
	predef UpdateHPBar2
	pop bc ; really necessary now?
	ret

; ========== new functions ====================================================================

HandleWeatherCounter:
	ld hl, wWeatherCounterPlayer
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	jr z, .playersTurn
	ld hl, wWeatherCounterEnemy
.playersTurn
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
; check if there are turns left, and print a message accordingly
	jr z, .noTurnsLeft
; but don't print it the first turn
	cp 4
	ret z
	ld hl, WeatherSunnyDayStillText
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	jr nz, .printAndEnd
	ld hl, WeatherRainDanceStillText
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	jr nz, .printAndEnd
	ld hl, WeatherSandstormStillText
	CheckEvent EVENT_WEATHER_SANDSTORM
	jr nz, .printAndEnd
	ld hl, WeatherHailStillText
.printAndEnd
	call PrintText
	ret
.noTurnsLeft
	ResetEvent EVENT_WEATHER_SUNNY_DAY
	ResetEvent EVENT_WEATHER_RAIN_DANCE
	ResetEvent EVENT_WEATHER_SANDSTORM
	ResetEvent EVENT_WEATHER_HAIL
	ld hl, WeatherBackToNormalText
	call PrintText
	ret

WeatherSunnyDayStillText:
	text_far _WeatherSunnyDayStillText
	text_end

WeatherRainDanceStillText:
	text_far _WeatherRainDanceStillText
	text_end

WeatherSandstormStillText:
	text_far _WeatherSandstormStillText
	text_end

WeatherHailStillText:
	text_far _WeatherHailStillText
	text_end

WeatherBackToNormalText:
	text_far _WeatherBackToNormalText
	text_end

HandleWeather_DecreasePlayerHP:
	ld hl, wBattleMonHP
	jr HandleWeather_DecreaseEnemyHP.mainStuff
HandleWeather_DecreaseEnemyHP:
	ld hl, wEnemyMonHP
.mainStuff
	push hl
	ld bc, $e      ; skip to max HP
	add hl, bc
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c          ; bc = max HP/4 (assumption: HP < 1024)
	srl c         ; c = max HP/8 (assumption: HP < 1024)
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
	call UpdateCurMonHPBar
	ret

HurtBySandstormText:
	text_far _HurtBySandstormText
	text_end

HurtByHailText:
	text_far _HurtByHailText
	text_end

;SwapTurns: ; has always to be used twice
;	ldh a, [hWhoseTurn]
;	and a
;	jr z, .currentlyPlayersTurn
;; currently enemy's turn
;	dec a
;	jr .conclude
;.currentlyPlayersTurn
;	inc a
;.conclude
;	ldh [hWhoseTurn], a
;	ret

MakeTurnIntoPlayersTurn::
	ldh a, [hWhoseTurn]
	ld [wStoreRealhWhoseTurn], a
	xor a
	ldh [hWhoseTurn], a
	ret

MakeTurnIntoEnemysTurn::
	ldh a, [hWhoseTurn]
	ld [wStoreRealhWhoseTurn], a
	ld a, 1
	ldh [hWhoseTurn], a
	ret

RestoreRealTurn::
	ld a, [wStoreRealhWhoseTurn]
	ldh [hWhoseTurn], a
	ret

HandleTerrainCounter:
	ld hl, wTerrainCounterPlayer
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	jr z, .playersTurn
	ld hl, wTerrainCounterEnemy
.playersTurn
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
; check if there are turns left, and print a message accordingly
	jr z, .noTurnsLeft
; but don't print it the first turn
	cp 4
	ret z
	ld hl, TerrainGrassyStillText
	CheckEvent EVENT_TERRAIN_GRASSY
	jr nz, .printAndEnd
	ld hl, TerrainElectricStillText
	CheckEvent EVENT_TERRAIN_ELECTRIC
	jr nz, .printAndEnd
	ld hl, TerrainMistyStillText
	CheckEvent EVENT_TERRAIN_MISTY
	jr nz, .printAndEnd
	ld hl, TerrainPsychichStillText
.printAndEnd
	call PrintText
	ret
.noTurnsLeft
	ResetEvent EVENT_TERRAIN_GRASSY
	ResetEvent EVENT_TERRAIN_ELECTRIC
	ResetEvent EVENT_TERRAIN_MISTY
	ResetEvent EVENT_TERRAIN_PSYCHIC
	ld hl, TerrainBackToNormalText
	call PrintText
	ret

TerrainGrassyStillText:
	text_far _TerrainGrassyStillText
	text_end

TerrainElectricStillText:
	text_far _TerrainElectricStillText
	text_end

TerrainMistyStillText:
	text_far _TerrainMistyStillText
	text_end

TerrainPsychichStillText:
	text_far _TerrainPsychichStillText
	text_end

TerrainBackToNormalText:
	text_far _TerrainBackToNormalText
	text_end

HandleTerrain_IncreasePlayerHP:
	ld hl, wBattleMonMaxHP
	jr HandleTerrain_IncreaseEnemyHP.mainStuff
HandleTerrain_IncreaseEnemyHP:
	ld hl, wEnemyMonMaxHP
.mainStuff
	push hl
	ld a, [hli]    ; load max HP
	ld [wHPBarMaxHP+1], a
	ld b, a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld c, a
	srl b
	rr c
	srl b
	rr c          ; bc = max HP/4 (assumption: HP < 1024)
	srl c         ; c = max HP/8 (assumption: HP < 1024)
	srl c         ; c = max HP/16 (assumption: HP < 1024)
	ld a, c
	and a
	jr nz, .nonZeroHealing
	inc c         ; healing is at least 1
; now bc should hold 1/16th of the active mon's max HP
; unnecessary to consider b as it will surely be 0 but whatever
.nonZeroHealing
	pop hl
	ld a, [hli]
	ld [wHPBarMaxHP+1], a
	ld a, [hl]
	ld [wHPBarMaxHP], a
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de           ; skip back from max hp to current hp
; add the healed amount to the current HP (and the current HP bar)
	ld a, [hl]
	ld [wHPBarOldHP], a ; add bc to current HP
	add c
	ld [hld], a
	ld [wHPBarNewHP], a
	ld a, [hl]
	ld [wHPBarOldHP+1], a
	adc b
	ld [hli], a
	ld [wHPBarNewHP+1], a
; check if we overhealed
	ld a, [wHPBarMaxHP]
	ld c, a
	ld a, [hld]
	sub c
	ld a, [wHPBarMaxHP+1]
	ld b, a
	ld a, [hl]
	sbc b
	jr c, .noOverfullHeal
; we overhealed
	ld a, b                ; overfull heal, set HP to max HP
	ld [hli], a
	ld [wHPBarNewHP+1], a
	ld a, c
	ld [hl], a
	ld [wHPBarNewHP], a
.noOverfullHeal
	call UpdateCurMonHPBar
	ret

HealedByGrassyTerrainText::
	text_far _HealedByGrassyTerrainText
	text_end

HandleTrickRoomCounter:
	ld hl, wTrickRoomCounterPlayer
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	jr z, .playersTurn
	ld hl, wTrickRoomCounterEnemy
.playersTurn
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
; check if there are turns left, and print a message accordingly
	jr z, .noTurnsLeft
; but don't print it the first turn
	cp 4
	ret z
	ld hl, TrickRoomStillActiveText
	call PrintText
	ret
.noTurnsLeft
	ResetEvent EVENT_TRICK_ROOM
	ld hl, TrickRoomExpiredText
	call PrintText
	ret

TrickRoomStillActiveText:
	text_far _TrickRoomStillActiveText
	text_end

TrickRoomExpiredText:
	text_far _TrickRoomExpiredText
	text_end

; ---------- ugly copies of functions for moving this into its own file -----------------------

PlayMoveAnimationCopyCopy::
	ld [wAnimationID], a ; edited
	call Delay3
;	xor a
;	ld [wAltAnimationID], a
	predef MoveAnimation
	callfar Func_78e98
	ret

PlayAltAnimationCopy::
	ld [wAltAnimationID], a
	predef_jump MoveAnimation
