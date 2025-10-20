SeviiThreeIslandHouses_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiThreeIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiThreeIslandHouses_ScriptPointers:
	dw SeviiThreeIslandHouses_Null ; 0
	dw SeviiThreeIslandHouses_Battle ; 1
	dw SeviiThreeIslandHouses_PostBattle ; 2

; scripts ============================

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
	text_far _SeviiThreeIslandHousesText2
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

; inputs: d = wTextBoxID type, e = top menu item X
; number of options is always 4-1
BookshelfShelfChoiceCommon:
	call SaveScreenTilesToBuffer1
	ld a, d ; inputs
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, e ; inputs
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

SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf:
	text_far _SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
	text_end

SeviiThreeIslandHousesBookshelfText1:
	text_asm
	ld hl, SeviiThreeIslandHousesBookshelfText1_ItsAboutCard
	call PrintText
;	ld hl, SeviiThreeIslandHousesBookshelfTextCommon_WhichShelf
;	call PrintText
;	ld d, BOOKSHELF_MAGIC_CARD_MENU
;	ld e, 6
;	call BookshelfShelfChoiceCommon
	jp TextScriptEnd

SeviiThreeIslandHousesBookshelfText1_ItsAboutCard:
	text_far _SeviiThreeIslandHousesBookshelfText1_ItsAboutCard
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText2:
	text_far _SeviiThreeIslandHousesBookshelfText2
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText3:
	text_far _SeviiThreeIslandHousesBookshelfText3
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText4:
	text_far _SeviiThreeIslandHousesBookshelfText4
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText5:
	text_far _SeviiThreeIslandHousesBookshelfText5
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText6:
	text_far _SeviiThreeIslandHousesBookshelfText6
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText7:
	text_far _SeviiThreeIslandHousesBookshelfText7
	text_end

; --------------------------------------

SeviiThreeIslandHousesBookshelfText8:
	text_far _SeviiThreeIslandHousesBookshelfText8
	text_end

; --------------------------------------

; scripts ============================================

SeviiThreeIslandHousesScriptText1:
	text_far _SeviiThreeIslandHousesScriptText1
	text_end

SeviiThreeIslandHousesScriptText2:
	text_far _SeviiThreeIslandHousesScriptText2
	text_end
