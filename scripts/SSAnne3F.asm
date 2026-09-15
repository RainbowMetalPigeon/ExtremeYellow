SSAnne3F_Script:
	RPTextChooser SSAnne3F_TextPointers, SSAnne3F_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

SSAnne3F_TextPointers:
	dw SSAnne3Text1

SSAnne3F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath

SSAnne3Text1:
	text_far _SSAnne3Text1
	text_end
