; if a hidden object was found, stores $00 in [hDidntFindAnyHiddenObject], else stores $ff
CheckForHiddenObject::
	ld hl, hItemAlreadyFound
	xor a
	ld [hli], a ; [hItemAlreadyFound]
	ld [hli], a ; [hSavedMapTextPtr]
	ld [hli], a ; [hSavedMapTextPtr + 1]
	ld [hl], a  ; [hDidntFindAnyHiddenObject]
	ld hl, HiddenObjectMaps
; new, for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .continue
	ld hl, HiddenObjectMaps_Sevii
.continue
; back to vanilla
	ld de, 3
	ld a, [wCurMap]
	call IsInArray
	jr nc, .noMatch
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	push hl
	ld hl, wHiddenObjectFunctionArgument
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
.hiddenObjectLoop
	ld a, [hli]
	cp $ff
	jr z, .noMatch
	ld [wHiddenObjectY], a
	ld b, a
	ld a, [hli]
	ld [wHiddenObjectX], a
	ld c, a
	call CheckIfCoordsInFrontOfPlayerMatch
	ldh a, [hCoordsInFrontOfPlayerMatch]
	and a
	jr z, .foundMatchingObject
	inc hl
	inc hl
	inc hl
	inc hl
	push hl
	ld hl, wHiddenObjectIndex
	inc [hl]
	pop hl
	jr .hiddenObjectLoop
.foundMatchingObject
	ld a, [hli]
	ld [wHiddenObjectFunctionArgument], a
	ld a, [hli]
	ld [wHiddenObjectFunctionRomBank], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
.noMatch
	ld a, $ff
	ldh [hDidntFindAnyHiddenObject], a
	ret

; checks if the coordinates in front of the player's sprite match Y in b and X in c
; [hCoordsInFrontOfPlayerMatch] = $00 if they match, $ff if they don't match
CheckIfCoordsInFrontOfPlayerMatch:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jr z, .facingUp
	cp SPRITE_FACING_LEFT
	jr z, .facingLeft
	cp SPRITE_FACING_RIGHT
	jr z, .facingRight
; facing down
	ld a, [wYCoord]
	inc a
	jr .upDownCommon
.facingUp
	ld a, [wYCoord]
	dec a
.upDownCommon
	cp b
	jr nz, .didNotMatch
	ld a, [wXCoord]
	cp c
	jr nz, .didNotMatch
	jr .matched
.facingLeft
	ld a, [wXCoord]
	dec a
	jr .leftRightCommon
.facingRight
	ld a, [wXCoord]
	inc a
.leftRightCommon
	cp c
	jr nz, .didNotMatch
	ld a, [wYCoord]
	cp b
	jr nz, .didNotMatch
.matched
	xor a
	jr .done
.didNotMatch
	ld a, $ff
.done
	ldh [hCoordsInFrontOfPlayerMatch], a
	ret

INCLUDE "data/events/hidden_objects.asm"
INCLUDE "data/events/hidden_objects_sevii.asm"
