SaffronPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

SaffronPokecenter_TextPointers:
	dw SaffronHealNurseText
	dw SaffronPokecenterText2
	dw SaffronPokecenterText3
	dw SaffronTradeNurseText
	dw SaffronPokecenterText5
	; new, from Mart
	dw SaffronCashierText
	dw SaffronMartText2
	dw SaffronMartText3
	dw SaffronCashierTextTM ; new, TM seller

SaffronHealNurseText:
	script_pokecenter_nurse

SaffronPokecenterText2:
	text_far _SaffronPokecenterText2
	text_end

SaffronPokecenterText3:
	text_far _SaffronPokecenterText3
	text_end

SaffronTradeNurseText:
	script_cable_club_receptionist

SaffronPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

SaffronMartText2:
	text_far _SaffronMartText2
	text_end

SaffronMartText3:
	text_far _SaffronMartText3
	text_end

SaffronCashierText: ; moved
	script_mart GREAT_BALL, HYPER_POTION, MAX_REPEL, ESCAPE_ROPE, FULL_HEAL, REVIVE

SaffronCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
