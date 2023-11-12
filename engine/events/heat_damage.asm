ApplyHeatDamage:
	ld a, [wCurMap]
	cp CINNABAR_ISLAND ; will be CINNABAR_VOLCANO
	ret nz ; do nothing at all if it's not the map of interest
	ret ; will be removed

	ld a, [wd730]
	add a
	jp c, .noBlackOut ; no black out if joypad states are being simulated
	ld a, [wd492]
	bit 7, a
	jp nz, .noBlackOut ; what is this for?
	ld a, [wd72e]
	bit 6, a
	jp nz, .noBlackOut ; what is this for?
	ld a, [wPartyCount]
	and a
	jp z, .noBlackOut
	xor a
	ld [wWhichPokemon], a
	ld hl, wPartyMon1Status
	ld de, wPartySpecies
.applyDamageLoop
; check if the mon is FIRE type or RHYDON/RHYPERIOR, and if so, don't inflict damage
	ld a, [de]
	cp RHYDON
	jr z, .nextMon2
	cp RHYPERIOR
	jr z, .nextMon2
	ld [wd0b5], a
	push hl
	call GetMonHeader
	pop hl
	ld a, [wMonHType1]
	cp FIRE
	jr z, .nextMon2
	ld a, [wMonHType2]
	cp FIRE
	jr z, .nextMon2
	ld a, [hl]
	dec hl
	dec hl
	ld a, [hld]
	ld b, a
	ld a, [hli]
	or b
	jr z, .nextMon ; already fainted
; subtract 1 from HP
	ld a, [hl]
	dec a
	ld [hld], a
	inc a
	jr nz, .noBorrow
; borrow 1 from upper byte of HP
	dec [hl]
	inc hl
	jr .nextMon
.noBorrow
	ld a, [hli]
	or [hl]
	jr nz, .nextMon ; didn't faint from damage
; the mon fainted from the damage
	push hl
	inc hl
	inc hl
	ld [hl], a
	ld a, [de]
	ld [wd11e], a
	push de
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	xor a
	ld [wJoyIgnore], a
	call EnableAutoTextBoxDrawing
	ld a, TEXT_MON_FAINTED
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	callfar IsThisPartymonStarterPikachu_Party
	jr nc, .curMonNotPlayerPikachu
	ld e, $3
	callfar PlayPikachuSoundClip
	calladb_ModifyPikachuHappiness PIKAHAPPY_PSNFNT
.curMonNotPlayerPikachu
	pop de
	pop hl
.nextMon
	inc hl
	inc hl
.nextMon2
	inc de
	ld a, [de]
	inc a
	jr z, .applyDamageLoopDone
	ld bc, wPartyMon2 - wPartyMon1
	add hl, bc
	push hl
	ld hl, wWhichPokemon
	inc [hl]
	pop hl
	jp .applyDamageLoop
.applyDamageLoopDone
	predef AnyPartyAlive
	ld a, d
	and a
	jr nz, .noBlackOut
	call EnableAutoTextBoxDrawing
	ld a, TEXT_BLACKED_OUT
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72e
	set 5, [hl]
	ld a, $ff
	jr .done
.noBlackOut
	xor a
.done
	ld [wOutOfBattleBlackout], a
	ret
