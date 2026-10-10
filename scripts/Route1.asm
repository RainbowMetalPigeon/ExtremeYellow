Route1_Script:
	RPTextChooser Route1_TextPointers, Route1_TextPointers_Rocket
	ld hl, wd72e ; new for Pallet Fields
	res 4, [hl] ; new for Pallet Fields
	call EnableAutoTextBoxDrawing
	ret

Route1_TextPointers:
	dw Route1Text1
	dw Route1Text2
	dw Route1Text3 ; new FISHER
	dw Route1Text4 ; new GIRL
	dw Route1Text5 ; new SWIMMER
	dw PickUpItemText ; new item
	dw Route1Text7 ; new GAMBLER
	; signs
	dw Route1SignText1

Route1_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw PickUpItemText ; new item
	dw GenericNPCText_RocketPath
	; signs
	dw Route1SignText1

Route1Text1:
	text_asm
	farcall Func_f1ad2
	jp TextScriptEnd

Route1Text2:
	text_asm
	farcall Func_f1b0f
	jp TextScriptEnd

Route1SignText1:
	text_asm
	farcall Func_f1b1b
	jp TextScriptEnd

; new NPCs ---------------------------

Route1Text3:
	text_far _Route1Text3
	text_end

Route1Text4:
	text_far _Route1Text4
	text_end

Route1Text5:
	text_far _Route1Text5
	text_end

Route1Text7:
	text_far _Route1Text7
	text_end
