Route1_Script:
;	call Route1_TextPointers_Chooser
	RPTextChooser Route1_TextPointers, Route1_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ret

/*
Route1_TextPointers_Chooser:
	CheckEvent EVENT_ROCKET_PATH
	ld hl, Route1_TextPointers_Rocket
	jr nz, .pointersFound
	ld hl, Route1_TextPointers
.pointersFound
	ld a, l
	ld [wMapTextPtr], a
	ld a, h
	ld [wMapTextPtr+1], a
	ret
*/

Route1_TextPointers:
	dw Route1Text1
	dw Route1Text2
	dw Route1Text3

Route1_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw Route1Text3

Route1Text1:
	text_asm
	farcall Func_f1ad2
	jp TextScriptEnd

Route1Text2:
	text_asm
	farcall Func_f1b0f
	jp TextScriptEnd

Route1Text3:
	text_asm
	farcall Func_f1b1b
	jp TextScriptEnd
