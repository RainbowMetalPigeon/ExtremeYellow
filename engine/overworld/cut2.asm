AnimCut:
	ld a, [wCutTile]
	cp $52
	jr z, .grass
	ld c, $8
.cutTreeLoop
	push bc
	ld hl, wShadowOAMSprite36XCoord
	ld a, 1
	ld [wCoordAdjustmentAmount], a
	ld c, 2
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ld hl, wShadowOAMSprite38XCoord
	ld a, -1
	ld [wCoordAdjustmentAmount], a
	ld c, 2
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ldh a, [rOBP1]
	xor $64
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call DelayFrame
	pop bc
	dec c
	jr nz, .cutTreeLoop
	ret
.grass
	ld c, 2
.cutGrassLoop
	push bc
	ld c, $8
	call AnimCutGrass_UpdateOAMEntries
	call AnimCutGrass_SwapOAMEntries
	ld c, $8
	call AnimCutGrass_UpdateOAMEntries
	call AnimCutGrass_SwapOAMEntries
	ld hl, wShadowOAMSprite36YCoord
	ld a, 2
	ld [wCoordAdjustmentAmount], a
	ld c, 4
	call AdjustOAMBlockYPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	pop bc
	dec c
	jr nz, .cutGrassLoop
	ret

AnimCutGrass_UpdateOAMEntries:
	push bc
	ld hl, wShadowOAMSprite36XCoord
	ld a, 1
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ld hl, wShadowOAMSprite37XCoord
	ld a, 2
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ld hl, wShadowOAMSprite38XCoord
	ld a, -2
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ld hl, wShadowOAMSprite39XCoord
	ld a, -1
	ld [wCoordAdjustmentAmount], a
	ld c, 1
	call AdjustOAMBlockXPos2Copy	; modified, using the copied functions, no longer in the same bank as the original
	ldh a, [rOBP1]
	xor $64
	ldh [rOBP1], a
	call UpdateGBCPal_OBP1
	call DelayFrame
	pop bc
	dec c
	jr nz, AnimCutGrass_UpdateOAMEntries
	ret

AnimCutGrass_SwapOAMEntries:
	ld hl, wShadowOAMSprite36
	ld de, wBuffer
	ld bc, $8
	call CopyData
	ld hl, wShadowOAMSprite38
	ld de, wShadowOAMSprite36
	ld bc, $8
	call CopyData
	ld hl, wBuffer
	ld de, wShadowOAMSprite38
	ld bc, $8
	jp CopyData

; New: functions copied from engine/battle/animations.asm because they are no longer in the same bank

AdjustOAMBlockXPosCopy:
	ld l, e
	ld h, d

AdjustOAMBlockXPos2Copy:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 168
	jr c, .skipPuttingEntryOffScreen
; put off-screen if X >= 168
	dec hl
	ld a, 160
	ld [hli], a
.skipPuttingEntryOffScreen
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

AdjustOAMBlockYPosCopy:
	ld l, e
	ld h, d

AdjustOAMBlockYPos2Copy:
	ld de, 4
.loop
	ld a, [wCoordAdjustmentAmount]
	ld b, a
	ld a, [hl]
	add b
	cp 112
	jr c, .skipSettingPreviousEntrysAttribute
	dec hl
	ld a, 160 ; bug, sets previous OAM entry's attribute
	ld [hli], a
.skipSettingPreviousEntrysAttribute
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret
