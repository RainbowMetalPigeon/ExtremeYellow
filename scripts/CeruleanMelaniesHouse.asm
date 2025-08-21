CeruleanMelaniesHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

CeruleanMelaniesHouse_TextPointers:
	dw CeruleanHouse1Text1
	dw CeruleanHouse1Text2
	dw CeruleanHouse1Text3
	dw CeruleanHouse1Text4
	; new, trade house
	dw CeruleanHouse1Text5
	dw CeruleanHouse1Text6
	; new, sad elder
	dw CeruleanHouse1Text7
	; new, baby expert
	dw CeruleanHouse1Text8
	; new, Misty's siblings
	dw CeruleanHouse1Text9
	dw CeruleanHouse1Text10
	dw CeruleanHouse1Text11
	; trashed
	dw CeruleanHouseTrashedText1
	dw CeruleanHouseTrashedText2
	; signs
	dw CeruleanHouse1Sign1
	dw CeruleanHouse1Sign2
	dw CeruleanHouseTrashedText3

CeruleanHouse1Text1:
	text_asm
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	CheckEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
	jr nz, .asm_1cfbf
	ld hl, CeruleanHouse1Text_1cfc8
	call PrintText
	ld a, [wPikachuHappiness]
	cp 147
	jr c, .asm_1cfb3
	ld hl, CeruleanHouse1Text_1cfce
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_1cfb6
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, BULBASAUR
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, BULBASAUR, 15 ; edited
	call GivePokemon
	jr nc, .asm_1cfb3
	ld a, [wAddedToParty]
	and a
	call z, WaitForTextScrollButtonPress
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, CeruleanHouse1Text_1cfd3
	call PrintText
	ld a, HS_CERULEAN_BULBASAUR
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_GOT_BULBASAUR_IN_CERULEAN
.asm_1cfb3
	jp TextScriptEnd
.asm_1cfb6
	ld hl, CeruleanHouse1Text_1cfdf
	call PrintText
	jp TextScriptEnd
.asm_1cfbf
	ld hl, CeruleanHouse1Text_1cfd9
	call PrintText
	jp TextScriptEnd

CeruleanHouse1Text_1cfc8:
	text_far MelanieText1
	text_waitbutton
	text_end

CeruleanHouse1Text_1cfce:
	text_far MelanieText2
	text_end

CeruleanHouse1Text_1cfd3:
	text_far MelanieText3
	text_waitbutton
	text_end

CeruleanHouse1Text_1cfd9:
	text_far MelanieText4
	text_waitbutton
	text_end

CeruleanHouse1Text_1cfdf:
	text_far MelanieText5
	text_waitbutton
	text_end

; --------------------------------------

CeruleanHouse1Text2:
	text_far MelanieBulbasaurText
	text_asm
	ld a, BULBASAUR
	call PlayCry
	jp TextScriptEnd

; --------------------------------------

CeruleanHouse1Text3:
	text_far MelanieOddishText
	text_asm
	ld a, ODDISH
	call PlayCry
	jp TextScriptEnd

; --------------------------------------

CeruleanHouse1Text4:
	text_far MelanieSandshrewText
	text_asm
	ld a, SANDSHREW
	call PlayCry
	jp TextScriptEnd

; NEW ==================================

CeruleanHouse1Text5:
	text_asm
	ld a, TRADE_FOR_SWIRLY
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

CeruleanHouse1Text6:
	text_far _CeruleanHouse1Text6
	text_end

CeruleanHouse1Text7:
	text_far _CeruleanHouse1Text7
	text_end

CeruleanHouse1Text8:
	text_far _CeruleanHouse1Text8
	text_end

CeruleanHouse1Text9:
	text_far _CeruleanHouse1Text9
	text_end

CeruleanHouse1Text10:
	text_far _CeruleanHouse1Text10
	text_end

CeruleanHouse1Text11:
	text_far _CeruleanHouse1Text11
	text_end

CeruleanHouse1Sign1:
	text_far _CeruleanHouse1Sign1
	text_end

CeruleanHouse1Sign2:
	text_far _CeruleanHouse1Sign2
	text_end

; trashed --------------------------------------

CeruleanHouseTrashedText1:
	text_asm
	ld b, TM_DIG
	predef GetQuantityOfItemInBag
	and b
	jr z, .no_dig_tm
	ld hl, CeruleanHouseTrashedText_1d6b0
	call PrintText
	jr .done
.no_dig_tm
	ld hl, CeruleanHouseTrashedText_1d6ab
	call PrintText
.done
	jp TextScriptEnd

CeruleanHouseTrashedText_1d6ab:
	text_far _CeruleanTrashedText_1d6ab
	text_end

CeruleanHouseTrashedText_1d6b0:
	text_far _CeruleanTrashedText_1d6b0
	text_end

CeruleanHouseTrashedText2:
	text_far _CeruleanHouseTrashedText2
	text_end

CeruleanHouseTrashedText3:
	text_far _CeruleanHouseTrashedText3
	text_end
