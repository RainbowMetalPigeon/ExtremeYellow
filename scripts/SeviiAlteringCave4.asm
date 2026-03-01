SeviiAlteringCave4_Script:
	jp EnableAutoTextBoxDrawing

SeviiAlteringCave4_TextPointers:
	dw SeviiAlteringCave4Text1
	dw SeviiAlteringCave4Text2
	dw SeviiAlteringCave4Text3

SeviiAlteringCave4Text1:
	text_asm
	ld hl, SeviiAlteringCave4Text1_Found
	call PrintText
	lb bc, CHROMOGENE, 6
	call GiveItem
	jr nc, .bagFull
	ld a, HS_SEVII_ALTERING_CAVE_4_ITEM_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld hl, SeviiAlteringCave4Text1_Got
	call PrintText
	jr .done
.bagFull
	ld hl, SeviiAlteringCave4Text1_Full
	call PrintText
.done
	jp TextScriptEnd

SeviiAlteringCave4Text2:
	text_asm
	ld hl, SeviiAlteringCave4Text1_Found
	call PrintText
	lb bc, PERFECTER, 6
	call GiveItem
	jr nc, .bagFull
	ld a, HS_SEVII_ALTERING_CAVE_4_ITEM_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld hl, SeviiAlteringCave4Text2_Got
	call PrintText
	jr .done
.bagFull
	ld hl, SeviiAlteringCave4Text1_Full
	call PrintText
.done
	jp TextScriptEnd

SeviiAlteringCave4Text3:
	text_asm
	ld hl, SeviiAlteringCave4Text1_Found
	call PrintText
	lb bc, ONIGIRI_BOX, 6
	call GiveItem
	jr nc, .bagFull
	ld a, HS_SEVII_ALTERING_CAVE_4_ITEM_3
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld hl, SeviiAlteringCave4Text3_Got
	call PrintText
	jr .done
.bagFull
	ld hl, SeviiAlteringCave4Text1_Full
	call PrintText
.done
	jp TextScriptEnd

SeviiAlteringCave4Text1_Found:
	text_far _SeviiAlteringCave4Text1_Found
	text_end

SeviiAlteringCave4Text1_Got:
	text_far _SeviiAlteringCave4Text1_Got
	sound_get_key_item
	text_end

SeviiAlteringCave4Text2_Got:
	text_far _SeviiAlteringCave4Text2_Got
	sound_get_key_item
	text_end

SeviiAlteringCave4Text3_Got:
	text_far _SeviiAlteringCave4Text3_Got
	sound_get_key_item
	text_end

SeviiAlteringCave4Text1_Full:
	text_far _SeviiAlteringCave4Text1_Full
	text_end
