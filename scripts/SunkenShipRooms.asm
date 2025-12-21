SunkenShipRooms_Script:
	call EnableAutoTextBoxDrawing
	ret

SunkenShipRooms_TextPointers:
	; top floor
	dw GiveCombination12Text
	dw GiveRoomKey34Text
	; mid floor
	dw GiveCombination18Text
	dw GiveRoomKey37Text
	; bottom floor
	dw GivePassword25Text
	dw GivePassword22Text

; plot-relevant ----------------------------------

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
