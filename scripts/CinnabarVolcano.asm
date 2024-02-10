CinnabarVolcano_Script:
	call EnableAutoTextBoxDrawing
	ret

CinnabarVolcano_TextPointers:
	dw CinnabarVolcanoText1

CinnabarVolcanoText1:
	text_far _CinnabarVolcanoText1
	text_end
