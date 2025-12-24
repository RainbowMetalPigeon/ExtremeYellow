SunkenShipRooms_Script:
	call EnableAutoTextBoxDrawing
	ret

SunkenShipRooms_TextPointers:
	; top floor
	dw GiveCombination12Text
	dw SunkenShipLoreText_12
	dw SunkenShipLoreText_13
	dw GiveRoomKey34Text
	dw SunkenShipLoreText_18
	; mid floor
	dw SunkenShipLoreText_21
	dw SunkenShipLoreText_22
	dw GiveCombination18Text
	dw GiveRoomKey37Text
	dw SunkenShipLoreText_26
	dw SunkenShipLoreText_28
	; bottom floor
	dw SunkenShipLoreText_33
	dw SunkenShipLoreText_34
	dw GivePassword25Text
	dw SunkenShipLoreText_37
	dw GivePassword22Text
	; captain's room
	dw GiveSunkenShipTreasureText
	dw SunkenShipCaptainsLogText
	; broken door
	dw DoorCantBeOpenedText2

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
