Daycare_Script:
	RPTextChooser Daycare_TextPointers, Daycare_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

Daycare_TextPointers:
	dw DayCareMText1
	dw DayCareText2 ; new

Daycare_TextPointers_Rocket:
	dw DayCareMText1_RP
	dw DayCareText2_RP

DayCareMText1:
	text_asm
; new for increase exp/step
	CheckEvent EVENT_UNLOCKED_DAYCARE_MORE_EXP
	jr nz, .vanilla
; still base exp/step, check if we have the pamphlet
	ld b, PAMPHLET
	call IsItemInBag
	jr z, .vanilla
; we have it, give it
	ld hl, DayCareMText1_CoolPamphlet
	call PrintText
	ld a, PAMPHLET
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_UNLOCKED_DAYCARE_MORE_EXP
	ld hl, DayCareMText1_GivePamphlet
	jp .done
.vanilla
; BTV
	call SaveScreenTilesToBuffer2
	ld a, [wDayCareInUse]
	and a
	jp nz, .daycareInUse
; new
	CheckEvent EVENT_DAYCARE_HAS_ASSISTANT
	ld hl, DayCareIntroText
	jr z, .printIntro
	ld hl, DayCareIntroText_New
.printIntro
; BTV
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, DayCareComeAgainText
	jp nz, .done
	ld a, [wPartyCount]
	dec a
	ld hl, DayCareOnlyHaveOneMonText
	jp z, .done
	ld hl, DayCareWhichMonText
	call PrintText
	xor a
	ld [wUpdateSpritesEnabled], a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	call ReloadTilesetTilePatterns ; new, to expand tileset
	ld hl, DayCareAllRightThenText
	jp c, .done
	callfar KnowsHMMove
	call ReloadTilesetTilePatterns ; new, to expand tileset
	ld hl, DayCareCantAcceptMonWithHMText
	jp c, .done
	xor a
	ld [wPartyAndBillsPCSavedMenuItem], a
	ld a, [wWhichPokemon]
; new, to handle MISSINGNO
	push af
	push bc
	push de
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl] ; species
	cp MISSINGNO
	jp z, .cantTakeThisMon
; back to vanilla
	pop de
	pop bc
	pop af
	ld hl, wPartyMonNicks
	call GetPartyMonName
	call ReloadTilesetTilePatterns ; new, to expand tileset
	ld hl, DayCareWillLookAfterMonText
	call PrintText
	ld a, 1
	ld [wDayCareInUse], a
	ld a, PARTY_TO_DAYCARE
	ld [wMoveMonType], a
	call MoveMon
	callfar IsThisPartymonStarterPikachu
	push af
	xor a
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	pop af
	jr c, .depositedPikachuIntoDayCare
	ld a, [wcf91]
	call PlayCry
	jr .asm_562e3

.depositedPikachuIntoDayCare
	ldpikacry e, PikachuCry28
	callfar PlayPikachuSoundClip
.asm_562e3
	ld hl, DayCareComeSeeMeInAWhileText
	jp .done

.daycareInUse
	xor a
	ld hl, wDayCareMonName
	call GetPartyMonName
	ld a, DAYCARE_DATA
	ld [wMonDataLocation], a
	call LoadMonData
	callfar CalcLevelFromExperience
	ld a, d
	cp MAX_LEVEL
	jr c, .skipCalcExp

	ld d, MAX_LEVEL
	callfar CalcExperience
	ld hl, wDayCareMonExp
	ldh a, [hExperience]
	ld [hli], a
	ldh a, [hExperience + 1]
	ld [hli], a
	ldh a, [hExperience + 2]
	ld [hl], a
	ld d, MAX_LEVEL

.skipCalcExp
	xor a
	ld [wDayCareNumLevelsGrown], a
	ld hl, wDayCareMonBoxLevel
	ld a, [hl]
	ld [wDayCareStartLevel], a
	cp d
	ld [hl], d
	ld hl, DayCareMonNeedsMoreTimeText
	jr z, .next
	ld a, [wDayCareStartLevel]
	ld b, a
	ld a, d
	sub b
	ld [wDayCareNumLevelsGrown], a
	ld hl, DayCareMonHasGrownText

.next
	call PrintText
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	ld hl, DayCareNoRoomForMonText
	jp z, .leaveMonInDayCare
	ld de, wDayCareTotalCost
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld hl, wDayCarePerLevelCost
	ld a, $1
	ld [hli], a
	ld [hl], $0
	ld a, [wDayCareNumLevelsGrown]
	inc a
	ld b, a
	ld c, 2
.calcPriceLoop
	push hl
	push de
	push bc
	predef AddBCDPredef
	pop bc
	pop de
	pop hl
	dec b
	jr nz, .calcPriceLoop
	ld hl, DayCareOweMoneyText
	call PrintText
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	call YesNoChoice
	ld hl, DayCareAllRightThenText
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .leaveMonInDayCare
	ld hl, wDayCareTotalCost
	ldh [hMoney], a
	ld a, [hli]
	ldh [hMoney + 1], a
	ld a, [hl]
	ldh [hMoney + 2], a
	call HasEnoughMoney
	jr nc, .enoughMoney
	ld hl, DayCareNotEnoughMoneyText
	jp .leaveMonInDayCare

.enoughMoney
	xor a
	ld [wDayCareInUse], a
	ld hl, wDayCareNumLevelsGrown
	ld [hli], a
	inc hl
	ld de, wPlayerMoney + 2
	ld c, $3
	predef SubBCDPredef
	ld a, SFX_PURCHASE
	call PlaySoundWaitForCurrent
	ld a, MONEY_BOX
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, DayCareHeresYourMonText
	call PrintText
	call DayCareImproveBadDVs ; new
	ld a, DAYCARE_TO_PARTY
	ld [wMoveMonType], a
	call MoveMon
	ld a, [wDayCareMonSpecies]
	ld [wcf91], a
	ld a, [wPartyCount]
	dec a
	push af
	ld bc, wPartyMon2 - wPartyMon1
	push bc
	ld hl, wPartyMon1Moves
	call AddNTimes
	ld d, h
	ld e, l
	ld a, 1
	ld [wLearningMovesFromDayCare], a
	predef WriteMonMoves
	pop bc
	pop af

; set mon's HP to max
	ld hl, wPartyMon1HP
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, wPartyMon1MaxHP - wPartyMon1HP
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a

	ld a, [wPartyCount]
	dec a
	ld [wWhichPokemon], a
	callfar IsThisPartymonStarterPikachu
	jr c, .withdrewPikachuFromDayCare
	ld a, [wcf91]
	call PlayCry
	jr .asm_56430

.withdrewPikachuFromDayCare
	ld a, $6
	ld [wPikachuSpawnState], a

	; GameFreak... TriHard
	ld hl, SchedulePikachuSpawnForAfterText
	ld b, BANK(SchedulePikachuSpawnForAfterText)
	ld hl, Bankswitch

	ldpikacry e, PikachuCry35
	callfar PlayPikachuSoundClip
.asm_56430
	ld hl, DayCareGotMonBackText
	jr .done

.leaveMonInDayCare
	ld a, [wDayCareStartLevel]
	ld [wDayCareMonBoxLevel], a

.done
	call PrintText
	jp TextScriptEnd

; new, to handle MISSINGNO
.cantTakeThisMon
	pop de
	pop bc
	pop af
	call ReloadTilesetTilePatterns ; necessary?
	ld hl, DayCareCantTakeThisMon
	jr .done

DayCareIntroText:
	text_far _DayCareIntroText
	text_end

DayCareIntroText_New:
	text_far _DayCareIntroText_New
	text_end

DayCareWhichMonText:
	text_far _DayCareWhichMonText
	text_end

DayCareWillLookAfterMonText:
	text_far _DayCareWillLookAfterMonText
	text_end

DayCareComeSeeMeInAWhileText:
	text_far _DayCareComeSeeMeInAWhileText
	text_end

DayCareMonHasGrownText:
	text_far _DayCareMonHasGrownText
	text_end

DayCareOweMoneyText:
	text_far _DayCareOweMoneyText
	text_end

DayCareGotMonBackText:
	text_far _DayCareGotMonBackText
	text_end

DayCareMonNeedsMoreTimeText:
	text_far _DayCareMonNeedsMoreTimeText
	text_end

DayCareAllRightThenText:
	text_far _DayCareAllRightThenText
DayCareComeAgainText:
	text_far _DayCareComeAgainText
	text_end

DayCareNoRoomForMonText:
	text_far _DayCareNoRoomForMonText
	text_end

DayCareOnlyHaveOneMonText:
	text_far _DayCareOnlyHaveOneMonText
	text_end

DayCareCantAcceptMonWithHMText:
	text_far _DayCareCantAcceptMonWithHMText
	text_end

DayCareHeresYourMonText:
	text_far _DayCareHeresYourMonText
	text_end

DayCareNotEnoughMoneyText:
	text_far _DayCareNotEnoughMoneyText
	text_end

; new ----------------------------------------

DayCareMText1_CoolPamphlet:
	text_far _DayCareMText1_CoolPamphlet
	text_end

DayCareMText1_GivePamphlet:
	text_far _DayCareMText1_GivePamphlet
	text_end

DayCareCantTakeThisMon:
	text_far _DayCareCantTakeThisMon
	text_end

DayCareText2:
	text_asm
; check for Mega stone
	CheckEvent EVENT_UNLOCKED_DAYCARE_DV_IMPROVEMENT
	jr nz, .postDV
; do we have a mega stone?
	ld b, MEGA_STONE_X
	call IsItemInBag
	jr nz, .hasMegaX
	ld b, MEGA_STONE_Y
	call IsItemInBag
	jr z, .postDV
; has Mega Y
	ld b, MEGA_STONE_Y
	push bc
	jr .hasMegaCommon
.hasMegaX
	ld b, MEGA_STONE_X
	push bc
.hasMegaCommon
	ld hl, DayCareText2_CanHaveMega
	call PrintText
	call YesNoChoice
	pop bc
	ld a, [wCurrentMenuItem]
	and a
	ld hl, DayCareText2_NoGiveMega
	jp nz, .printAndEnd
; give stone and set event
	ld a, b
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_UNLOCKED_DAYCARE_DV_IMPROVEMENT
	ld hl, DayCareText2_GottenMega
	jp .printAndEnd
.postDV
; stat exp: anything still to give?
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_HP
	jr z, .showMenu
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_ATK
	jr z, .showMenu
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_DEF
	jr z, .showMenu
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPD
	jr z, .showMenu
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPC
	jr z, .showMenu
; gave everything
	ld hl, DayCareText2_EverythingGiven
	jp .printAndEnd
; at least one stat missing
.showMenu
	ld hl, DayCareText2_Intro
	call PrintText
	call DayCareStatMonChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .hp
	dec a
	jr z, .attack
	dec a
	jr z, .defense
	dec a
	jr z, .speed
	dec a
	jr z, .special
; decline
	ld hl, DayCareText2_ChoseToGiveNoMon
	jp .printAndEnd
.hp
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_HP
	jr nz, .alreadyGaveMe
	ld hl, wMonHBaseHP
	call DayCareCheckAndTakeStrongMon
	jr c, .printAndEnd
	SetEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_HP
	ld hl, DayCareText2_UnlockedStatTraining
	jr .printAndEnd

.attack
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_ATK
	jr nz, .alreadyGaveMe
	ld hl, wMonHBaseAttack
	call DayCareCheckAndTakeStrongMon
	jr c, .printAndEnd
	SetEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_ATK
	ld hl, DayCareText2_UnlockedStatTraining
	jr .printAndEnd

.defense
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_DEF
	jr nz, .alreadyGaveMe
	ld hl, wMonHBaseDefense
	call DayCareCheckAndTakeStrongMon
	jr c, .printAndEnd
	SetEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_DEF
	ld hl, DayCareText2_UnlockedStatTraining
	jr .printAndEnd

.speed
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPD
	jr nz, .alreadyGaveMe
	ld hl, wMonHBaseSpeed
	call DayCareCheckAndTakeStrongMon
	jr c, .printAndEnd
	SetEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPD
	ld hl, DayCareText2_UnlockedStatTraining
	jr .printAndEnd

.special
	CheckEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPC
	jr nz, .alreadyGaveMe
	ld hl, wMonHBaseSpecialAttack ; TBE
	call DayCareCheckAndTakeStrongMon
	jr c, .printAndEnd
	SetEvent EVENT_UNLOCKED_DAYCARE_STAT_EXP_SPC
	ld hl, DayCareText2_UnlockedStatTraining
	jr .printAndEnd

.alreadyGaveMe
	ld hl, DayCareText2_AlreadyGaveMe
.printAndEnd
	call PrintText
	jp TextScriptEnd

DayCareCheckAndTakeStrongMon:
; save the pointer
	ld a, h
	ld [wArrayForTemporaryStorage], a
	ld a, l
	ld [wArrayForTemporaryStorage+1], a
; print the menu
	call SaveScreenTilesToBuffer2
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu ; c flag if nothing was selected
	push af
	callfar InGameTrade_RestoreScreen ; this includes LoadScreenTilesFromBuffer2
	pop af
	ld hl, DayCareText2_ChoseToGiveNoMon
	jr c, .setUpToEndAndPrint
; load the stats of the mon
	ld a, [wcf91]
	ld [wd0b5], a
	call GetMonHeader
; special case for Special
	ld a, [wcf91]
	ld c, a
	callfar FindUnifiedSpecialValue ; input: c, output: d
	ld a, d
	ld [wMonHBaseSpecialAttack], a
;	ld [wMonHBaseSpecialDefense], a ; unnecessary in this case
; retrieve the pointer to the base stat
	ld a, [wArrayForTemporaryStorage]
	ld h, a
	ld a, [wArrayForTemporaryStorage+1]
	ld l, a
	ld a, [hl]
; compare with 100: is it good enough?
	cp 100
	ld hl, DayCareText2_TooWeak
	jr c, .setUpToEndAndPrint
; base stat >= 100
	ld hl, DayCareText2_WannaGiveMeThis
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, DayCareText2_ChoseToGiveNoMon
	jr nz, .setUpToEndAndPrint
; we want to give the mon
; do we have more than 1 mon?
	ld a, [wPartyCount]
	dec a
	ld hl, DayCareText2_OnlyOneMon
	jr z, .setUpToEndAndPrint
; remove the mon
	ld a, [wWhichPokemon]
	xor a
	ld [wMonDataLocation], a ; not used
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	xor a ; to ensure c flag is not set
	ret
.setUpToEndAndPrint
	scf
	ret

DayCareText2_CanHaveMega:
	text_far _DayCareText2_CanHaveMega
	text_end

DayCareText2_NoGiveMega:
	text_far _DayCareText2_NoGiveMega
	text_end

DayCareText2_GottenMega:
	text_far _DayCareText2_GottenMega
	text_end

DayCareText2_Intro:
	text_far _DayCareText2_Intro
	text_end

DayCareText2_AlreadyGaveMe:
	text_far _DayCareText2_AlreadyGaveMe
	text_end

DayCareText2_EverythingGiven:
	text_far _DayCareText2_EverythingGiven
	text_end

DayCareText2_ChoseToGiveNoMon:
	text_far _DayCareText2_ChoseToGiveNoMon
	text_end

DayCareText2_WannaGiveMeThis:
	text_far _DayCareText2_WannaGiveMeThis
	text_end

DayCareText2_TooWeak:
	text_far _DayCareText2_TooWeak
	text_end

DayCareText2_OnlyOneMon:
	text_far _DayCareText2_OnlyOneMon
	text_end

DayCareText2_UnlockedStatTraining:
	text_far _DayCareText2_UnlockedStatTraining
	text_end

DayCareStatMonChoice:
	call SaveScreenTilesToBuffer1
	ld a, DAYCARE_STAT_MON_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 3
	ld [hli], a ; top menu item Y
	ld a, 11
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 4 ; number of options - 1
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
	ld a, 5
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

DayCareImproveBadDVs:
	CheckEvent EVENT_UNLOCKED_DAYCARE_DV_IMPROVEMENT
	ret z
	ld hl, wDayCareMonDVs
	ld a, [hl]
	ld b, a ; b has the original DV pair
	and %00001111
	ld c, a ; c holds the rightmost nybble
	cp 9
	jr nc, .checkOtherHalf1
	ld c, 9
.checkOtherHalf1
	ld a, b
	and %11110000
	cp 9<<4 ; 9 shifted to the left by 4 positions
	jr nc, .doneWithThisDVPair1
	ld a, 9<<4
.doneWithThisDVPair1
	add c ; add the other nybble
	ld [hl], a
; second DV pairs
	inc hl
	ld a, [hl]
	ld b, a ; b has the original DV pair
	and %00001111
	ld c, a ; c holds the rightmost nybble
	cp 9
	jr nc, .checkOtherHalf2
	ld c, 9
.checkOtherHalf2
	ld a, b
	and %11110000
	cp 9<<4 ; 9 shifted to the left by 4 positions
	jr nc, .doneWithThisDVPair2
	ld a, 9<<4
.doneWithThisDVPair2
	add c ; add the other nybble
	ld [hl], a
	ret

; new for RP =================================

DayCareMText1_RP:
DayCareText2_RP:
	text_far _DayCareMText1_RP
	text_end
