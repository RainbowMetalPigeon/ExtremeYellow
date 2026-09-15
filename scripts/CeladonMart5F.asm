CeladonMart5F_Script:
	RPTextChooser CeladonMart5F_TextPointers, CeladonMart5F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

CeladonMart5F_TextPointers:
	dw CeladonMart5Text1
	dw CeladonMart5Text2
	dw CeladonMart5Clerk1Text
	dw CeladonMart5Clerk2Text
	dw CeladonMart5Text5

CeladonMart5F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CeladonMart5Clerk1Text
	dw CeladonMart5Clerk2Text
	dw CeladonMart5Text5

CeladonMart5Text1:
	text_far _CeladonMart5Text1
	text_end

CeladonMart5Text2:
	text_far _CeladonMart5Text2
	text_end

CeladonMart5Text5:
	text_far _CeladonMart5Text5
	text_end

CeladonMart5Clerk2Text: ; moved
	script_mart HP_UP, PROTEIN, IRON, CARBOS, CALCIUM
