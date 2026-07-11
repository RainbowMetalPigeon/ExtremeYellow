CeruleanCaveExtraFinal_Script:
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
	dw CeruleanCaveExtraFinalSign1 ; 15
	dw CeruleanCaveExtraFinalSign2 ; 16

CeruleanCaveExtraFinalSign1:
	text_far _CeruleanCaveExtraFinalSign1
	text_end

CeruleanCaveExtraFinalSign2:
	text_far _CeruleanCaveExtraFinalSign2
	text_end

CeruleanCaveExtraFinalTextSeller:
	script_mart MASTER_BALL, MEGA_STONE_X, MEGA_STONE_Y, RARE_CANDY, LEGEND_CANDY, ESCAPE_ROPE
