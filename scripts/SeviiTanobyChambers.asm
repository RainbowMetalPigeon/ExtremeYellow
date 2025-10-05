SeviiTanobyChambers_Script:
	jp EnableAutoTextBoxDrawing

SeviiTanobyChambers_TextPointers:
	dw SeviiTanobyChambersSignText1
	dw SeviiTanobyChambersSignText2
	dw SeviiTanobyChambersSignText3
	dw SeviiTanobyChambersSignText4
	dw SeviiTanobyChambersSignText5
	dw SeviiTanobyChambersSignText6
	; scripts

SeviiTanobyChambersSignText1:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText1_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText1_Inner:
	text_far _SeviiTanobyChambersSignText1
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText2:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText2_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText2_Inner:
	text_far _SeviiTanobyChambersSignText2
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText3:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText3_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText3_Inner:
	text_far _SeviiTanobyChambersSignText3
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText4:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText4_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText4_Inner:
	text_far _SeviiTanobyChambersSignText4
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText5:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText5_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText5_Inner:
	text_far _SeviiTanobyChambersSignText5
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText6:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText6_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText6_Inner:
	text_far _SeviiTanobyChambersSignText6
	text_end
