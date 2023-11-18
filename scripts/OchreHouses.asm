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
	dw OchreHousesTextBirb1 ; FEAROW
	dw OchreHousesTextBirb2 ; FARFETCHD
	dw OchreHousesTextBirb3 ; PIDGEOT
	dw OchreHousesTextBirb4 ; DODRIO
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
	text_asm
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb2:
	text_far _OchreHousesTextBirb2
	text_asm
	ld a, FARFETCHD
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb3:
	text_far _OchreHousesTextBirb3
	text_asm
	ld a, PIDGEOT
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb4:
	text_far _OchreHousesTextBirb4
	text_asm
	ld a, DODRIO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextNotebook:
	text_far _OchreHousesTextNotebook
	text_end
