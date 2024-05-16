FuchsiaPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

FuchsiaPokecenter_TextPointers:
	dw FuchsiaHealNurseText
	dw FuchsiaPokecenterText2
	dw FuchsiaPokecenterText3
	dw FuchsiaTradeNurseText
	dw FuchsiaPokecenterText5
	; new, from Mart
	dw FuchsiaCashierText
	dw FuchsiaMartText2
	dw FuchsiaMartText3
	dw FuchsiaCashierTextTM ; new, TM seller

FuchsiaHealNurseText:
	script_pokecenter_nurse

FuchsiaPokecenterText2:
	text_far _FuchsiaPokecenterText1
	text_end

FuchsiaPokecenterText3:
	text_far _FuchsiaPokecenterText3
	text_end

FuchsiaTradeNurseText:
	script_cable_club_receptionist

FuchsiaPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

FuchsiaMartText2:
	text_far _FuchsiaMartText2
	text_end

FuchsiaMartText3:
	text_far _FuchsiaMartText3
	text_end

FuchsiaCashierText: ; moved
	script_mart ULTRA_BALL, GREAT_BALL, HYPER_POTION, REVIVE, FULL_HEAL, SUPER_REPEL

FuchsiaCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
