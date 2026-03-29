CeladonDiner_Script:
	call EnableAutoTextBoxDrawing
	ret

CeladonDiner_TextPointers:
	dw CeladonDinerText1
	dw CeladonDinerText2
	dw CeladonDinerText3
	dw CeladonDinerText4
	dw CeladonDinerText5

CeladonDinerText1: ; edited
	text_asm
; check if we obtained Onigiri box already
	CheckEvent EVENT_CELADON_DINER_ONIGIRI_OBTAINED
	jr z, .onigiriNotObtainedYet
; if yes, print explanation message
	ld hl, CeladonDinerText1_OnigiriObtained
	call PrintText
	jr .checkMatchaMachine
.onigiriNotObtainedYet
; otherwise print kitchen is on a break
	ld hl, CeladonDinerText1_WeAreOnBreak
	call PrintText
.checkMatchaMachine
; check if we fixed the matcha machine
	CheckEvent EVENT_FIXED_MATCHA_MACHINE
	jr nz, .matchaMachineRepaired
; if not, add that the machine is broken
	call WaitForTextScrollButtonPress
	ld hl, CeladonDinerText1_AlsoMatchaMachineBroken
	call PrintText
	jr .checkGutschein
.matchaMachineRepaired
; print for matcha ask colleague
	call WaitForTextScrollButtonPress
	ld hl, CeladonDinerText1_ForMatchaAskColleague
	call PrintText
.checkGutschein
; check if we have GUTSCHEIN
	ld b, GUTSCHEIN
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .doNotHaveGutschein
; if yes, give us onigiri
	call WaitForTextScrollButtonPress
	ld hl, CeladonDinerText1_OhYouHaveGutschein
	call PrintText
	ld a, GUTSCHEIN
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	lb bc, ONIGIRI_BOX, 1
	call GiveItem
	SetEvent EVENT_CELADON_DINER_ONIGIRI_OBTAINED
	ld hl, CeladonDinerText1_ReceivedOnigiri
	call PrintText
.doNotHaveGutschein
; otherwise, end
	jp TextScriptEnd

CeladonDinerText1_ForMatchaAskColleague:
	text_far _CeladonDinerText1_ForMatchaAskColleague
	text_end

CeladonDinerText1_OnigiriObtained:
	text_far _CeladonDinerText1_OnigiriObtained
	text_end

CeladonDinerText1_OhYouHaveGutschein:
	text_far _CeladonDinerText1_OhYouHaveGutschein
	text_end

CeladonDinerText1_ReceivedOnigiri:
	text_far _CeladonDinerText1_ReceivedOnigiri
	sound_get_item_1
	text_end

CeladonDinerText1_WeAreOnBreak:
	text_far _CeladonDinerText1_WeAreOnBreak
	text_end

CeladonDinerText1_AlsoMatchaMachineBroken:
	text_far _CeladonDinerText1_AlsoMatchaMachineBroken
	text_end

; ----------------------------------

CeladonDinerText2: ; other worker
	text_asm
	ld hl, CeladonDinerText2_Intro
	call PrintText
; did we receive gift reward already?
	CheckEvent EVENT_GOT_FREE_MATCHA_TEA
	jr z, .checkIfWeJustFixedMachine
; normal selling ------------------------------
	ld hl, CeladonDinerText2_WannaBuyATea
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .choseNo
; check if we have $001000 money
	xor a
	ldh [hMoney], a
	ldh [hMoney + 2], a
	ld a, $10
	ldh [hMoney + 1], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, CeladonDinerText2_NotEnoughMoney
	jr .printAndEnd
.enoughMoney
; try to give the item: don't take money if bag is full
	lb bc, MATCHA_TEA, 1
	call GiveItem
	jr nc, .bagFull
; remove $001000 money
	xor a
	ld [wPriceTemp], a
	ld [wPriceTemp + 2], a
	ld a, $10
	ld [wPriceTemp + 1], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, CeladonDinerText2_ReceivedMatchaTea
	jr .printAndEnd
.choseNo
	ld hl, CeladonDinerText2_Declined
	jr .printAndEnd
; end of normal selling -------------------------
.checkIfWeJustFixedMachine
	CheckEvent EVENT_FIXED_MATCHA_MACHINE
	jr nz, .machineFixed
; machine still broken
	ld hl, CeladonDinerText2_MachineBroken
	jr .printAndEnd
.machineFixed
	ld hl, CeladonDinerText2_ThanksMachineGotFixed
	call PrintText
	lb bc, MATCHA_TEA, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, CeladonDinerText2_ReceivedMatchaTea
	call PrintText
	SetEvent EVENT_GOT_FREE_MATCHA_TEA
	jr .done
.bagFull
	ld hl, CeladonDinerText2_NoRoom
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

CeladonDinerText2_WannaBuyATea:
	text_far _CeladonDinerText2_WannaBuyATea
	text_end

CeladonDinerText2_NotEnoughMoney:
	text_far _CeladonDinerText2_NotEnoughMoney
	text_end

CeladonDinerText2_Declined:
	text_far _CeladonDinerText2_Declined
	text_end

CeladonDinerText2_Intro:
	text_far _CeladonDinerText2_Intro
	text_end

CeladonDinerText2_ReceivedMatchaTea:
	text_far _CeladonDinerText2_ReceivedMatchaTea
	sound_get_item_1
	text_end

CeladonDinerText2_NoRoom:
	text_far _CeladonDinerText2_NoRoom
	text_end

CeladonDinerText2_MachineBroken:
	text_far _CeladonDinerText2_MachineBroken
	text_end

CeladonDinerText2_ThanksMachineGotFixed:
	text_far _CeladonDinerText2_ThanksMachineGotFixed
	text_end

; ----------------------------------

CeladonDinerText3:
	text_far _CeladonDinerText3
	text_end

CeladonDinerText4:
	text_far _CeladonDinerText4
	text_end

; ----------------------------------

CeladonDinerText5: ; Coin Case person
	text_asm
; have we caught Coin-Case Meowth?
	CheckEvent EVENT_GOT_COIN_CASE
	ld hl, CeladonDinerText_FoundItKeepIt
	jr nz, .printAndEnd
; is it the first time we speak with the guy?
	CheckEvent EVENT_SPOKEN_WITH_COIN_CASE_GUY
	ld hl, CeladonDinerText_GoodLuckFindingIt
	jr nz, .printAndEnd
; it is the first time
	SetEvent EVENT_SPOKEN_WITH_COIN_CASE_GUY
	ld a, HS_ROUTE_30_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld hl, CeladonDinerText_ImRuined
.printAndEnd
	call PrintText
	jp TextScriptEnd

CeladonDinerText_ImRuined:
	text_far _CeladonDinerText_ImRuined
	text_end

CeladonDinerText_FoundItKeepIt:
	text_far _CeladonDinerText_FoundItKeepIt
	text_end

CeladonDinerText_GoodLuckFindingIt:
	text_far _CeladonDinerText_GoodLuckFindingIt
	text_end

/*
ReceivedCoinCaseText:
	text_far _ReceivedCoinCaseText
	sound_get_key_item
	text_end

CoinCaseExplanationText: ; new
	text_far _CoinCaseExplanationText
	text_end
*/
