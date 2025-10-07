SeviiRoute38_Script:
	jp EnableAutoTextBoxDrawing

SeviiRoute38_TextPointers:
	dw SeviiRoute38Text1 ; 1
	dw SeviiRoute38Text2 ; 2
	dw PickUpItemText ; 3
	dw RockSmashText ; 4
	dw RockSmashText ; 5
	dw RockSmashText ; 6
	dw RockSmashText ; 7
	; signs
	dw SeviiRoute38SignText1 ; 18

SeviiRoute38Text1:
	text_far _SeviiRoute38Text1
	text_end

SeviiRoute38Text2:
	text_far _SeviiRoute38Text2
	text_end

SeviiRoute38SignText1:
	text_far _SeviiRoute38SignText1
	text_end
