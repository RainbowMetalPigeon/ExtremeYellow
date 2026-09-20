CeladonMart2F_Script:
	RPTextChooser CeladonMart2F_TextPointers, CeladonMart2F_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

CeladonMart2F_TextPointers:
	dw CeladonMart2Clerk1Text
	dw CeladonMart2Clerk2Text
	dw CeladonMart2Text3
	dw CeladonMart2Text4
	dw CeladonMart2Text5

CeladonMart2F_TextPointers_Rocket:
	dw CeladonMart2Clerk1Text
	dw CeladonMart2Clerk2Text
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CeladonMart2Text5

CeladonMart2Text3:
	text_far _CeladonMart2Text3
	text_end

CeladonMart2Text4:
	text_far _CeladonMart2Text4
	text_end

CeladonMart2Text5:
	text_far _CeladonMart2Text5
	text_end

CeladonMart2Clerk1Text: ; edited
	script_mart SUPER_POTION, REVIVE, SUPER_REPEL, ANTIDOTE, BURN_HEAL, ICE_HEAL, AWAKENING, PARLYZ_HEAL

CeladonMart2Clerk2Text: ; edited
	script_mart POKE_BALL, GREAT_BALL, SMASH_BALL, ESCAPE_ROPE
