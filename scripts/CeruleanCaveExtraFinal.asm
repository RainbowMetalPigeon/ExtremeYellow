CeruleanCaveExtraFinal_Script:
	jp EnableAutoTextBoxDrawing

CeruleanCaveExtraFinal_TextPointers:
	dw CeruleanCaveExtraFinalTextSeller
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw CeruleanCaveExtraFinalSign

CeruleanCaveExtraFinalSign:
	text_far _CeruleanCaveExtraFinalSign
	text_end

CeruleanCaveExtraFinalTextSeller:
	script_mart MASTER_BALL, MEGA_STONE_X, MEGA_STONE_Y, RARE_CANDY, ESCAPE_ROPE
