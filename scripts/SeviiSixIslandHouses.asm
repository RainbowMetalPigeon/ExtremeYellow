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
	dw SeviiSixIslandHousesText5

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
