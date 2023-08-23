CeladonMart4F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart4F_TextPointers:
	dw CeladonMart4ClerkText
	dw CeladonMart4Text2
	dw CeladonMart4Text3
	dw CeladonMart4Text4

CeladonMart4Text2:
	text_far _CeladonMart4Text2
	text_end

CeladonMart4Text3:
	text_far _CeladonMart4Text3
	text_end

CeladonMart4Text4:
	text_far _CeladonMart4Text4
	text_end

CeladonMart4ClerkText: ; moved
	script_mart POKE_DOLL, FIRE_STONE, THUNDER_STONE, WATER_STONE, LEAF_STONE, ICE_STONE, SUN_STONE, KINGS_ROCK, METAL_COAT

CeladonMart5Clerk1Text: ; moved
	script_mart X_ACCURACY, GUARD_SPEC, DIRE_HIT, X_ATTACK, X_DEFEND, X_SPEED, X_SPECIAL
