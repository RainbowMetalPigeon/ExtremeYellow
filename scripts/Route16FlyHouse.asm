Route16FlyHouse_Script:
	RPTextChooser Route16FlyHouse_TextPointers, Route16FlyHouse_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

Route16FlyHouse_TextPointers:
	dw Route16HouseText1
	dw Route16HouseText2 ; Mon

Route16FlyHouse_TextPointers_Rocket:
	dw Route16HouseText1_RP
	dw Route16HouseText2 ; Mon

Route16HouseText1: ; edited
	text_asm
	CheckEvent EVENT_GOT_HM02
	ld hl, HM02ExplanationText
	jr nz, .printAndEnd
; we don't have the item yet
	ld hl, Route16HouseText3 ; intro
	call PrintText
; check if have cookie
	ld b, SEVII_COOKIE
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr nz, .haveCookie
; no cookie
	jr .done
;	ld hl, Route16HouseText_NoCookie
;	jr .printAndEnd
.haveCookie
	call WaitForTextScrollButtonPress
	ld hl, Route16HouseText_YesCookie
	call PrintText
	lb bc, HM_FLY, 1
	call GiveItem
	jr nc, .bagFull
; bag not full
	ld a, SEVII_COOKIE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_GOT_HM02
	ld hl, ReceivedHM02Text
	jr .printAndEnd
.bagFull
	ld hl, HM02NoRoomText
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

Route16HouseText_NoCookie:
	text_far _Route16HouseText_NoCookie
	text_end

Route16HouseText_YesCookie:
	text_far _Route16HouseText_YesCookie
	text_end

Route16HouseText3:
	text_far _Route16HouseText3
	text_end

ReceivedHM02Text:
	text_far _ReceivedHM02Text
	sound_get_key_item
	text_end

HM02ExplanationText:
	text_far _HM02ExplanationText
	text_end

HM02NoRoomText:
	text_far _HM02NoRoomText
	text_end

Route16HouseText2:
	text_asm
	ld hl, Route16HouseText_1e652
	call PrintText
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

Route16HouseText_1e652:
	text_far _Route16HouseText_1e652
	text_end

; new for RP --------------------

Route16HouseText1_RP:
	text_asm
; already done here?
	CheckEvent EVENT_GOT_HM02 ; abused
	ld hl, Route16HouseText1_RP_PostFly
	jp nz, .printAndEnd
; extort the item
	ld hl, Route16HouseText1_RP_PreFly
	call PrintText
	lb bc, HM_FLY, 1
	call GiveItem
	jr nc, .bagFull
; successfully stolen (bag not full)
	SetEvent EVENT_GOT_HM02
	ld hl, Route16HouseText1_RP_GotItem
	jr .printAndEnd
.bagFull
	ld hl, Route16HouseText1_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route16HouseText1_RP_PostFly:
	text_far _Route16HouseText1_RP_PostFly
	text_end
	
Route16HouseText1_RP_PreFly:
	text_far _Route16HouseText1_RP_PreFly
	text_end

Route16HouseText1_RP_BagFull:
	text_far _CeladonMartRoofText2_RP_BagFull
	text_end

Route16HouseText1_RP_GotItem:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end
