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
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_2
	jr nz, .doorsOpenM2
	ld a, $5B ; not openable door block ID
	jr .replaceBlockM2
.doorsOpenM2
	ld a, $14 ; openable door block ID
.replaceBlockM2
	ld [wNewTileBlockID], a
	lb bc, 16,  7 ; y-x block coordinates
	predef ReplaceTileBlock

; mid floor, room 5
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_5
	jr nz, .doorsOpenM5
	ld a, $5A ; not openable door block ID
	jr .replaceBlockM5
.doorsOpenM5
	ld a, $19 ; openable door block ID
.replaceBlockM5
	ld [wNewTileBlockID], a
	lb bc, 23,  4 ; y-x block coordinates
	predef ReplaceTileBlock

; bottom floor, room 2
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_2
	jr nz, .doorsOpenB2
	ld a, $5B ; not openable door block ID
	jr .replaceBlockB2
.doorsOpenB2
	ld a, $14 ; openable door block ID
.replaceBlockB2
	ld [wNewTileBlockID], a
	lb bc, 30,  7 ; y-x block coordinates
	predef ReplaceTileBlock

; bottom floor, room 8
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	jr nz, .doorsOpenB8
	ld a, $5A ; not openable door block ID
	jr .replaceBlockB8
.doorsOpenB8
	ld a, $19 ; openable door block ID
.replaceBlockB8
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

SunkenShipTheLockOpenedText:
	text_far _SunkenShipTheLockOpenedText
	text_end

; top floor --------------------

LockedDoorText_TopFloorRoom4: ; TBE
LockedDoorText_TopFloorRoom7: ; TBE
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_TOP_ROOM_4
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; require key
	ld b, ROOM_KEY_34 ; (door-dependent)
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SunkenShipLockedDoorTopFloorText
	jr z, .printAndEnd
.haveKey
; let's open the door and remove the key
	ld hl, SunkenShipTheKeyWorksText
	call PrintText
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, ROOM_KEY_34 ; (door-dependent)
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_TOP_ROOM_4
	ld a, $14 ; openable door block ID (door-dependent) ; 14/19
	ld [wNewTileBlockID], a
	lb bc,  2, 16 ; (door-dependent)
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd

SunkenShipLockedDoorTopFloorText:
	text_far _SunkenShipLockedDoorTopFloorText
	text_end

SunkenShipTheKeyWorksText:
	text_far _SunkenShipTheKeyWorksText
	text_end

; mid floor --------------------

LockedDoorText_MidFloorRoom2:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_2
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; requires password
	call SaveScreenTilesToBuffer2
	ld hl, SunkenShipLockedDoorMidFloorText
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer ; (door-dependent)
	ld a, [wUniQuizAnswer]
	cp "A"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "L"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "L"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld c, BANK(SFX_Denied_1)
	ld a, SFX_DENIED
	call PlayMusic
	ld hl, SunkenShipWrongPasswordText
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_2
	ld a, $14 ; openable door block ID (door-dependent) ; 14/19
	ld [wNewTileBlockID], a
	lb bc, 16,  7 ; y-x block coordinates (door-dependent)
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd

LockedDoorText_MidFloorRoom5:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_5
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; requires password
	call SaveScreenTilesToBuffer2
	ld hl, SunkenShipLockedDoorMidFloorText
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer ; (door-dependent)
	ld a, [wUniQuizAnswer]
	cp "H"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "E"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "L"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld c, BANK(SFX_Denied_1)
	ld a, SFX_DENIED
	call PlayMusic
	ld hl, SunkenShipWrongPasswordText
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_MID_ROOM_5
	ld a, $19 ; openable door block ID (door-dependent) ; 14/19
	ld [wNewTileBlockID], a
	lb bc, 23,  4 ; y-x block coordinates (door-dependent)
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd

SunkenShipLockedDoorMidFloorText:
	text_far _SunkenShipLockedDoorMidFloorText
	text_end

SunkenShipWrongPasswordText:
	text_far _SunkenShipWrongPasswordText
	text_end

; bottom floor --------------------

LockedDoorText_BottomFloorRoom2:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_2
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; door is still locked
	call InsertCombinationCommonBottomFloor
; check if combination is correct (door-dependent)
	ld a, [wUniQuizAnswer]
	cp 1 ; LEFT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp 1 ; LEFT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp 0 ; RIGHT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp 1 ; LEFT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+4]
	cp 0 ; RIGHT
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+5]
	cp 2 ; PULL
	jr z, .rightAnswer
.wrongAnswer
	ld c, BANK(SFX_Denied_1)
	ld a, SFX_DENIED
	call PlayMusic
	ld hl, SunkenShipWrongCombinationText
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_2
	ld a, $14 ; openable door block ID (door-dependent)
	ld [wNewTileBlockID], a
	lb bc, 30,  7 ; y-x block coordinates (door-dependent)
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd

LockedDoorText_BottomFloorRoom8:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	ld hl, DoorIsAlreadyUnlockedText
	jr nz, .printAndEnd
; door is still locked
	call InsertCombinationCommonBottomFloor
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
	ld c, BANK(SFX_Denied_1)
	ld a, SFX_DENIED
	call PlayMusic
	ld hl, SunkenShipWrongCombinationText
	jr .printAndEnd
.rightAnswer
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SUNKEN_SHIP_OPENED_DOOR_BOTTOM_ROOM_8
	ld a, $19 ; openable door block ID (door-dependent)
	ld [wNewTileBlockID], a
	lb bc, 37, 16 ; y-x block coordinates (door-dependent)
	predef ReplaceTileBlock
	ld hl, SunkenShipTheLockOpenedText
.printAndEnd
	call PrintText
	jp TextScriptEnd

InsertCombinationCommonBottomFloor:
	ld a, 9 ; maximum combination length
	ld [wBuffer], a
	ld de, wUniQuizAnswer
	push de
	call SaveScreenTilesToBuffer2
	ld hl, SunkenShipLockedDoorBottomFloorText
	call PrintText
.combinationLoop
	ld hl, SunkenShipWhatToDoText
	call PrintText
	call CombinationLockMoveChoice
	ld a, [wCurrentMenuItem]
	cp 2
	jr z, .combinationDone
; register inputted turn and return to the loop unless we performed the 9th rotation
	pop de
	ld [de], a
	inc de
	push de
; check if we did the 9th rotation
	ld a, [wBuffer]
	dec a
	and a
	jr z, .preCombinationDone
	ld [wBuffer], a
	jr .combinationLoop
.preCombinationDone
	ld a, 2
.combinationDone
	pop de
	ld [de], a
	ret

SunkenShipWrongCombinationText:
	text_far _SunkenShipWrongCombinationText
	text_end

SunkenShipLockedDoorBottomFloorText:
	text_far _SunkenShipLockedDoorBottomFloorText
	text_end

SunkenShipWhatToDoText:
	text_far _SunkenShipWhatToDoText
	text_end
