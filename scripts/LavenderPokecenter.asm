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
	dw LavenderCashierTextTM ; new, TM seller

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

LavenderMartText2: ; edited
	text_asm
	ld hl, LavenderMartText2_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .IKnow
	ld hl, LavenderMartText2_Dunno
	jr .printAndEnd
.IKnow
	ld hl, LavenderMartText2_Where
	call PrintText
	call YesNoChoice
	ld hl, LavenderMartText2_NotFun
.printAndEnd
	call PrintText
	jp TextScriptEnd

LavenderMartText2_Question: ; new
	text_far _LavenderMartText2_Question
	text_end

LavenderMartText2_Dunno: ; new
	text_far _LavenderMartText2_Dunno
	text_end

LavenderMartText2_Where: ; new
	text_far _LavenderMartText2_Where
	text_end

LavenderMartText2_NotFun: ; new
	text_far _LavenderMartText2_NotFun
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

LavenderCashierTextTM: ; testing
    text_asm
	callfar TMMartClerkDialogue
    jp TextScriptEnd
