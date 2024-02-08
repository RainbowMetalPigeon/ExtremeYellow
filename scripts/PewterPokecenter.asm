PewterPokecenter_Script:
	ld hl, wd492
	set 7, [hl]
	call Serial_TryEstablishingExternallyClockedConnection
	call EnableAutoTextBoxDrawing
;	ld a, TRUE ; unnecessary
;	ld [wAutoTextBoxDrawingControl], a ; unnecessary
	ret

PewterPokecenter_TextPointers:
	dw PewterHealNurseText
	dw PewterPokecenterText2
	dw PewterJigglypuffText
	dw PewterTradeNurseText
	dw PewterPokecenterText5
	dw PewterPokecenterText6
	; from Mart
	dw PewterCashierText
	dw PewterMartText2
	dw PewterMartText3

PewterHealNurseText:
	script_pokecenter_nurse

PewterPokecenterText2:
	text_far _PewterPokecenterText2
	text_end

PewterJigglypuffText:
	text_asm
	farcall PewterJigglypuff
	jp TextScriptEnd

PewterTradeNurseText:
	script_cable_club_receptionist

PewterPokecenterText5:
	text_asm
	farcall Func_f1d98
	jp TextScriptEnd

PewterPokecenterText6:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; from Mart

PewterMartText2:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text
	text_far _PewterMartText2
	text_end

PewterMartText3:
	text_asm
	ld hl, .Text
	call PrintText
	jp TextScriptEnd

.Text
	text_far _PewterMartText3
	text_end

PewterCashierText: ; moved
	script_mart POKE_BALL, POTION, ESCAPE_ROPE, ANTIDOTE, BURN_HEAL, AWAKENING, PARLYZ_HEAL
