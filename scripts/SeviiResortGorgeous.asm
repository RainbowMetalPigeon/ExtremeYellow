SeviiResortGorgeous_Script:
	jp EnableAutoTextBoxDrawing

SeviiResortGorgeous_TextPointers:
	dw SeviiResortGorgeousText1
	dw SeviiResortGorgeousText2
	; signs
	dw SeviiResortGorgeousText3
	dw SeviiResortGorgeousText4
	dw SeviiResortGorgeousText5
	dw SeviiResortGorgeousText6
	dw SeviiResortGorgeousText7
	dw SeviiResortGorgeousText8
	dw SeviiResortGorgeousText9
	dw SeviiResortGorgeousText10
	dw SeviiResortGorgeousText11
	dw SeviiResortGorgeousText12
	dw SeviiResortGorgeousText13
	dw SeviiResortGorgeousText14

SeviiResortGorgeousText1: ; Selphy
	text_asm
	CheckEvent EVENT_GOT_WATERFALL_FROM_SELPHY
	jr z, .beforePearl
; after Pearl
	ld hl, SeviiResortGorgeousText1_AfterPearl
	jr .printAndEnd
.beforePearl
	ld hl, SeviiResortGorgeousText1_BeforePearl
	call PrintText
	lb bc, HM_WATERFALL, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_WATERFALL_FROM_SELPHY
	ld hl, SeviiResortGorgeousText1_GotPearl
	jr .printAndEnd
.bagFull
	ld hl, SeviiResortGorgeousText1_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiResortGorgeousText1_BeforePearl:
	text_far _SeviiResortGorgeousText1_BeforePearl
	text_end

SeviiResortGorgeousText1_BagFull:
	text_far _SeviiResortGorgeousText1_BagFull
	text_end

SeviiResortGorgeousText1_GotPearl:
	text_far _SeviiResortGorgeousText1_GotPearl
	text_end

SeviiResortGorgeousText1_AfterPearl:
	text_far _SeviiResortGorgeousText1_AfterPearl
	text_end

SeviiResortGorgeousText2: ; butler
	text_asm
	ld hl, SeviiResortGorgeousText2_BeforeRescue
	CheckEvent EVENT_RESCUED_SELPHY
	jr z, .before
	ld hl, SeviiResortGorgeousText2_AfterRescue
.before
	call PrintText
	jp TextScriptEnd

SeviiResortGorgeousText2_BeforeRescue:
	text_far _SeviiResortGorgeousText2_BeforeRescue
	text_end

SeviiResortGorgeousText2_AfterRescue:
	text_far _SeviiResortGorgeousText2_AfterRescue
	text_end

SeviiResortGorgeousText3:
	text_far _SeviiResortGorgeousText3
	text_end

SeviiResortGorgeousText4:
	text_far _SeviiResortGorgeousText4
	text_end

SeviiResortGorgeousText5:
	text_far _SeviiResortGorgeousText5
	text_end

SeviiResortGorgeousText6:
	text_far _SeviiResortGorgeousText6
	text_end

SeviiResortGorgeousText7:
SeviiResortGorgeousText8:
	text_far _SeviiResortGorgeousText8
	text_end

SeviiResortGorgeousText9:
	text_far _SeviiResortGorgeousText9
	text_end

SeviiResortGorgeousText10:
	text_far _SeviiResortGorgeousText10
	text_end

SeviiResortGorgeousText11:
	text_far _SeviiResortGorgeousText11
	text_end

SeviiResortGorgeousText12:
	text_far _SeviiResortGorgeousText12
	text_end

SeviiResortGorgeousText13:
	text_far _SeviiResortGorgeousText13
	text_end

SeviiResortGorgeousText14:
	text_far _SeviiResortGorgeousText14
	text_end
	