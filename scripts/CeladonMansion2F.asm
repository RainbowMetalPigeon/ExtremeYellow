CeladonMansion2F_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonMansion2F_TextPointers:
	; NPCs
	dw CeladonMansion2Text1
	; signs
	dw CeladonMansion2TextSign1

; NPCs -------------------

CeladonMansion2Text1:
	text_far _CeladonMansion2TextPigeon
	text_end

; Signs ------------------

CeladonMansion2TextSign1:
	text_far _CeladonMansion2TextSign1
	text_end
