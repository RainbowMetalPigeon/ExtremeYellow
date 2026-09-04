Museum1F_Script:
	RPTextChooser Museum1F_TextPointers, Museum1F_TextPointers_Rocket
	ld a, TRUE
	ld [wAutoTextBoxDrawingControl], a
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, Museum1F_ScriptPointers
	ld a, [wMuseum1FCurScript]
	call CallFunctionInTable
	ret

Museum1F_ScriptPointers:
	dw Museum1FScript0
	dw Museum1FScript1

Museum1FScript0:
	ld a, [wYCoord]
	cp 4
	ret nz
	ld a, [wXCoord]
	cp 9
	jr z, .continue
	ld a, [wXCoord]
	cp 10
	ret nz
.continue
	xor a
	ldh [hJoyHeld], a
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

Museum1FScript1:
	ret

Museum1F_TextPointers:
	dw Museum1FText1 ; entry person
	dw Museum1FText2 ; praise god bones
	dw Museum1FText3 ; give amber
	dw Museum1FText4 ; proud of two fossils
	dw Museum1FText5 ; Amber

Museum1F_TextPointers_Rocket:
	dw Museum1FText1_RP ; entry person TBE
	dw Museum1FText2 ; praise god bones
	dw Museum1FText3_RP ; give amber TBE
	dw GenericNPCText_RocketPath ; proud of two fossils
	dw Museum1FText5_RP ; Amber TBE

Museum1FText1:
	text_asm
	farcall Func_EntryPerson
	jp TextScriptEnd

Museum1FText2:
	text_asm
	farcall Func_PrintPraise
	jp TextScriptEnd

Museum1FText3:
	text_asm
	farcall Func_GiveAmber
	jp TextScriptEnd

Museum1FText4:
	text_asm
	farcall Func_PrintProud
	jp TextScriptEnd

Museum1FText5:
	text_asm
	farcall Func_PrintAmberIsClear
	jp TextScriptEnd

; new for RP ==========================

Museum1FText1_RP:
	text_asm
	farcall Func_EntryPerson_RP
	jp TextScriptEnd

Museum1FText3_RP:
	text_asm
	farcall Func_NoOurAmber_RP
	jp TextScriptEnd

Museum1FText5_RP:
	text_asm
	farcall Func_TakeAmber_RP
	jp TextScriptEnd
