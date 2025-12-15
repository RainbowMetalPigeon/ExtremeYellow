SafariZoneExtra_Script:
	jp EnableAutoTextBoxDrawing

SafariZoneExtra_TextPointers:
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw SafariZoneExtraText1
	dw SafariZoneExtraText2

SafariZoneExtraText1:
	text_far _SafariZoneExtraText1
	text_end

SafariZoneExtraText2:
	text_far _SafariZoneExtraText2
	text_end
