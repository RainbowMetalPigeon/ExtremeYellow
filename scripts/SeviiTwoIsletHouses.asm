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
	text_asm
	CheckEvent EVENT_SHINY_RITUAL_ACTIVE
	jr z, .ritualNotActive
	ld hl, SeviiTwoIsletHousesText6_Hurry
	jr .printAndEnd
.ritualNotActive
	ld hl, SeviiTwoIsletHousesText6_Intro
	call PrintText
	ld b, NUGGET
	call IsItemInBag ; z if not
	jr z, .noIngredient
	ld b, MAX_REVIVE
	call IsItemInBag ; z if not
	jr z, .noIngredient
	ld b, MAX_ELIXER
	call IsItemInBag ; z if not
	jr z, .noIngredient
	ld b, PP_UP
	call IsItemInBag ; z if not
	jr nz, .haveIngredient
.noIngredient
	ld hl, SeviiTwoIsletHousesText6_NoIngredients
	jr .printAndEnd
.haveIngredient
	ld hl, SeviiTwoIsletHousesText6_DoRitual
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .choseNo
; perform the ritual
	call GBFadeOutToWhite
	ld a, SFX_SHRINK
	call PlaySound
	ld a, NUGGET
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld a, MAX_REVIVE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld a, MAX_ELIXER
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld a, PP_UP
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	call GBFadeInFromWhite
	SetEvent EVENT_SHINY_RITUAL_ACTIVE
	xor a
	ld [wShinyRitualSeconds], a
	ld hl, SeviiTwoIsletHousesText6_RitualDoneGo
	jr .printAndEnd
.choseNo
	ld hl, SeviiTwoIsletHousesText6_Refused
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiTwoIsletHousesText6_Intro:
	text_far _SeviiTwoIsletHousesText6_Intro
	text_end

SeviiTwoIsletHousesText6_NoIngredients:
	text_far _SeviiTwoIsletHousesText6_NoIngredients
	text_end

SeviiTwoIsletHousesText6_DoRitual:
	text_far _SeviiTwoIsletHousesText6_DoRitual
	text_end

SeviiTwoIsletHousesText6_Refused:
	text_far _SeviiTwoIsletHousesText6_Refused
	text_end

SeviiTwoIsletHousesText6_RitualDoneGo:
	text_far _SeviiTwoIsletHousesText6_RitualDoneGo
	text_end

SeviiTwoIsletHousesText6_Hurry:
	text_far _SeviiTwoIsletHousesText6_Hurry
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
