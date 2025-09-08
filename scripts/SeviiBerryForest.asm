SeviiBerryForest_Script:
	jp EnableAutoTextBoxDrawing

SeviiBerryForest_TextPointers:
	dw SeviiBerryForestText1 ; 1 Carr
	dw SeviiBerryForestText2 ; 2 Mayoi
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
	text_end

SeviiBerryForestText1:
	text_far _SeviiBerryForestText1
	text_end

SeviiBerryForestText2:
	text_far _SeviiBerryForestText2
	text_end
