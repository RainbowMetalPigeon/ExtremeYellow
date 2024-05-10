CeladonHotel_Script:
	jp EnableAutoTextBoxDrawing

CeladonHotel_TextPointers:
	dw CeladonHotelText1
	dw CeladonHotelText2
	dw CeladonHotelText3
	dw CeladonHotelText4 ; new, blocking guard
	dw CeladonHotelText5 ; new, allowing guard

CeladonHotelText1: ; edited
	text_asm
	CheckEvent EVENT_CELADON_HOTEL_GOT_GUTSCHEIN
	jp nz, .alreadyGotGutschein
	CheckEvent EVENT_CELADON_HOTEL_PAID_ROOM
	jp nz, .alreadyPaidRoom
	ld hl, CeladonHotelText1_WannaARoom
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .choseNo
	; $050000 ; [wPriceTemp+1] is the LEAST significant
	ld a, $5
	ldh [hMoney], a
	xor a
	ldh [hMoney + 1], a
	ldh [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, CeladonHotelText1_NotEnoughMoney
	jr .printText
.enoughMoney
	; $050000
	ld a, $5
	ld [wPriceTemp], a
	xor a
	ld [wPriceTemp + 1], a
	ld [wPriceTemp + 2], a
	ld hl, wPriceTemp + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, CeladonHotelText1_ExcellentChoice
	call PrintText
	SetEvent EVENT_CELADON_HOTEL_PAID_ROOM
	ld a, HS_CELADON_HOTEL_GUARD_BLOCKING
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_CELADON_HOTEL_GUARD_ALLOWING
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
.tryGivingGutschein
	lb bc, GUTSCHEIN, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_CELADON_HOTEL_GOT_GUTSCHEIN
	ld hl, CeladonHotelText1_GutscheinReceived
	jr .printText
.bagFull
	ld hl, CeladonHotelText1_BagFull
	jr .printText
.choseNo
	ld hl, CeladonHotelText1_RefusedRoom
	jr .printText
.alreadyGotGutschein
	ld hl, CeladonHotelText1_AlreadyGotGutschein
	jr .printText
.alreadyPaidRoom
	ld hl, CeladonHotelText1_AlreadyPaidRoom
	call PrintText
	jr .tryGivingGutschein
.printText
	call PrintText
.done
	jp TextScriptEnd

CeladonHotelText1_WannaARoom:
	text_far _CeladonHotelText1_WannaARoom
	text_end

CeladonHotelText1_AlreadyPaidRoom:
	text_far _CeladonHotelText1_AlreadyPaidRoom
	text_end

CeladonHotelText1_AlreadyGotGutschein:
	text_far _CeladonHotelText1_AlreadyGotGutschein
	text_end

CeladonHotelText1_NotEnoughMoney:
	text_far _CeladonHotelText1_NotEnoughMoney
	text_end

CeladonHotelText1_RefusedRoom:
	text_far _CeladonHotelText1_RefusedRoom
	text_end

CeladonHotelText1_GutscheinReceived:
	text_far _CeladonHotelText1_GutscheinReceived
	sound_get_item_2
	text_end

CeladonHotelText1_BagFull:
	text_far _CeladonHotelText1_BagFull
	text_end

CeladonHotelText1_ExcellentChoice:
	text_far _CeladonHotelText1_ExcellentChoice
	text_end

; -----------------------------------------

CeladonHotelText2:
	text_far _CeladonHotelText2
	text_end

CeladonHotelText3:
	text_far _CeladonHotelText3
	text_end

CeladonHotelText4: ; new
	text_far _CeladonHotelText4
	text_end

CeladonHotelText5: ; new
	text_far _CeladonHotelText5
	text_end
