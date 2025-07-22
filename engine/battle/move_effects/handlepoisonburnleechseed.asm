HandlePoisonBurnLeechSeed::
	call HandleWeatherCounter ; new, to handle weather counter
	                          ; but only if the current mon did not KO its opponent
	                          ; that's why it's here
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
	ldh a, [hWhoseTurn]
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
	push bc
	ld [wHPBarType], a
	predef UpdateHPBar2
	pop bc
	ret

; ========== new functions ====================================================================

HandleWeatherCounter: ; new, testing
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

WeatherSunnyDayStillText: ; new
	text_far _WeatherSunnyDayStillText
	text_end

WeatherRainDanceStillText: ; new
	text_far _WeatherRainDanceStillText
	text_end

WeatherSandstormStillText: ; new
	text_far _WeatherSandstormStillText
	text_end

WeatherHailStillText: ; new
	text_far _WeatherHailStillText
	text_end

WeatherBackToNormalText: ; new
	text_far _WeatherBackToNormalText
	text_end

; ---------- ugly copies of functions for moving this into its own file -----------------------

PlayMoveAnimationCopyCopy:
	ld [wAltAnimationID], a ; edited
	call Delay3
	predef MoveAnimation
	callfar Func_78e98
	ret

PlayAltAnimationCopy:
	ld [wAltAnimationID], a
	predef_jump MoveAnimation
