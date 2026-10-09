SeviiSixIslandHouses_Script:
	RPTextChooser SeviiSixIslandHouses_TextPointers, SeviiSixIslandHouses_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

SeviiSixIslandHouses_TextPointers:
	dw SeviiSixIslandHousesText1
	dw SeviiSixIslandHousesText2
	dw SeviiSixIslandHousesText3
	dw SeviiSixIslandHousesText4
	dw SeviiSixIslandHousesText5

SeviiSixIslandHouses_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw SeviiSixIslandHousesText5_RP

SeviiSixIslandHousesText1:
	text_far _SeviiSixIslandHousesText1
	text_end

SeviiSixIslandHousesText2:
	text_far _SeviiSixIslandHousesText2
	text_end

SeviiSixIslandHousesText3:
	text_far _SeviiSixIslandHousesText3
	text_end

SeviiSixIslandHousesText4:
	text_far _SeviiSixIslandHousesText4
	text_end

SeviiSixIslandHousesText5:
	text_far _SeviiSixIslandHousesText5
	text_asm
	ld a, GROWLITHE
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; new for RP ============================

SeviiSixIslandHousesText5_RP:
	text_far _SeviiSixIslandHousesText5
	text_asm
	ld a, GROWLITHE
	call PlayCry
	call WaitForSoundToFinish
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 70
	ld b, GROWLITHE
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_SEVII_SIX_ISLAND_HOUSES_MON_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd
