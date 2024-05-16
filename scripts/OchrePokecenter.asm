OchrePokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

OchrePokecenter_TextPointers:
	dw OchreHealNurseText
	dw OchrePokecenterText2
	dw OchrePokecenterText3
	dw OchreTradeNurseText
	dw OchrePokecenterText5
	; mart
	dw OchreCashierText
	dw OchreMartText2
	dw OchreMartText3
	dw OchreCashierTextTM ; new, TM seller

OchreHealNurseText:
	script_pokecenter_nurse

OchrePokecenterText2:
	text_far _OchrePokecenterText2
	text_end

OchrePokecenterText3:
	text_far _OchrePokecenterText3
	text_end

OchreTradeNurseText:
	script_cable_club_receptionist

OchrePokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

OchreMartText2:
	text_far _OchreMartText2
	text_end

OchreMartText3:
	text_far _OchreMartText3
	text_end

OchreCashierText: ; moved
	script_mart HEAVY_BALL, FAST_BALL, ULTRA_BALL, HYPER_POTION, REVIVE, FULL_HEAL, MAX_REPEL

OchreCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
