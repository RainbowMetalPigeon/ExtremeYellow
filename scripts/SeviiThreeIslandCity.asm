SeviiThreeIslandCity_Script:
	RPTextChooser SeviiThreeIslandCity_TextPointers, SeviiThreeIslandCity_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

SeviiThreeIslandCity_TextPointers:
	dw SeviiThreeIslandCityText1 ; 1
	dw SeviiThreeIslandCityText2 ; 2
	dw SeviiThreeIslandCityText3 ; 3
	dw SeviiThreeIslandCityText4 ; 4
	dw SeviiThreeIslandCityText5 ; 5
	dw SeviiThreeIslandCityText6 ; 6
	dw SeviiThreeIslandCityText7 ; 7
	dw SeviiThreeIslandCityText8 ; 8
	dw SeviiThreeIslandCityText9 ; 9
	dw PickUpItemText ; 10
	dw PickUpItemText ; 11
	dw SeviiThreeIslandCityText12 ; 12
	; signs
	dw SeviiThreeIslandCitySignText1 ; 13
	dw SeviiThreeIslandCitySignText2 ; 14
	dw SeviiThreeIslandCitySignText3 ; 15
	dw SeviiThreeIslandCitySignText4 ; 16
	dw PokeCenterSignText ; 17
	dw MartSignText ; 18

SeviiThreeIslandCity_TextPointers_Rocket:
	dw GenericNPCText_RocketPath ; 1
	dw GenericNPCText_RocketPath ; 2
	dw GenericNPCText_RocketPath ; 3
	dw GenericNPCText_RocketPath ; 4
	dw GenericNPCText_RocketPath ; 5
	dw GenericNPCText_RocketPath ; 6
	dw GenericNPCText_RocketPath ; 7
	dw GenericNPCText_RocketPath ; 8
	dw GenericNPCText_RocketPath ; 9
	dw PickUpItemText ; 10
	dw PickUpItemText ; 11
	dw SeviiThreeIslandCityText12_RP ; 12 Underground guard
	; signs
	dw SeviiThreeIslandCitySignText1 ; 13
	dw SeviiThreeIslandCitySignText2 ; 14
	dw SeviiThreeIslandCitySignText3 ; 15
	dw SeviiThreeIslandCitySignText4 ; 16
	dw PokeCenterSignText ; 17
	dw MartSignText ; 18

; scripts =========================================

; texts =========================================

SeviiThreeIslandCityText1:
	text_asm
	CheckEvent EVENT_SEVII_CLEARED_ROUTE_33
	ld hl, SeviiThreeIslandCityText1_Before
	jr z, .printAndEnd
	ld hl, SeviiThreeIslandCityText1_After
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandCityText1_Before:
	text_far _SeviiThreeIslandCityText1_Before
	text_end

SeviiThreeIslandCityText1_After:
	text_far _SeviiThreeIslandCityText1_After
	text_end

SeviiThreeIslandCityText2:
	text_far _SeviiThreeIslandCityText2
	text_end

SeviiThreeIslandCityText3:
	text_far _SeviiThreeIslandCityText3
	text_end

SeviiThreeIslandCityText4:
	text_far _SeviiThreeIslandCityText4
	text_end

SeviiThreeIslandCityText5:
	text_far _SeviiThreeIslandCityText5
	text_end

SeviiThreeIslandCityText6:
	text_far _SeviiThreeIslandCityText6
	text_end

SeviiThreeIslandCityText7:
	text_far _SeviiThreeIslandCityText7
	text_end

SeviiThreeIslandCityText8:
	text_far _SeviiThreeIslandCityText8
	text_end

SeviiThreeIslandCityText9:
	text_asm
	CheckEvent EVENT_SEVII_THREE_GOT_GIFT_FROM_KID
	ld hl, SeviiThreeIslandCityText9_AfterGift
	jr nz, .printAndEnd
; we didn't get the gift yet
	ld hl, SeviiThreeIslandCityText9_BeforeGift
	call PrintText
	lb bc, FRESH_WATER, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_SEVII_THREE_GOT_GIFT_FROM_KID
	ld hl, SeviiThreeIslandCityText9_GotGift
	call PrintText
	jr .done
.bagFull
	ld hl, SeviiThreeIslandCityText9_BagFull
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiThreeIslandCityText9_AfterGift:
	text_far _SeviiThreeIslandCityText9_AfterGift
	text_end

SeviiThreeIslandCityText9_BeforeGift:
	text_far _SeviiThreeIslandCityText9_BeforeGift
	text_end

SeviiThreeIslandCityText9_BagFull:
	text_far _SeviiThreeIslandCityText9_BagFull
	text_end

SeviiThreeIslandCityText9_GotGift:
	text_far _PlayerGotwStringBufferText
	sound_get_item_1
	text_end

SeviiThreeIslandCityText12:
	text_far _SeviiUndergroundCaveGuardText
	text_end

SeviiThreeIslandCitySignText1:
	text_far _SeviiThreeIslandCitySignText1
	text_end

SeviiThreeIslandCitySignText2:
	text_far _SeviiThreeIslandCitySignText2
	text_end

SeviiThreeIslandCitySignText3:
	text_far _SeviiThreeIslandCitySignText3
	text_end

SeviiThreeIslandCitySignText4:
	text_far _SeviiThreeIslandCitySignText4
	text_end

; new for RP ============================

SeviiThreeIslandCityText12_RP:
	text_asm
	callfar HideAllUndergroundGuards_RP
	jp TextScriptEnd
