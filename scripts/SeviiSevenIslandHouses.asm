SeviiSevenIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiSevenIslandHouses_TextPointers:
	dw SeviiSevenIslandHousesText1 ; letter
	dw SeviiSevenIslandHousesSignText1
	dw SeviiSevenIslandHousesSignText2
	dw SeviiSevenIslandHousesSignText3
	dw SeviiSevenIslandHousesSignText4
	dw SeviiSevenIslandHousesSignText5
	dw SeviiSevenIslandHousesSignText6
	dw SeviiSevenIslandHousesSignText7
	dw SeviiSevenIslandHousesSignText8 ; PC

SeviiSevenIslandHousesText1:
	text_far _SeviiSevenIslandHousesText1
	text_end

SeviiSevenIslandHousesSignText1:
	text_far _SeviiSevenIslandHousesSignText1
	text_end

SeviiSevenIslandHousesSignText2:
	text_far _SeviiSevenIslandHousesSignText2
	text_end

SeviiSevenIslandHousesSignText3:
	text_far _SeviiSevenIslandHousesSignText3
	text_end

SeviiSevenIslandHousesSignText4:
	text_far _SeviiSevenIslandHousesSignText4
	text_end

SeviiSevenIslandHousesSignText5:
	text_far _SeviiSevenIslandHousesSignText5
	text_end

SeviiSevenIslandHousesSignText6:
	text_far _SeviiSevenIslandHousesSignText6
	text_end

SeviiSevenIslandHousesSignText7:
	text_far _SeviiSevenIslandHousesSignText7
	text_end

SeviiSevenIslandHousesSignText8:
	text_asm
	CheckEvent EVENT_SEVII_STOLEN_PEARL
	ld hl, SeviiSevenIslandHousesSignText8_Empty
	jr nz, .printAndEnd
	CheckEvent EVENT_SEVII_UNLOCKED_PEARL_PC
	jr nz, .rightAnswer
; pc not unlocked yet
	call SaveScreenTilesToBuffer2
	ld hl, SeviiSevenIslandHousesSignText8_Question
	call PrintText
	call WaitForTextScrollButtonPress
	farcall DisplayUniQuizScreen
.checkTheAnswer
	ld a, [wUniQuizAnswer]
	cp "A"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "B"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "C"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "D"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+4]
	cp "E"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+5]
	cp "@"
	jr z, .rightAnswer
.wrongAnswer
	ld a, SFX_DENIED
	call PlaySound
	ld hl, SeviiSevenIslandHousesSignText8_Wrong
	jr .printAndEnd
.rightAnswer
	SetEvent EVENT_SEVII_UNLOCKED_PEARL_PC
	ld hl, SeviiSevenIslandHousesSignText8_Right
	call PrintText
; try to give PEARL
	lb bc, PEARL, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_SEVII_STOLEN_PEARL
	ld a, SFX_GET_ITEM_2
	call PlaySound
	ld hl, SeviiSevenIslandHousesSignText8_GotPearl
	jr .printAndEnd
.bagFull
	ld hl, SeviiSevenIslandHousesSignText8_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiSevenIslandHousesSignText8_Question:
	text_far _SeviiSevenIslandHousesSignText8_Question
	text_end

SeviiSevenIslandHousesSignText8_Wrong:
	text_far _SeviiSevenIslandHousesSignText8_Wrong
	text_end

SeviiSevenIslandHousesSignText8_Right: ; access allowed, can withdraw
	text_far _SeviiSevenIslandHousesSignText8_Right
	text_end

SeviiSevenIslandHousesSignText8_GotPearl:
	text_far _SeviiSevenIslandHousesSignText8_GotPearl
	text_end

SeviiSevenIslandHousesSignText8_BagFull:
	text_far _SeviiSevenIslandHousesSignText8_BagFull
	text_end

SeviiSevenIslandHousesSignText8_Empty:
	text_far _SeviiSevenIslandHousesSignText8_Empty
	text_end
