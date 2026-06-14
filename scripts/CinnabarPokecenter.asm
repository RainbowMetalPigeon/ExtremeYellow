CinnabarPokecenter_Script:
	RPTextChooser CinnabarPokecenter_TextPointers, CinnabarPokecenter_TextPointers_Rocket
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

CinnabarPokecenter_TextPointers:
	dw CinnabarHealNurseText
	dw CinnabarPokecenterText2
	dw CinnabarPokecenterText3
	dw CinnabarTradeNurseText
	dw CinnabarPokecenterText5
	; new, from Mart
	dw CinnabarCashierText
	dw CinnabarMartText2
	dw CinnabarMartText3
	dw CinnabarCashierTextTM ; new, TM seller

CinnabarPokecenter_TextPointers_Rocket:
	dw CinnabarHealNurseText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CinnabarTradeNurseText ; TBE?
	dw CinnabarPokecenterText5
	; new, from Mart
	dw CinnabarCashierText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CinnabarCashierTextTM

CinnabarHealNurseText:
	script_pokecenter_nurse

CinnabarPokecenterText2:
	text_far _CinnabarPokecenterText2
	text_end

CinnabarPokecenterText3:
	text_far _CinnabarPokecenterText3
	text_end

CinnabarTradeNurseText:
	script_cable_club_receptionist

CinnabarPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

CinnabarMartText2:
	text_far _CinnabarMartText2
	text_end

CinnabarMartText3:
	text_far _CinnabarMartText3
	text_end

CinnabarCashierText: ; moved
	script_mart ULTRA_BALL, GREAT_BALL, HYPER_POTION, MAX_REPEL, ESCAPE_ROPE, FULL_HEAL, REVIVE

CinnabarCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
