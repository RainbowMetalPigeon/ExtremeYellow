CeladonUniversity_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonUniversity_TextPointers:
	; people
	dw CeladonUniversityText1
	dw CeladonUniversityText2
	dw CeladonUniversityText3
	dw CeladonUniversityText4
	dw CeladonUniversityText5
	dw CeladonUniversityText6
	dw CeladonUniversityTextTest
	dw CeladonUniversityTextTest
	dw CeladonUniversityTextTest
	dw CeladonUniversityTextTest
	dw CeladonUniversityTextTest
	; signs
	dw CeladonUniversityDoor1
	dw CeladonUniversityDoor2
	dw CeladonUniversityDoor3
	dw CeladonUniversityDoor4
	dw CeladonUniversityConstitution1
	dw CeladonUniversityConstitution2

; --- hall ---

CeladonUniversityText1:
	text_far _CeladonUniversityText1
	text_end

CeladonUniversityText2:
	text_far _CeladonUniversityText2
	text_end

CeladonUniversityText3:
	text_far _CeladonUniversityText3
	text_end

CeladonUniversityText4:
	text_far _CeladonUniversityText4
	text_end

CeladonUniversityText5:
	text_far _CeladonUniversityText5
	text_end

CeladonUniversityText6:
	text_far _CeladonUniversityText6
	text_end

; --- swimming pool ---

CeladonUniversityTextTest:
	text_far _CeladonUniversityTextTest
	text_end

; --- signs ---

CeladonUniversityDoor1:
	text_far _CeladonUniversityDoor1
	text_end

CeladonUniversityDoor2:
	text_far _CeladonUniversityDoor2
	text_end

CeladonUniversityDoor3:
	text_far _CeladonUniversityDoor3
	text_end

CeladonUniversityDoor4:
	text_far _CeladonUniversityDoor4
	text_end

CeladonUniversityConstitution1:
	text_far _CeladonUniversityConstitution1
	text_end

CeladonUniversityConstitution2:
	text_far _CeladonUniversityConstitution2
	text_end
