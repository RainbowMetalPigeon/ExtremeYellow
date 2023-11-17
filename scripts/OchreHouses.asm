OchreHouses_Script:
	call EnableAutoTextBoxDrawing
	ret

OchreHouses_TextPointers:
	dw MoveDeleterText1 ; OchreHousesTextDeleter
	dw MoveRelearnerText1 ; OchreHousesTextRelearner
	dw OchreHousesTextReactivater
	dw OchreHousesTextMagikarpTutor
	dw OchreHousesTextBirbFan1
	dw OchreHousesTextBirbFan2
	dw OchreHousesTextBirbFan3
	dw OchreHousesTextBirb1
	dw OchreHousesTextBirb2
	dw OchreHousesTextBirb3
	dw OchreHousesTextBirb4
	; signs
	dw OchreHousesTextNotebook

; ------------------------

OchreHousesTextReactivater:
	text_far _OchreHousesTextReactivater
	text_end

OchreHousesTextMagikarpTutor:
	text_far _OchreHousesTextMagikarpTutor
	text_end

OchreHousesTextBirbFan1:
	text_far _OchreHousesTextBirbFan1
	text_end

OchreHousesTextBirbFan2:
	text_far _OchreHousesTextBirbFan2
	text_end

OchreHousesTextBirbFan3:
	text_far _OchreHousesTextBirbFan3
	text_end

OchreHousesTextBirb1:
	text_far _OchreHousesTextBirb1
	text_end

OchreHousesTextBirb2:
	text_far _OchreHousesTextBirb2
	text_end

OchreHousesTextBirb3:
	text_far _OchreHousesTextBirb3
	text_end

OchreHousesTextBirb4:
	text_far _OchreHousesTextBirb4
	text_end

OchreHousesTextNotebook:
	text_far _OchreHousesTextNotebook
	text_end
