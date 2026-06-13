CeruleanCaveExtraFinal_Script:
	RPTextChooser CeruleanCaveExtraFinal_TextPointers, CeruleanCaveExtraFinal_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

CeruleanCaveExtraFinal_TextPointers:
	dw CeruleanCaveExtraFinalTextSeller
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText ; 5
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText ; 10
	dw RockSmashText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw CeruleanCaveExtraFinalSign ; 15

CeruleanCaveExtraFinal_TextPointers_Rocket:
	dw GenericNPCText_RocketPath ; TBE?
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText ; 5
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText ; 10
	dw RockSmashText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw CeruleanCaveExtraFinalSign ; 15

CeruleanCaveExtraFinalSign:
	text_far _CeruleanCaveExtraFinalSign
	text_end

CeruleanCaveExtraFinalTextSeller:
	script_mart MASTER_BALL, MEGA_STONE_X, MEGA_STONE_Y, RARE_CANDY, LEGEND_CANDY, ESCAPE_ROPE
