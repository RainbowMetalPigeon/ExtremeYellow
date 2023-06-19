MrFujisHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

MrFujisHouse_TextPointers:
	dw LavenderHouse1Text1
	dw LavenderHouse1Text2
	dw LavenderHouse1Text3
	dw LavenderHouse1Text4
	dw LavenderHouse1Text5
	dw LavenderHouse1Text6

LavenderHouse1Text1:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8d1
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8d6
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d8d1:
	text_far _LavenderHouse1Text_1d8d1
	text_end

LavenderHouse1Text_1d8d6:
	text_far _LavenderHouse1Text_1d8d6
	text_end

LavenderHouse1Text2:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8f4
	call PrintText
	jr .done
.rescued_mr_fuji
	ld hl, LavenderHouse1Text_1d8f9
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d8f4:
	text_far _LavenderHouse1Text_1d8f4
	text_end

LavenderHouse1Text_1d8f9:
	text_far _LavenderHouse1Text_1d8f9
	text_end

LavenderHouse1Text3:
	text_far _LavenderHouse1Text3
	text_asm
	ld a, PSYDUCK
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text4:
	text_far _LavenderHouse1Text4
	text_asm
	ld a, NIDORINO
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text5:
	text_asm
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .got_item_flute
	ld hl, LavenderHouse1Text_1d94c
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedFluteText
	call PrintText
	SetEvent EVENT_GOT_POKE_FLUTE
	jr .done
.got_item_flute
	CheckEvent EVENT_GOT_FUJI_MEGA_STONE_X
	jr nz, .got_item_mstonex
	ld hl, LavenderHouse1Text_MegaStone
	call PrintText
	lb bc, MEGA_STONE_X, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedMegaStoneXText
	call PrintText
	SetEvent EVENT_GOT_FUJI_MEGA_STONE_X
	jr .done
.bag_full
	ld hl, FluteOrStoneNoRoomText
	call PrintText
	jr .done
.got_item_mstonex
	ld hl, MrFujiAfterFluteAndStoneText
	call PrintText
.done
	jp TextScriptEnd

LavenderHouse1Text_1d94c:
	text_far _LavenderHouse1Text_1d94c
	text_end

LavenderHouse1Text_MegaStone: ; new
	text_far _LavenderHouse1Text_MegaStone
	text_end

ReceivedFluteText:
	text_far _ReceivedFluteText
	sound_get_key_item
	text_far _FluteExplanationText
	text_end

ReceivedMegaStoneXText:
	text_far _ReceivedFluteText
	sound_get_item_2
	text_far _MegaStoneXExplanationText
	text_end

FluteOrStoneNoRoomText:
	text_far _FluteOrStoneNoRoomText
	text_end

MrFujiAfterFluteAndStoneText:
	text_far _MrFujiAfterFluteAndStoneText
	text_end

LavenderHouse1Text6:
	text_far _LavenderHouse1Text6
	text_end
