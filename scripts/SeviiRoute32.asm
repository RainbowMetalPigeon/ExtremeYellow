SeviiRoute32_Script:
	jp EnableAutoTextBoxDrawing

SeviiRoute32_TextPointers:
;	dw RockSmashText
;	dw PickUpItemText
;	dw PickUpItemText
	dw SeviiRoute32Text1
	text_end

SeviiRoute32Text1:
	text_asm
	ld hl, TreasureBeachSignText
	call PrintText
;	callfar ResetSeviiRoute32HiddenItems
	jp TextScriptEnd

TreasureBeachSignText:
	text_far _TreasureBeachSignText
	text_end
