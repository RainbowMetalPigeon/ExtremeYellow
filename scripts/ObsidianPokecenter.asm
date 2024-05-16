ObsidianPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

ObsidianPokecenter_TextPointers:
	dw ObsidianHealNurseText
	dw ObsidianPokecenterText2
	dw ObsidianPokecenterText3
	dw ObsidianTradeNurseText
	dw ObsidianPokecenterText5
	; mart
	dw ObsidianCashierText
	dw ObsidianMartText2
	dw ObsidianMartText3
	dw ObsidianCashierTextTM ; new, TM seller

ObsidianHealNurseText:
	script_pokecenter_nurse

ObsidianPokecenterText2:
	text_far _ObsidianPokecenterText2
	text_end

ObsidianPokecenterText3:
	text_far _ObsidianPokecenterText3
	text_end

ObsidianTradeNurseText:
	script_cable_club_receptionist

ObsidianPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

ObsidianMartText2:
	text_far _ObsidianMartText2
	text_end

ObsidianMartText3:
	text_far _ObsidianMartText3
	text_end

ObsidianCashierText: ; moved
	script_mart GREAT_BALL, ULTRA_BALL, HYPER_POTION, REVIVE, FULL_HEAL, MAX_REPEL, ESCAPE_ROPE

ObsidianCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
