Route7_Script:
	call EnableAutoTextBoxDrawing
	ret

Route7_TextPointers:
	dw PickUpItemText ; new, LINK_CABLE
	dw Route7Text1

Route7Text1:
	text_far _Route7Text1
	text_end
