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
	CheckEvent EVENT_CELADON_DINER_ONIGIRI_OBTAINED
	ld hl, CeladonDinerText1_OnigiriObtained
	jr nz, .printText
; still have to exchange the GUTSCHEIN, check if we have it
	ld b, GUTSCHEIN
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .doNotHaveGutschein
; we have the GUTSCHEIN, let's trade it for the ONIGIRI BOX
	ld hl, CeladonDinerText1_OhYouHaveGutschein
	call PrintText
	ld a, GUTSCHEIN
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	lb bc, ONIGIRI_BOX, 1
	call GiveItem
;	ld hl, CeladonDinerText1_BagFull ; cannot happen unless bugs
;	jr nc, .bagFull                  ; cannot happen unless bugs
	SetEvent EVENT_CELADON_DINER_ONIGIRI_OBTAINED
	ld hl, CeladonDinerText1_ReceivedOnigiri
	jr .printText
.doNotHaveGutschein
	ld hl, CeladonDinerText1_WeAreOnBreak
.printText
	call PrintText
	jp TextScriptEnd

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

; ----------------------------------

CeladonDinerText2:
	text_far _CeladonDinerText2
	text_end

CeladonDinerText3:
	text_far _CeladonDinerText3
	text_end

CeladonDinerText4:
	text_far _CeladonDinerText4
	text_end

CeladonDinerText5:
	text_asm
	callfar Func_f1f31
	jp TextScriptEnd
