SafariZoneEast_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneEast_TextPointers:
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText_TM_CLOSE_COMBAT
	; signs
	dw SafariZoneEastText5
	dw SafariZoneEastText6
	dw SafariZoneEastText7

SafariZoneEastText5:
	text_far _SafariZoneEastText5
	text_end

SafariZoneEastText6:
	text_far _SafariZoneEastText6
	text_end

SafariZoneEastText7:
	text_far _SafariZoneEastText7
	text_end

PickUpItemText_TM_CLOSE_COMBAT:
	text_far _PickUpItemText_TM_CLOSE_COMBAT
	sound_get_item_1
	text_asm
	ld a, HS_SAFARI_ZONE_EAST_ITEM_4
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call DisableWaitingAfterTextDisplay
	jp TextScriptEnd
