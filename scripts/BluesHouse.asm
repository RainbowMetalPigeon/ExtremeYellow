BluesHouse_Script:
	call EnableAutoTextBoxDrawing
	ld hl, BluesHouse_ScriptPointers
	xor a
	call CallFunctionInTable
	ret

BluesHouse_ScriptPointers:
	dw BluesHouseScript0
	dw BluesHouseScript1

BluesHouseScript0:
	SetEvent EVENT_ENTERED_BLUES_HOUSE
	ld a, $1
	ld [wBluesHouseCurScript], a
BluesHouseScript1:
	ret

BluesHouse_TextPointers:
	dw BluesHouseDaisySittingText
	dw DaisyMegaStonesCluesText
	dw BluesHouseTownMapText
	dw BluesHouseBlueText ; new
	dw BluesHouseBluesDadText ; new
	dw BluesHouseBluesMomText ; new
	dw BluesHouseOakText ; new

BluesHouseDaisySittingText: ; TBE
	text_asm
	CheckEvent EVENT_GOT_TOWN_MAP
	jr nz, .got_town_map
	CheckEvent EVENT_GOT_POKEDEX
	jr nz, .give_town_map
	ld hl, DaisyInitialText
	call PrintText
	jr .done
.give_town_map
	ld hl, DaisyOfferMapText
	call PrintText
	lb bc, TOWN_MAP, 1
	call GiveItem
	jr nc, .bag_full
	ld a, HS_TOWN_MAP
	ld [wMissableObjectIndex], a
	predef HideObject
	ld hl, GotMapText
	call PrintText
	SetEvent EVENT_GOT_TOWN_MAP
	ld hl, DaisyPostGiveMapText ; new
	call PrintText ; new
	jr .done
.got_town_map
	ld hl, DaisyMegaStonesCluesText
	call PrintText
	jr .done
.bag_full
	ld hl, DaisyBagFullText
	call PrintText
.done
	jp TextScriptEnd

DaisyInitialText:
	text_far _DaisyInitialText
	text_end

DaisyOfferMapText:
	text_far _DaisyOfferMapText
	text_end

GotMapText:
	text_far _GotMapText
	sound_get_key_item
	text_end

DaisyBagFullText:
	text_far _DaisyBagFullText
	text_end

BluesHouseTownMapText:
	text_far _BluesHouseTownMapText
	text_end

DaisyPostGiveMapText: ; new
	text_far _DaisyPostGiveMapText
	text_end

; new -------------------------

DaisyMegaStonesCluesText:
	text_asm
	CheckEvent EVENT_DEFEATED_MISSINGNO
	ld hl, BluesHouseClues_AfterMissingno
	call PrintText
	jp TextScriptEnd
	CheckEvent EVENT_ALREADY_SPOKEN_WITH_DAISY_CLUES
	ld hl, BluesHouseClues_IntroShort
	jr nz, .continueIntro
; first time speaking with Daisy about clues
	SetEvent EVENT_ALREADY_SPOKEN_WITH_DAISY_CLUES
	ld hl, BluesHouseClues_Intro
.continueIntro
	call PrintText
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
.kindaLoop
	ld hl, BluesHouseClues_Question
	call PrintText
	ld hl, MegaStoneClueList
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .kindaExit
	ld hl, TextPointers_Clues
	ld a, [wcf91]
	sub MEGASTONE_CLUE_1
	add a
	ld d, $0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call PrintText
	jr .kindaLoop
.kindaExit
	xor a
	ld [wListScrollOffset], a
	ld hl, BluesHouseClues_Outro
	call PrintText
	jp TextScriptEnd

MegaStoneClueList:
	db 6 ; #
	db MEGASTONE_CLUE_1
	db MEGASTONE_CLUE_2
	db MEGASTONE_CLUE_3
	db MEGASTONE_CLUE_4
	db MEGASTONE_CLUE_5
	db MEGASTONE_CLUE_6
	db -1 ; end

BluesHouseClues_Intro:
	text_far _BluesHouseClues_Intro
	text_end

BluesHouseClues_IntroShort:
	text_far _BluesHouseClues_IntroShort
	text_end

BluesHouseClues_AfterMissingno:
	text_far _BluesHouseClues_AfterMissingno
	text_end

BluesHouseClues_Question:
	text_far _BluesHouseClues_Question
	text_end

BluesHouseClues_Outro:
	text_far _BluesHouseClues_Outro
	text_end

TextPointers_Clues:
	dw BluesHouseClues_Clue1
	dw BluesHouseClues_Clue2
	dw BluesHouseClues_Clue3
	dw BluesHouseClues_Clue4
	dw BluesHouseClues_Clue5
	dw BluesHouseClues_Clue6

BluesHouseClues_Clue1:
	text_far _BluesHouseClues_Clue1
	text_end

BluesHouseClues_Clue2:
	text_far _BluesHouseClues_Clue2
	text_end

BluesHouseClues_Clue3:
	text_far _BluesHouseClues_Clue3
	text_end

BluesHouseClues_Clue4:
	text_far _BluesHouseClues_Clue4
	text_end

BluesHouseClues_Clue5:
	text_far _BluesHouseClues_Clue5
	text_end

BluesHouseClues_Clue6:
	text_far _BluesHouseClues_Clue6
	text_end

BluesHouseBlueText:
	text_far _BluesHouseBlueText
	text_end

BluesHouseBluesDadText:
	text_far _BluesHouseBluesDadText
	text_end

BluesHouseBluesMomText:
	text_far _BluesHouseBluesMomText
	text_end

BluesHouseOakText:
	text_far _BluesHouseOakText
	text_end
