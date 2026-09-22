SeviiThreeIslandSecretGarden_Script:
	jp EnableAutoTextBoxDrawing

SeviiThreeIslandSecretGarden_TextPointers:
	dw PickUpItemText_HM_WHIRLPOOL

;SeviiThreeIslandSecretGardenText1:
;	text_far _SeviiThreeIslandSecretGardenText1
;	text_end

PickUpItemText_HM_WHIRLPOOL:
	text_far _PickUpItemText_HM_WHIRLPOOL
	sound_get_item_1
	text_asm
	ld a, HS_SEVII_THREE_ISLAND_SECRET_GARDEN_ITEM_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call DisableWaitingAfterTextDisplay
	jp TextScriptEnd
