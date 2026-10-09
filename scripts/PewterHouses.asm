PewterHouses_Script:
	RPTextChooser PewterHouses_TextPointers, PewterHouses_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

PewterHouses_TextPointers:
	dw PewterHouse2Text1
	dw PewterHouse2Text2
	; new
	dw PewterHouse2Text3
	dw PewterHouse2Text4
	; Nidoran house
	dw PewterHouse1Text1
	dw PewterHouse1Text2
	dw PewterHouse1Text3

PewterHouses_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; new
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; Nidoran house
	dw PewterHouse1Text1_RP
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath

PewterHouse2Text1:
	text_far _PewterHouse2Text1
	text_end

PewterHouse2Text2:
	text_far _PewterHouse2Text2
	text_end

; new ---------------------------------

PewterHouse2Text3:
	text_far _PewterHouse2Text3
	text_end

PewterHouse2Text4:
	text_far _PewterHouse2Text4
	text_end

; Nidoran house ---------------------------------

PewterHouse1Text1:
	text_far _PewterHouse1Text1
	text_asm
	ld a, NIDORAN_M
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

PewterHouse1Text2:
	text_far _PewterHouse1Text2
	text_end

PewterHouse1Text3:
	text_far _PewterHouse1Text3
	text_end

; new for RP ==============================

PewterHouse1Text1_RP:
	text_far _PewterHouse1Text1
	text_asm
	ld a, NIDORAN_M
	call PlayCry
	call WaitForSoundToFinish
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 14
	ld b, NIDORAN_M
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_PEWTER_HOUSES_MON_1
	ld [wMissableObjectIndex], a
	predef HideObjectExtra2
	jp TextScriptEnd
