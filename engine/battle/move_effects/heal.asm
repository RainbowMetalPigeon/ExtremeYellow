HealEffect_:
	ldh a, [hWhoseTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveNum]
	jr z, .healEffect
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveNum]
.healEffect
	ld b, a
	ld [wAnotherTemporaryStorageVariable], a ; new
	ld a, [de]
	cp [hl] ; most significant bytes comparison is ignored
	        ; causes the move to miss if max HP is 255 or 511 points higher than the current HP
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, .failed ; no effect if user's HP is already at its maximum
	ld a, b
	cp REST
	jr nz, .healHP
; it is indeed rest
	push hl
	push de
	push af
; new to check terrains
	call CheckIfTurnPokemonIsFlying ; z flag = FLYING
	jr z, .ignoreTerrain
	CheckEvent EVENT_TERRAIN_ELECTRIC
	jr nz, .terrainPrevents
	CheckEvent EVENT_TERRAIN_MISTY
	jr z, .ignoreTerrain
.terrainPrevents
	ld c, 50
	call DelayFrames
	ld hl, TheTerrainPreventsText
	call PrintText
	pop af
	pop de
	pop hl
	ret
.ignoreTerrain
; BTV
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonStatus
	ldh a, [hWhoseTurn]
	and a
	jr z, .restEffect
	ld hl, wEnemyMonStatus
.restEffect
	ld a, [hl]
	and a
	ld [hl], 2 ; clear status and set number of turns asleep to 2
	ld hl, StartedSleepingEffect ; if mon didn't have a status
	jr z, .printRestText
	ld hl, FellAsleepBecameHealthyText ; if mon had a status
.printRestText
	call PrintText
	pop af
	pop de
	pop hl

; edited for Synthesis
.healHP
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP+1], a
	ld b, a
; now bc contains the max HP
	ld a, [wAnotherTemporaryStorageVariable] ; move ID
	cp SYNTHESIS
	jr z, .synthesis
	cp REST
	jr z, .updateHP ; edited
	jr .halveBC
.synthesis
	push hl
	CheckEvent EVENT_WEATHER_SUNNY_DAY
	pop hl
	jr nz, .moreHealing
	push hl
	CheckEvent EVENT_WEATHER_HAIL
	pop hl
	jr nz, .lessHealing
	push hl
	CheckEvent EVENT_WEATHER_SANDSTORM
	pop hl
	jr nz, .lessHealing
	push hl
	CheckEvent EVENT_WEATHER_RAIN_DANCE
	pop hl
	jr nz, .lessHealing
.halveBC
; Recover and Softboiled (and Roost) only heal for half the mon's max HP
	srl b
	rr c
	jr .updateHP ; edited
.moreHealing
	push hl
	srl b
	rr c
	ld h, b
	ld l, c
	srl b
	rr c
	add hl, bc
	ld b, h
	ld c, l
	pop hl
	jr .updateHP
.lessHealing
	srl b
	rr c
	srl b
	rr c
; BTV

.updateHP ; new label
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wHPBarOldHP+1], a
	adc b
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc hl
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .playAnim
; copy max HP to current HP if an overflow occurred
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP+1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a
.playAnim
	ld hl, PlayCurrentMoveAnimation
	call EffectCallBattleCore
	ldh a, [hWhoseTurn]
	and a
	hlcoord 10, 9
	ld a, $1
	jr z, .updateHPBar
	hlcoord 2, 2
	xor a
.updateHPBar
	ld [wHPBarType], a
	predef UpdateHPBar2
	ld hl, DrawHUDsAndHPBars
	call EffectCallBattleCore
	ld hl, RegainedHealthText
	jp PrintText
.failed
	ld c, 50
	call DelayFrames
	ld hl, PrintButItFailedText_
	jp EffectCallBattleCore

StartedSleepingEffect:
	text_far _StartedSleepingEffect
	text_end

FellAsleepBecameHealthyText:
	text_far _FellAsleepBecameHealthyText
	text_end

RegainedHealthText:
	text_far _RegainedHealthText
	text_end
