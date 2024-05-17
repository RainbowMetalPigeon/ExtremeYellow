CeladonMart2F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart2F_TextPointers:
	dw CeladonMart2Clerk1Text
	dw CeladonMart2Clerk2Text
	dw CeladonMart2Text3
	dw CeladonMart2Text4
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

CeladonMart2Clerk1Text: ; moved
	script_mart GREAT_BALL, SUPER_POTION, REVIVE, SUPER_REPEL, ANTIDOTE, BURN_HEAL, ICE_HEAL, AWAKENING, PARLYZ_HEAL

CeladonMart2Clerk2Text: ; moved
	script_mart TM_MEGA_PUNCH, TM_COUNTER, TM_BODY_SLAM, TM_BUBBLEBEAM, TM_METRONOME, TM_THUNDERBOLT, TM_DIG, TM_BIDE, TM_X_SCISSOR
