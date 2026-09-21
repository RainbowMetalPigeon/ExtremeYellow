SafariZoneWest_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneWest_TextPointers:
	dw PickUpItemText
	dw PickUpItemText_TM_DOUBLE_TEAM
	dw PickUpItemText
	dw PickUpItemText
	; signs
	dw SafariZoneWestText5
	dw SafariZoneWestText7
	dw SafariZoneWestText8

SafariZoneWestText5:
	text_far _SafariZoneWestText5
	text_end

;SafariZoneWestText6:
;	text_far _SafariZoneWestText6
;	text_end

SafariZoneWestText7:
	text_far _SafariZoneWestText7
	text_end

SafariZoneWestText8:
	text_far _SafariZoneWestText8
	text_end

PickUpItemText_TM_DOUBLE_TEAM:
	text_far _PickUpItemText_TM_DOUBLE_TEAM
	sound_get_item_1
	text_asm
	ld a, HS_SAFARI_ZONE_WEST_ITEM_2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call DisableWaitingAfterTextDisplay
	jp TextScriptEnd
