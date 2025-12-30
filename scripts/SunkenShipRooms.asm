SunkenShipRooms_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SunkenShipRooms_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call CallFunctionInTable
	ret

; scripts =========================================

SunkenShipRooms_ScriptPointers:
	dw SunkenShipRoomsScript0

SunkenShipRoomsScript0:
; check if A button is pressed
	ldh a, [hJoyHeld]
	bit BIT_A_BUTTON, a
	ret z
; check coordinates and facings
	call CheckIfCoordinateWithlore ; carry flag set if match found, and a contains textID
	ret nc
	add 9 ; starting point of the IDs of the lores texts IDs
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

CheckIfCoordinateWithlore:
; scf if match is found
; output: textID OFFSET in register a
	ld a, [wXCoord]
	ld b, a ; b holds current X coordinate
	ld a, [wYCoord]
	ld c, a ; c holds current Y coordinate
	ld a, [wSpritePlayerStateData1FacingDirection]
	ld e, a ; e holds current facing
	ld hl, CoordinatesForLoreTextsIDs
	ld d, $FF ; initial offset, loaded in a at the end
.loop
	inc d ; it's now 0 at the first iteration of the loop
	ld a, [hli] ; a = lore X, hl points to lore Y
	cp $FF ; terminator
	jr z, .noMatches
	cp b ; are we at a X with a lore?
	jr nz, .next1
	ld a, [hli] ; a = lore Y, hl points to lore facing
	cp c ; are we (also) at a Y with a lore?
	jr nz, .next2
	ld a, [hli] ; a = lore facing, hl points to the NEXT lore X
	cp e ; are we (also also) facing correctly?
	jr nz, .loop
	ld a, d ; now it's a that contains the lore textIDs OFFSET
	scf
	ret
.next1
	inc hl
.next2
	inc hl
	jr .loop
.noMatches
	xor a
	ret

CoordinatesForLoreTextsIDs:
; x, y, facing
    db 12, 18, SPRITE_FACING_DOWN ; room 1-2
    db 13, 19, SPRITE_FACING_LEFT ; room 1-2
    db 24, 18, SPRITE_FACING_DOWN ; room 1-3
    db 25, 19, SPRITE_FACING_LEFT ; room 1-3
    db 37, 25, SPRITE_FACING_LEFT ; room 1-8
    db 36, 26, SPRITE_FACING_UP   ; room 1-8
    db  0, 42, SPRITE_FACING_DOWN ; room 2-1
    db  1, 43, SPRITE_FACING_LEFT ; room 2-1
    db 12, 42, SPRITE_FACING_DOWN ; room 2-2
    db 13, 43, SPRITE_FACING_LEFT ; room 2-2
    db 13, 49, SPRITE_FACING_LEFT ; room 2-6
    db 12, 50, SPRITE_FACING_UP   ; room 2-6
    db 37, 49, SPRITE_FACING_LEFT ; room 2-8
    db 36, 50, SPRITE_FACING_UP   ; room 2-8
    db 24, 66, SPRITE_FACING_DOWN ; room 3-3
    db 25, 67, SPRITE_FACING_LEFT ; room 3-3
    db 36, 66, SPRITE_FACING_DOWN ; room 3-4
    db 37, 67, SPRITE_FACING_LEFT ; room 3-4
    db 25, 73, SPRITE_FACING_LEFT ; room 3-7
    db 24, 74, SPRITE_FACING_UP   ; room 3-7
    db 26, 61, SPRITE_FACING_UP   ; broken door
	db $FF ; end

; texts =========================================

SunkenShipRooms_TextPointers:
	; top floor
	dw GiveCombination12Text      ;  1
	dw GiveRoomKey34Text          ;  2
	; mid floor
	dw GiveCombination18Text      ;  3
	dw GiveRoomKey37Text          ;  4
	; bottom floor
	dw GivePassword25Text         ;  5
	dw GivePassword22Text         ;  6
	; captain's room
	dw GiveSunkenShipTreasureText ;  7
	dw SunkenShipCaptainsLogText  ;  8

	; lore, most if not all will be duplicated
	dw SunkenShipLoreText_12      ;  9, starting point of the lores texts IDs <-> OFFSET = 0
	dw SunkenShipLoreText_12      ; 10
	dw SunkenShipLoreText_13      ; 11
	dw SunkenShipLoreText_13      ; 12
	dw SunkenShipLoreText_18      ; 13
	dw SunkenShipLoreText_18      ; 14
	dw SunkenShipLoreText_21      ; 15
	dw SunkenShipLoreText_21      ; 16
	dw SunkenShipLoreText_22      ; 17
	dw SunkenShipLoreText_22      ; 18
	dw SunkenShipLoreText_26      ; 19
	dw SunkenShipLoreText_26      ; 20
	dw SunkenShipLoreText_28      ; 21
	dw SunkenShipLoreText_28      ; 22
	dw SunkenShipLoreText_33      ; 23
	dw SunkenShipLoreText_33      ; 24
	dw SunkenShipLoreText_34      ; 25
	dw SunkenShipLoreText_34      ; 26
	dw SunkenShipLoreText_37      ; 27
	dw SunkenShipLoreText_37      ; 28
	dw DoorCantBeOpenedText2      ; 29


; plot-relevant ----------------------------------

GiveSunkenShipTreasureText:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_GOT_TOPAZ
	ld hl, GiveRoomKey3XText_PostItem
	jr nz, .printAndEnd
; we didn't get the key yet
	ld hl, GiveShipTreasureText_FoundTopaz
	call PrintText
	lb bc, TOPAZ, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, GiveRoomKey3XText_GotItem
	call PrintText
	SetEvent EVENT_SUNKEN_SHIP_GOT_TOPAZ
	jr .done
.bagFull
	ld hl, GiveRoomKey3XText_BagFull
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

GiveShipTreasureText_FoundTopaz:
	text_far _GiveShipTreasureText_FoundTopaz
	text_end

GiveCombination12Text:
	text_far _GiveCombination12Text
	text_end

GiveCombination18Text:
	text_far _GiveCombination18Text
	text_end

GivePassword25Text:
	text_far _GivePassword25Text
	text_end

GivePassword22Text:
	text_far _GivePassword22Text
	text_end

GiveRoomKey34Text:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_GOT_ROOM_KEY_34
	ld hl, GiveRoomKey3XText_PostItem
	jr nz, .printAndEnd
; we didn't get the key yet
	ld hl, GiveRoomKey34Text_FoundItem
	call PrintText
	lb bc, ROOM_KEY_34, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, GiveRoomKey3XText_GotItem
	call PrintText
	SetEvent EVENT_SUNKEN_SHIP_GOT_ROOM_KEY_34
	jr .done
.bagFull
	ld hl, GiveRoomKey3XText_BagFull
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

GiveRoomKey37Text:
	text_asm
	CheckEvent EVENT_SUNKEN_SHIP_GOT_ROOM_KEY_37
	ld hl, GiveRoomKey3XText_PostItem
	jr nz, .printAndEnd
; we didn't get the key yet
	ld hl, GiveRoomKey37Text_FoundItem
	call PrintText
	lb bc, ROOM_KEY_37, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, GiveRoomKey3XText_GotItem
	call PrintText
	SetEvent EVENT_SUNKEN_SHIP_GOT_ROOM_KEY_37
	jr .done
.bagFull
	ld hl, GiveRoomKey3XText_BagFull
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

GiveRoomKey34Text_FoundItem:
	text_far _GiveRoomKey34Text_FoundItem
	text_end

GiveRoomKey37Text_FoundItem:
	text_far _GiveRoomKey37Text_FoundItem
	text_end

GiveRoomKey3XText_BagFull:
	text_far _GiveRoomKey3XText_BagFull
	text_end

GiveRoomKey3XText_GotItem:
	text_far _GiveRoomKey3XText_GotItem
	sound_get_key_item
	text_end

GiveRoomKey3XText_PostItem:
	text_far _GiveRoomKey3XText_PostItem
	text_end

; world-building ----------------------------------

SunkenShipLoreText_12:
	text_far _SunkenShipLoreText_12
	text_end

SunkenShipLoreText_13:
	text_far _SunkenShipLoreText_13
	text_end

SunkenShipLoreText_18:
	text_far _SunkenShipLoreText_18
	text_end

SunkenShipLoreText_21:
	text_far _SunkenShipLoreText_21
	text_end

SunkenShipLoreText_22:
	text_far _SunkenShipLoreText_22
	text_end

SunkenShipLoreText_26:
	text_far _SunkenShipLoreText_26
	text_end

SunkenShipLoreText_28:
	text_far _SunkenShipLoreText_28
	text_end

SunkenShipLoreText_33:
	text_far _SunkenShipLoreText_33
	text_end

SunkenShipLoreText_34:
	text_far _SunkenShipLoreText_34
	text_end

SunkenShipLoreText_37:
	text_far _SunkenShipLoreText_37
	text_end

DoorCantBeOpenedText2:
	text_far _DoorCantBeOpenedText2
	text_end

SunkenShipCaptainsLogText:
	text_asm
	ld hl, SunkenShipCaptainsLogText_Page0
	call PrintText
	call YesNoWrapper
	jp nz, .printAndEnd
; page 1
	ld hl, SunkenShipCaptainsLogText_Page1
	call PrintText
	call YesNoWrapper
	jp nz, .printAndEnd
; page 2
	ld hl, SunkenShipCaptainsLogText_Page2
	call PrintText
	call YesNoWrapper
	jp nz, .printAndEnd
; page 3
	ld hl, SunkenShipCaptainsLogText_Page3
	call PrintText
	call YesNoWrapper
	jp nz, .printAndEnd
; page 4
	ld hl, SunkenShipCaptainsLogText_Page4
	call PrintText
	call YesNoWrapper
	jp nz, .printAndEnd
; page 5
	ld hl, SunkenShipCaptainsLogText_Page5
.printAndEnd
	call PrintText
	jp TextScriptEnd

YesNoWrapper:
	ld hl, SunkenShipCaptainsLogText_AnotherPage
	call PrintText
	call YesNoChoice
	ld hl, SunkenShipCaptainsLogText_Stop
	ld a, [wCurrentMenuItem]
	and a
	ret

SunkenShipCaptainsLogText_Page0:
	text_far _SunkenShipCaptainsLogText_Page0
	text_end

SunkenShipCaptainsLogText_Page1:
	text_far _SunkenShipCaptainsLogText_Page1
	text_end

SunkenShipCaptainsLogText_Page2:
	text_far _SunkenShipCaptainsLogText_Page2
	text_end

SunkenShipCaptainsLogText_Page3:
	text_far _SunkenShipCaptainsLogText_Page3
	text_end

SunkenShipCaptainsLogText_Page4:
	text_far _SunkenShipCaptainsLogText_Page4
	text_end

SunkenShipCaptainsLogText_Page5:
	text_far _SunkenShipCaptainsLogText_Page5
	text_end

SunkenShipCaptainsLogText_AnotherPage:
	text_far _SunkenShipCaptainsLogText_AnotherPage
	text_end

SunkenShipCaptainsLogText_Stop:
	text_far _SunkenShipCaptainsLogText_Stop
	text_end
