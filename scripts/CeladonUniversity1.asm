CeladonUniversity1_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonUniversity1_TextPointers:
	; people
	; hall
	dw CeladonUniversity1Text1
	dw CeladonUniversity1Text2
	dw CeladonUniversity1Text3
	dw CeladonUniversity1Text4
	dw CeladonUniversity1Text5
	dw CeladonUniversity1Text6
	; pool
	dw CeladonUniversity1TextMagikarp ; Magikarp
	dw CeladonUniversity1TextMagikarp ; Magikarp
	dw CeladonUniversity1TextMagikarp ; Magikarp
	dw CeladonUniversity1TextPool1 ; Swimmer
	dw CeladonUniversity1TextPool2 ; Swimmer
	dw CeladonUniversity1TextPool3 ; Bench
	; signs
	dw CeladonUniversity1Door1
	dw CeladonUniversity1Door2
	dw CeladonUniversity1Door3
	dw CeladonUniversity1Door4
	dw CeladonUniversity1Constitution1
	dw CeladonUniversity1Constitution2

; --- hall ---

CeladonUniversity1Text1:
	text_far _CeladonUniversity1Text1
	text_end

CeladonUniversity1Text2:
	text_far _CeladonUniversity1Text2
	text_end

CeladonUniversity1Text3:
	text_far _CeladonUniversity1Text3
	text_end

CeladonUniversity1Text4:
	text_far _CeladonUniversity1Text4
	text_end

CeladonUniversity1Text5:
	text_far _CeladonUniversity1Text5
	text_end

CeladonUniversity1Text6:
	text_far _CeladonUniversity1Text6
	text_end

; --- swimming pool ---

CeladonUniversity1TextMagikarp:
	text_far _CeladonUniversity1TextMagikarp
	text_asm
	ld a, MAGIKARP
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

CeladonUniversity1TextPool1:
	text_far _CeladonUniversity1TextPool1
	text_end

CeladonUniversity1TextPool2:
	text_far _CeladonUniversity1TextPool2
	text_end

CeladonUniversity1TextPool3:
	text_far _CeladonUniversity1TextPool3
	text_end

; --- signs ---

CeladonUniversity1Door1:
	text_far _CeladonUniversity1Door1
	text_end

CeladonUniversity1Door2:
	text_far _CeladonUniversity1Door2
	text_end

CeladonUniversity1Door3:
	text_far _CeladonUniversity1Door3
	text_end

CeladonUniversity1Door4:
	text_far _CeladonUniversity1Door4
	text_end

CeladonUniversity1Constitution1:
	text_far _CeladonUniversity1Constitution1
	text_end

CeladonUniversity1Constitution2:
	text_far _CeladonUniversity1Constitution2
	text_end
