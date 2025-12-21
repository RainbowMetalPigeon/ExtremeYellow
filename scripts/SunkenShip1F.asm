SunkenShip1F_Script:
	call SunkenShipHandleUnlockedDoors
	call EnableAutoTextBoxDrawing
	ret

; scripts ====================================================

SunkenShipHandleUnlockedDoors:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; top floor, room 4
; top floor, room 7
; mid floor, room 2
; mid floor, room 5
; bottom floor, room 2
; bottom floor, room 8
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	jr nz, .doorsOpen
	ld a, $5A ; not openable door block ID
	jr .replaceBlock
.doorsOpen
	ld a, $19 ; openable door block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 37, 16 ; y-x block coordinates
	predef_jump ReplaceTileBlock

; displays turn-combination lock choice
CombinationLockMoveChoice:
	call SaveScreenTilesToBuffer1
	ld a, COMBINATION_LOCK_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 7
	ld [hli], a ; top menu item Y
	ld a, 8
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 2 ; number of options - 1
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 2
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; texts ====================================================

SunkenShip1F_TextPointers:
	; top floor
	dw LockedDoorText_TopFloorRoom4
	dw DoorCantBeOpenedText
	dw DoorCantBeOpenedText
	dw LockedDoorText_TopFloorRoom7
	; mid floor
	dw LockedDoorText_MidFloorRoom2
	dw DoorCantBeOpenedText
	dw LockedDoorText_MidFloorRoom5
	dw DoorCantBeOpenedText
	; bottom floor
	dw DoorCantBeOpenedText
	dw LockedDoorText_BottomFloorRoom2
	dw DoorCantBeOpenedText
	dw DoorCantBeOpenedText
	dw LockedDoorText_BottomFloorRoom8

DoorCantBeOpenedText:
	text_far _DoorCantBeOpenedText
	text_end

DoorIsAlreadyUnlockedText:
	text_far _DoorIsAlreadyUnlockedText
	text_end

SunkenShipWrongPasswordText:
	text_far _SunkenShipWrongPasswordText
	text_end

SunkenShipWrongCombinationText:
	text_far _SunkenShipWrongCombinationText
	text_end

SunkenShipTheLockOpenedText:
	text_far _SunkenShipTheLockOpenedText
	text_end

SunkenShipLockedDoorBottomFloorText:
	text_far _SunkenShipLockedDoorBottomFloorText
	text_end

SunkenShipWhatToDoText:
	text_far _SunkenShipWhatToDoText
	text_end




LockedDoorText_TopFloorRoom4: ; TBE
	text_far _LockedDoorText_TopFloorRoom4
	text_end

LockedDoorText_TopFloorRoom7: ; TBE
	text_far _LockedDoorText_TopFloorRoom7
	text_end

LockedDoorText_MidFloorRoom2: ; TBE
	text_far _LockedDoorText_MidFloorRoom2
	text_end

LockedDoorText_MidFloorRoom5: ; TBE
	text_far _LockedDoorText_MidFloorRoom5
	text_end

LockedDoorText_BottomFloorRoom2:
LockedDoorText_BottomFloorRoom8: ; TBE
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; door is still locked
	ld de, wUniQuizAnswer
	push de
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SunkenShipLockedDoorBottomFloorText
	call PrintText
.combinationLoop
	ld hl, SunkenShipWhatToDoText
	call PrintText
	call CombinationLockMoveChoice
	ld a, [wCurrentMenuItem]
	cp 2
	jr z, .combinationDone
; register inputted turn and return to the loop
	pop de
	ld [de], a
	inc de
	push de
	jr .combinationLoop
.combinationDone
	pop de
	ld [de], a
; check if combination is correct (door-dependent)

	ld a, [wUniQuizAnswer]
	cp 0 ; RIGHT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp 0 ; RIGHT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp 1 ; LEFT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp 2 ; PULL
	jr z, .rightAnswer

.wrongAnswer
	ld a, SFX_DENIED
	call PlaySound
	ld hl, SunkenShipWrongCombinationText
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	ld a, $19 ; openable door block ID
	ld [wNewTileBlockID], a
	lb bc, 37, 16 ; y-x block coordinates
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd
