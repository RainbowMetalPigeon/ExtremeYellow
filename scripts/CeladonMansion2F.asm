CeladonMansion2F_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMansion2F_TextPointers:
	; NPCs
	dw CeladonMansion2Text1
	dw CeladonMansion2Text2
	dw CeladonMansion2Text3
	dw CeladonMansion2Text4
	dw CeladonMansion2Text5
	dw CeladonMansion2Text6
	dw CeladonMansion2Text7
	; signs
	dw CeladonMansion2TextSign1
	dw CeladonMansion2TextSign2
	dw CeladonMansion2TextSign3
	dw CeladonMansion2TextSign4

; NPCs -------------------

CeladonMansion2Text1:
	text_far _CeladonMansion2TextPigeon
	text_end

CeladonMansion2Text2:
	text_far _CeladonMansion2TextCramorant
	text_end

CeladonMansion2Text3:
	text_far _CeladonMansion2TextCarrot
	text_end

CeladonMansion2Text4:
	text_far _CeladonMansion2TextMord
	text_end

CeladonMansion2Text5:
	text_far _CeladonMansion2TextDannye
	text_end

CeladonMansion2Text6:
	text_far _CeladonMansion2TextSatoMew
	text_end

CeladonMansion2Text7:
	text_far _CeladonMansion2TextJoJo
	text_end

; Signs ------------------

CeladonMansion2TextSign1:
	text_far _CeladonMansion2TextSign1
	text_end

CeladonMansion2TextSign2:
	text_far _CeladonMansion2TextSign2
	text_end

CeladonMansion2TextSign3:
	text_far _CeladonMansion2TextSign3
	text_end

CeladonMansion2TextSign4:
	text_far _CeladonMansion2TextSign4
	text_end
