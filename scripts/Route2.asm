Route2_Script:
	jp EnableAutoTextBoxDrawing

Route2_TextPointers:
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText ; new, LINK_CABLE
	dw Route2SupremeFisherText ; new
	dw Route2Text3
	dw Route2Text4

Route2Text3:
	text_far _Route2Text3
	text_end

Route2Text4:
	text_far _Route2Text4
	text_end

Route2SupremeFisherText:
	text_far _Route2SupremeFisherText
	text_end
