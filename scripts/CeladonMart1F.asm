CeladonMart1F_Script:
	RPTextChooser CeladonMart1F_TextPointers, CeladonMart1F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

CeladonMart1F_TextPointers:
	dw CeladonMart1Text1
	dw CeladonMart1Text2
	dw CeladonMart1Text3

CeladonMart1F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw CeladonMart1Text2
	dw CeladonMart1Text3

CeladonMart1Text1:
	text_far _CeladonMart1Text1
	text_end

CeladonMart1Text2:
	text_far _CeladonMart1Text2
	text_end

CeladonMart1Text3:
	text_far _CeladonMart1Text3
	text_end
