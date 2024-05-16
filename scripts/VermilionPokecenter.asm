VermilionPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

VermilionPokecenter_TextPointers:
	dw VermilionHealNurseText
	dw VermilionPokecenterText2
	dw VermilionPokecenterText3
	dw VermilionTradeNurseText
	dw VermilionPokecenterText5
	; new, from Mart
	dw VermilionCashierText
	dw VermilionMartText2
	dw VermilionMartText3
	dw VermilionCashierTextTM ; new, TM seller

VermilionHealNurseText:
	script_pokecenter_nurse

VermilionPokecenterText2:
	text_far _VermilionPokecenterText2
	text_end

VermilionPokecenterText3:
	text_far _VermilionPokecenterText3
	text_end

VermilionTradeNurseText:
	script_cable_club_receptionist

VermilionPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

VermilionMartText2:
	text_far _VermilionMartText2
	text_end

VermilionMartText3:
	text_far _VermilionMartText3
	text_end

VermilionCashierText: ; moved
	script_mart POKE_BALL, SUPER_POTION, ICE_HEAL, AWAKENING, PARLYZ_HEAL, REPEL

VermilionCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
