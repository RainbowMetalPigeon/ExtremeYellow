SeviiTwoIsletHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiTwoIsletHouses_TextPointers:
	dw SeviiTwoIsletHousesText1
	dw SeviiTwoIsletHousesText2
	dw SeviiTwoIsletHousesText3
	dw SeviiTwoIsletHousesText4
	dw SeviiTwoIsletHousesText5
	dw SeviiTwoIsletHousesText6
	; signs
	dw SeviiTwoIsletHousesSignText1
	dw SeviiTwoIsletHousesSignText2

; house 1 ------------------------------

SeviiTwoIsletHousesText1:
	text_asm
	ld a, NUGGET ; TBE
	ld [wMultipurposeBuffer], a
	ld hl, SeviiTwoIsletHousesText1_Intro
	call PrintText
	call SeviiTwoIsletHouses_SellItemCore
	jp TextScriptEnd

SeviiTwoIsletHousesText2:
	text_asm
	ld a, CALCIUM ; TBE
	ld [wMultipurposeBuffer], a
	ld hl, SeviiTwoIsletHousesText2_Intro
	call PrintText
	call SeviiTwoIsletHouses_SellItemCore
	jp TextScriptEnd

SeviiTwoIsletHousesText3:
	text_far _SeviiTwoIsletHousesText3
	text_end

SeviiTwoIsletHousesText1_Intro:
	text_far _SeviiTwoIsletHousesText1_Intro
	text_end

SeviiTwoIsletHousesText2_Intro:
	text_far _SeviiTwoIsletHousesText2_Intro
	text_end

SeviiTwoIsletHousesText1and2_Refuse:
	text_far _SeviiTwoIsletHousesText1and2_Refuse
	text_end

SeviiTwoIsletHousesText1and2_BagFull:
	text_far _SeviiTwoIsletHousesText1and2_BagFull
	text_end

SeviiTwoIsletHousesText1and2_NotEnoughMoney:
	text_far _SeviiTwoIsletHousesText1and2_NotEnoughMoney
	text_end

SeviiTwoIsletHousesText1and2_Deal:
	text_far _SeviiTwoIsletHousesText1and2_Deal
	text_end

SeviiTwoIsletHouses_SellItemCore:
; print money box and ask
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .choseNo
; check if we have $015000 money
	ld a, $01
	ldh [hMoney], a
	xor a
	ldh [hMoney + 2], a
	ld a, $50
	ldh [hMoney + 1], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, SeviiTwoIsletHousesText1and2_NotEnoughMoney
	jr .printText
.enoughMoney
; try to give the item: don't take money if bag is full
	ld a, [wMultipurposeBuffer]
	ld b, a
	ld c, 1
	call GiveItem
	jr nc, .bagFull
; remove $015000 money
	ld a, $01
	ld [wPriceTemp], a
	xor a
	ld [wPriceTemp + 2], a
	ld a, $50
	ld [wPriceTemp + 1], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, SeviiTwoIsletHousesText1and2_Deal
	jr .printText
.choseNo
	ld hl, SeviiTwoIsletHousesText1and2_Refuse
	jr .printText
.bagFull
	ld hl, SeviiTwoIsletHousesText1and2_BagFull
.printText
	call PrintText
	ret

; house 2 ------------------------------

SeviiTwoIsletHousesText4:
	text_far _SeviiTwoIsletHousesText4
	text_end

SeviiTwoIsletHousesText5:
	text_far _SeviiTwoIsletHousesText5
	text_end

; house 3 ------------------------------

SeviiTwoIsletHousesText6:
	text_far _SeviiTwoIsletHousesText6
	text_end

SeviiTwoIsletHousesSignText1:
	text_far _SeviiTwoIsletHousesSignText1
	text_end

SeviiTwoIsletHousesSignText2: ; how many more steps till the 'safey-net' shiny
	text_asm

	ld a, [wNonShinyEncounters]
	ld hl, SeviiTwoIsletHousesSignText2_Core
	call PrintText

	jp TextScriptEnd

SeviiTwoIsletHousesSignText2_Core:
	text_far _SeviiTwoIsletHousesSignText2_Core
	text_end
