CeladonPokecenter_Script:
	RPTextChooser CeladonPokecenter_TextPointers, CeladonPokecenter_TextPointers_Rocket
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CeladonPokecenter_TextPointers:
	dw CeladonHealNurseText
	dw CeladonPokecenterText2
	dw CeladonPokecenterText3
	dw CeladonTradeNurseText
	dw CeladonPokecenterText5

CeladonPokecenter_TextPointers_Rocket:
	dw CeladonHealNurseText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CeladonTradeNurseText ; TBE?
	dw CeladonPokecenterText5

CeladonTradeNurseText:
	script_cable_club_receptionist

CeladonHealNurseText:
	script_pokecenter_nurse

CeladonPokecenterText2:
	text_far _CeladonPokecenterText2
	text_end

CeladonPokecenterText3:
	text_far _CeladonPokecenterText3
	text_end

CeladonPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd
