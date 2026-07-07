SSAnne1F_Script:
	RPTextChooser SSAnne1F_TextPointers, SSAnne1F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

SSAnne1F_TextPointers:
	dw SSAnne1Text1
	dw SSAnne1Text2

SSAnne1F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

SSAnne1Text1:
	text_far _SSAnne1Text1
	text_end

SSAnne1Text2:
	text_far _SSAnne1Text2
	text_end
