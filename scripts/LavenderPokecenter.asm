LavenderPokecenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

LavenderPokecenter_TextPointers:
	dw LavenderHealNurseText
	dw LavenderPokecenterText2
	dw LavenderPokecenterText3
	dw LavenderTradeNurseText
	dw LavenderPokecenterText5
	; new, from Mart
	dw LavenderCashierText
	dw LavenderMartText2
	dw LavenderMartText3

LavenderTradeNurseText:
	script_cable_club_receptionist

LavenderHealNurseText:
	script_pokecenter_nurse

LavenderPokecenterText2:
	text_far _LavenderPokecenterText2
	text_end

LavenderPokecenterText3:
	text_far _LavenderPokecenterText3
	text_end

LavenderPokecenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

; new, from Mart

LavenderMartText2:
	text_far _LavenderMartText2
	text_end

LavenderMartText3:
	text_asm
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .Nugget
	ld hl, .ReviveText
	call PrintText
	jr .done
.Nugget
	ld hl, .NuggetText
	call PrintText
.done
	jp TextScriptEnd

.ReviveText
	text_far _LavenderMartReviveText
	text_end

.NuggetText
	text_far _LavenderMartNuggetText
	text_end

LavenderCashierText: ; moved
	script_mart GREAT_BALL, SUPER_POTION, REVIVE, ESCAPE_ROPE, SUPER_REPEL, ANTIDOTE, BURN_HEAL, ICE_HEAL, PARLYZ_HEAL
