PewterSpeechHouse_Script:
	jp EnableAutoTextBoxDrawing

PewterSpeechHouse_TextPointers:
	dw PewterHouse2Text1
	dw PewterHouse2Text2
	; new
	dw PewterHouse2Text3

PewterHouse2Text1:
	text_far _PewterHouse2Text1
	text_end

PewterHouse2Text2:
	text_far _PewterHouse2Text2
	text_end

; new ---------------------------------

PewterHouse2Text3:
	text_far _PewterHouse2Text3
	text_end
	