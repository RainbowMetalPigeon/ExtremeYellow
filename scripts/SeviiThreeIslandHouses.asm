SeviiThreeIslandHouses_Script:
	call HideOrShowSecretExit
	call EnableAutoTextBoxDrawing
	ld hl, SeviiThreeIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

HideOrShowSecretExit:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_SEVII_THREE_ISLAND_FOUND_SECRET_EXIT
	ret nz ; do nothing if we unlocked the exit already
	ld a, $40 ; bookshelves block
	ld [wNewTileBlockID], a
	lb bc,  0, 10
	predef_jump ReplaceTileBlock

; scripts ============================

SeviiThreeIslandHouses_ScriptPointers:
	dw SeviiThreeIslandHouses_Null ; 0
	dw SeviiThreeIslandHouses_Battle ; 1
	dw SeviiThreeIslandHouses_PostBattle ; 2

SeviiThreeIslandHouses_Null:
	ret

SeviiThreeIslandHouses_Battle:
; tutor dialogue and battle
	ld a, $0
	ld [wJoyIgnore], a
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SUPER_NERD
	ld [wCurOpponent], a
	ld a, 17
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, TerrainTutorDefeatText
	ld de, TerrainTutorDefeatText
	call SaveEndBattleTextPointers
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

TerrainTutorDefeatText:
	text_far _TerrainTutorDefeatText
	text_end

SeviiThreeIslandHouses_PostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiThreeIslandHousesResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_BEAT_TERRAIN_TUTOR
; load next script
	xor a
	ld [wJoyIgnore], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wCurMapScript], a
	ret

SeviiThreeIslandHousesResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; displays terrain choice
MoveTutorTerrainChoice:
	call SaveScreenTilesToBuffer1
	ld a, MOVE_TUTOR_TERRAIN_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 4
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 4
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; texts ============================

SeviiThreeIslandHouses_TextPointers:
	dw SeviiThreeIslandHousesText1
	dw SeviiThreeIslandHousesText2
	dw SeviiThreeIslandHousesText3
	; signs
	dw SeviiThreeIslandHousesSignText1 ; 4
	dw SeviiThreeIslandHousesSignText2 ; 5
	dw SeviiThreeIslandHousesSignText3 ; 6
	dw SeviiThreeIslandHousesBookshelfText1 ;  7
	dw SeviiThreeIslandHousesBookshelfText2 ;  8
	dw SeviiThreeIslandHousesBookshelfText3 ;  9
	dw SeviiThreeIslandHousesBookshelfText4 ; 10
	dw SeviiThreeIslandHousesBookshelfText5 ; 11
	dw SeviiThreeIslandHousesBookshelfText6 ; 12
	dw SeviiThreeIslandHousesBookshelfText7 ; 13
	dw SeviiThreeIslandHousesBookshelfText8 ; 14
	; scripts
	dw SeviiThreeIslandHousesScriptText1 ; 15 ; pre-battle
	dw SeviiThreeIslandHousesScriptText2 ; 16 ; post-battle

SeviiThreeIslandHousesText1: ; tutor
	text_asm
	CheckEvent EVENT_SEVII_BEAT_TERRAIN_TUTOR
	jr z, .notDefeatedYet
; we have unlocked the tutor already
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiThreeIslandHousesText1_Question
	call PrintText
	call MoveTutorTerrainChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .grassy
	dec a
	jr z, .electric
	dec a
	jr z, .misty
	dec a
	jr z, .psychic
; decline
	ld hl, SeviiThreeIslandHousesText1_Refused
	jr .printAndEnd
.electric
	ld a, ELECTRIC_TERRAIN
	jr .learnMove
.grassy
	ld a, GRASSY_TERRAIN
	jr .learnMove
.psychic
	ld a, PSYCHIC_TERRAIN
	jr .learnMove
.misty
	ld a, MISTY_TERRAIN
.learnMove
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiThreeIslandHousesText1_Done
	jr .printAndEnd
.notDefeatedYet
	ld hl, SeviiThreeIslandHousesText1_Intro
	call PrintText
	ld d, ELECTRIC
	callfar CheckIfACertainTypeIsInParty ; z flag if found
	jr nz, .no
	ld d, GRASS
	callfar CheckIfACertainTypeIsInParty
	jr nz, .no
	ld d, PSYCHIC_TYPE
	callfar CheckIfACertainTypeIsInParty
	jr nz, .no
	ld d, FAIRY
	callfar CheckIfACertainTypeIsInParty
	jr nz, .no
; yes
	ld a, 1
	ld [wCurMapScript], a
	ld hl, SeviiThreeIslandHousesText1_YesRightTypes
	jr .printAndEnd
.no
	ld hl, SeviiThreeIslandHousesText1_NoRightTypes
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesText1_Intro:
	text_far _SeviiThreeIslandHousesText1_Intro
	text_end

SeviiThreeIslandHousesText1_NoRightTypes:
	text_far _SeviiThreeIslandHousesText1_NoRightTypes
	text_end

SeviiThreeIslandHousesText1_YesRightTypes:
	text_far _SeviiThreeIslandHousesText1_YesRightTypes
	text_end

SeviiThreeIslandHousesText1_Question:
	text_far _SeviiThreeIslandHousesText1_Question
	text_end

SeviiThreeIslandHousesText1_Refused:
	text_far _SeviiThreeIslandHousesText1_Refused
	text_end

SeviiThreeIslandHousesText1_Done:
	text_far _SeviiThreeIslandHousesText1_Done
	text_end

SeviiThreeIslandHousesText2:
	text_asm
	CheckEvent EVENT_SEVII_THREE_ISLAND_FOUND_SECRET_EXIT
	ld hl, SeviiThreeIslandHousesText2_Before
	jr z, .printAndEnd
	ld hl, SeviiThreeIslandHousesText2_After
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesText2_Before:
	text_far _SeviiThreeIslandHousesText2_Before
	text_end

SeviiThreeIslandHousesText2_After:
	text_far _SeviiThreeIslandHousesText2_After
	text_end

SeviiThreeIslandHousesText3:
	text_far _SeviiThreeIslandHousesText3
	text_end

; signs

SeviiThreeIslandHousesSignText1:
	text_far _SeviiThreeIslandHousesSignText1
	text_end

SeviiThreeIslandHousesSignText2:
	text_far _SeviiThreeIslandHousesSignText2
	text_end

SeviiThreeIslandHousesSignText3:
	text_far _SeviiThreeIslandHousesSignText3
	text_end

; ============================================

BookshelfBookChoiceShared:
	call SaveScreenTilesToBuffer1
	ld a, BOOKSHELF_BOOK_1_2_3_4_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 11
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 4
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; inputs: d = wTextBoxID type, e = top menu item X
; number of options is always 4-1
BookshelfShelfChoiceCommon:
	push de
	call SaveScreenTilesToBuffer1
	pop de
	push de
	ld a, d ; inputs
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 7
	ld [hli], a ; top menu item Y
	pop de
	ld a, e ; inputs
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 2 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 3
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf:
	text_far _SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	text_end

SeviiThreeIslandHousesBookshelfTextCommon_Nah:
	text_far _SeviiThreeIslandHousesBookshelfTextCommon_Nah
	text_end

SeviiThreeIslandHousesBookshelfTextCommon_WhichBook:
	text_far _SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText1:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText1_ItsAboutCard ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_CARD_MENU, 11 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText1_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText1_ItsAboutCard: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText1_ItsAboutCard ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText1_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText1_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText1_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText1_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText1_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText2:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText2_ItsAboutCoins ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_COIN_MENU, 8 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText2_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText2_ItsAboutCoins: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText2_ItsAboutCoins ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText2_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText2_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText2_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText2_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText2_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText3:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText3_ItsAboutRope ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_ROPE_MENU, 8 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText3_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText3_ItsAboutRope: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText3_ItsAboutRope ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText3_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText3_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText3_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText3_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText3_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText4:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText4_ItsAboutRing ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_RING_MENU, 9 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText4_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText4_ItsAboutRing: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText4_ItsAboutRing ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText4_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText4_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText4_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText4_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText4_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText5:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText5_ItsAboutLevitation ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_LEVITATION_MENU, 12 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText5_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText5_ItsAboutLevitation: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText5_ItsAboutLevitation ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText5_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText5_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText5_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText5_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText5_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText6:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText6_ItsAboutVanish ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_VANISH_MENU, 11 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf1_Book1
	jp .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf1_Book2
	jp .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf1_Book3
	jp .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf1_Book4
	jp .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2 ; fake book, switch for the secret exit
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf3_Book2
	call PrintText
	call WaitForSoundToFinish
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
	SetEvent EVENT_SEVII_THREE_ISLAND_FOUND_SECRET_EXIT
	ld a, $09 ; exit block
	ld [wNewTileBlockID], a
	lb bc,  0, 10
	predef ReplaceTileBlock
	jr .done
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText6_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText6_ItsAboutVanish: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText6_ItsAboutVanish ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText6_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText6_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText6_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf3_Book2: ; !
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf3_Book2 ; !
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText6_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText6_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText7:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText7_ItsAboutMentalism ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_MENTALISM_MENU, 12 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText7_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText7_ItsAboutMentalism: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText7_ItsAboutMentalism ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText7_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText7_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText7_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText7_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText7_Shelf3_Book4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText8:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText8_ItsAboutMiscellanea ; TBE
	call PrintText
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	call PrintText
	lb de, BOOKSHELF_MAGIC_MISCELLANEA_MENU, 11 ; TBE
	call BookshelfShelfChoiceCommon

	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1
	dec a
	jr z, .shelf2
	dec a
	jr z, .shelf3
.decline
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_Nah
	jp .printAndEnd

.shelf1
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf1_book1
	dec a
	jr z, .shelf1_book2
	dec a
	jr z, .shelf1_book3
	dec a
	jr z, .shelf1_book4
	jr .decline
.shelf1_book1
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf1_Book1
	jr .printAndEnd
.shelf1_book2
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf1_Book2
	jr .printAndEnd
.shelf1_book3
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf1_Book3
	jr .printAndEnd
.shelf1_book4
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf1_Book4
	jr .printAndEnd

.shelf2
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf2_book1
	dec a
	jr z, .shelf2_book2
	dec a
	jr z, .shelf2_book3
	dec a
	jr z, .shelf2_book4
	jr .decline
.shelf2_book1
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf2_Book1
	jr .printAndEnd
.shelf2_book2
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf2_Book2
	jr .printAndEnd
.shelf2_book3
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf2_Book3
	jr .printAndEnd
.shelf2_book4
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf2_Book4
	jr .printAndEnd

.shelf3
	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichBook
	call PrintText
	call BookshelfBookChoiceShared
	ld a, [wCurrentMenuItem]
	and a
	jr z, .shelf3_book1
	dec a
	jr z, .shelf3_book2
	dec a
	jr z, .shelf3_book3
	dec a
	jr z, .shelf3_book4
	jr .decline
.shelf3_book1
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf3_Book1
	jr .printAndEnd
.shelf3_book2
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2
	jr .printAndEnd
.shelf3_book3
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf3_Book3
	jr .printAndEnd
.shelf3_book4
	ld hl, SeviiThreeIslandHousesBookshelfText8_Shelf3_Book4
	jr .printAndEnd

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText8_ItsAboutMiscellanea: ; TBE
	text_far _SeviiThreeIslandHousesBookshelfText8_ItsAboutMiscellanea ; TBE
	text_end

SeviiThreeIslandHousesBookshelfText8_Shelf1_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf1_Book1
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf1_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf1_Book2
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf1_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf1_Book3
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf1_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf1_Book4
	text_end

SeviiThreeIslandHousesBookshelfText8_Shelf2_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf2_Book1
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf2_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf2_Book2
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf2_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf2_Book3
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf2_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf2_Book4
	text_end

SeviiThreeIslandHousesBookshelfText8_Shelf3_Book1:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book1
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book2
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf3_Book3:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book3
	text_end
SeviiThreeIslandHousesBookshelfText8_Shelf3_Book4:
	text_far _SeviiThreeIslandHousesBookshelfText8_Shelf3_Book4
	text_end

; --------------------------------------

; scripts ============================================

SeviiThreeIslandHousesScriptText1:
	text_far _SeviiThreeIslandHousesScriptText1
	text_end

SeviiThreeIslandHousesScriptText2:
	text_far _SeviiThreeIslandHousesScriptText2
	text_end
