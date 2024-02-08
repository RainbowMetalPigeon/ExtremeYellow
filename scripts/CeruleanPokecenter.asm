CeruleanPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CeruleanPokecenter_TextPointers:
	dw CeruleanHealNurseText
	dw CeruleanPokecenterText2
	dw CeruleanPokecenterText3
	dw CeruleanTradeNurseText
	dw CeruleanPokecenterText5
	; from Mart
	dw CeruleanCashierText
	dw CeruleanMartText2
	dw CeruleanMartText3

CeruleanTradeNurseText:
	script_cable_club_receptionist

CeruleanHealNurseText:
	script_pokecenter_nurse

CeruleanPokecenterText2:
	text_far _CeruleanPokecenterText2
	text_end

CeruleanPokecenterText3:
	text_far _CeruleanPokecenterText3
	text_end

CeruleanPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

CeruleanMartText2:
	text_far _CeruleanMartText2
	text_end

CeruleanMartText3:
	text_far _CeruleanMartText3
	text_end

CeruleanCashierText: ; moved
	script_mart POKE_BALL, POTION, ESCAPE_ROPE, REPEL, ANTIDOTE, BURN_HEAL, AWAKENING, PARLYZ_HEAL
