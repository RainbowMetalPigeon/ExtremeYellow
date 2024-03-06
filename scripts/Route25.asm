Route25_Script:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	call nz, Route25OpenPathToHauntedHouse
	call EnableAutoTextBoxDrawing
	ld hl, Route25TrainerHeaders
	ld de, Route25_ScriptPointers
	ld a, [wRoute25CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute25CurScript], a
	call Route25Script_515e1
	ret

Route25OpenPathToHauntedHouse: ; new
	ResetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_1
	ResetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_2
	ResetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_3
	CheckEvent EVENT_UNLOCKED_PATH_TO_HAUNTED_HOUSE
	ret z ; if we have not unlocked, do nothing, as by default the path is blocked
Route25OpenPathToHauntedHouse_Core:

	ld a, $29 ; plateau on the left, edge on the right
	ld [wNewTileBlockID], a
	lb bc, 12, 21
	predef ReplaceTileBlock
	lb bc, 13, 21
	predef ReplaceTileBlock

	ld a, $31 ; free path
	ld [wNewTileBlockID], a
	lb bc, 12, 22
	predef ReplaceTileBlock
	lb bc, 13, 22
	predef ReplaceTileBlock

	ld a, $28 ; plateau on the right, edge on the left
	ld [wNewTileBlockID], a
	lb bc, 12, 23
	predef ReplaceTileBlock

	ld a, $24 ; bottom-left corner, plateau top-right
	ld [wNewTileBlockID], a
	lb bc, 13, 23
	predef ReplaceTileBlock; testing

	ret ; testing

Route25Script_515e1:
	ld hl, wd492
	res 2, [hl]
	res 3, [hl]
	res 4, [hl]
	res 7, [hl]
	xor a
	ld [wBillsHouseCurScript], a
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	CheckEventHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
	ret nz
	CheckEventReuseHL EVENT_MET_BILL_2
	jr nz, .asm_51638
	ResetEventReuseHL EVENT_BILL_SAID_USE_CELL_SEPARATOR
	ld a, HS_BILL_POKEMON
	ld [wMissableObjectIndex], a
	predef ShowObject
	jr .asm_5165c
.asm_51638
	CheckEventAfterBranchReuseHL EVENT_GOT_SS_TICKET, EVENT_MET_BILL_2
	jr z, .asm_5165c
	SetEventReuseHL EVENT_LEFT_BILLS_HOUSE_AFTER_HELPING
;	ld a, HS_NUGGET_BRIDGE_GUY		; edited, moved after Obsidian Warehouse
;	ld [wMissableObjectIndex], a	; edited, moved after Obsidian Warehouse
;	predef HideObject				; edited, moved after Obsidian Warehouse
	ld a, HS_BILL_1
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_BILL_2
	ld [wMissableObjectIndex], a
	predef ShowObject
.asm_5165c
	ret

Route25_ScriptPointers:
	dw Route25Script0 ; edited, was CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route25Script0: ; new
	CheckEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_1
	jr nz, .checkMessage2
	ld hl, Route25ToHauntedHouse_CoordinatesMessage1
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkMessage2
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_1
	ret
.checkMessage2
	CheckEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_2
	jr nz, .checkMessage3
	ld hl, Route25ToHauntedHouse_CoordinatesMessage2
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkMessage3
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_2
	ret
.checkMessage3
	CheckEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_3
	jr nz, .checkIfInTallGrass
	ld hl, Route25ToHauntedHouse_CoordinatesMessage3
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkIfInTallGrass
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_ROUTE_25_DISPLAY_HAUNTED_HOUSE_MESSAGE_3
	ret
.checkIfInTallGrass
	ld a, [wXCoord]
	cp 44
	jr c, .normalMap ; if X<=43
	cp 48
	jr nc, .normalMap ; if X>=48
	ld a, [wYCoord]
	cp 28
	jr c, .normalMap ; if Y<=27
	cp 34
	jr c, .noEncounters ; if Y<34
.normalMap
	ld hl, wd72e
	res 4, [hl]
	ResetEvent EVENT_IN_TALL_GRASS_IN_BILLS_SECRET_GARDEN
	jp CheckFightingMapTrainers
.noEncounters ; we're in the grass area of the Secret Garden of Bill
	CheckAndSetEvent EVENT_IN_TALL_GRASS_IN_BILLS_SECRET_GARDEN
	jr z, .justEnteredTheGrass
; we are already and still in the grass
	CheckEvent EVENT_UNLOCKED_PATH_TO_HAUNTED_HOUSE
	ret nz ; do nothing else if already unlocked path
	CheckEvent EVENT_WALKED_ALL_STEPS_SECRET_GARDEN
	ret z ; we still have to walk all steps
; print message (and then do more things) if walked all the steps
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_UNLOCKED_PATH_TO_HAUNTED_HOUSE
	call Route25OpenPathToHauntedHouse_Core ; testing
	ret
.justEnteredTheGrass
	CheckEvent EVENT_UNLOCKED_PATH_TO_HAUNTED_HOUSE
	jr nz, .justPreventEncounters ; no need to handle the steps if we already unlocked the path
; reset the step counters if we have just entered the grass
	ld hl, 20 ; 666, TBE
	ld a, h
	ld [wTallGrassBillsSecretGardenSteps], a
	ld a, l
	ld [wTallGrassBillsSecretGardenSteps + 1], a
.justPreventEncounters
	ld hl, wd72e
	set 4, [hl]
	ret

Route25ToHauntedHouse_CoordinatesMessage1:
	dbmapcoord 44, 23
	dbmapcoord 45, 23
	db -1 ; end

Route25ToHauntedHouse_CoordinatesMessage2:
	dbmapcoord 44, 14
	dbmapcoord 45, 14
	db -1 ; end

Route25ToHauntedHouse_CoordinatesMessage3:
	dbmapcoord 43,  6
	db -1 ; end

; ==================

Route25_TextPointers:
	dw Route25Text1
	dw Route25Text2
	dw Route25Text3
	dw Route25Text4
	dw Route25Text5
	dw Route25Text6
	dw Route25Text7
	dw Route25Text8
	dw Route25Text9
	dw PickUpItemText
	dw Route25Text11
	; new, not NPCs or signs
	dw Route25TextCompleted666Steps ; 12
	dw Route25TextToHauntedHouseMessage1 ; 13
	dw Route25TextToHauntedHouseMessage2 ; 14
	dw Route25TextToHauntedHouseMessage3 ; 15

Route25TrainerHeaders:
	def_trainers
Route25TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_0, 2, Route25BattleText1, Route25EndBattleText1, Route25AfterBattleText1
Route25TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_1, 3, Route25BattleText2, Route25EndBattleText2, Route25AfterBattleText2
Route25TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_2, 3, Route25BattleText3, Route25EndBattleText3, Route25AfterBattleText3
Route25TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_3, 2, Route25BattleText4, Route25EndBattleText4, Route25AfterBattleText4
Route25TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_4, 4, Route25BattleText5, Route25EndBattleText5, Route25AfterBattleText5
Route25TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_5, 4, Route25BattleText6, Route25EndBattleText6, Route25AfterBattleText6
Route25TrainerHeader6:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_6, 3, Route25BattleText7, Route25EndBattleText7, Route25AfterBattleText7
Route25TrainerHeader7:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_7, 2, Route25BattleText8, Route25EndBattleText8, Route25AfterBattleText8
Route25TrainerHeader8:
	trainer EVENT_BEAT_ROUTE_25_TRAINER_8, 2, Route25BattleText9, Route25EndBattleText9, Route25AfterBattleText9
	db -1 ; end

Route25Text1:
	text_asm
	ld hl, Route25TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route25Text2:
	text_asm
	ld hl, Route25TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route25Text3:
	text_asm
	ld hl, Route25TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route25Text4:
	text_asm
	ld hl, Route25TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route25Text5:
	text_asm
	ld hl, Route25TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route25Text6:
	text_asm
	ld hl, Route25TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route25Text7:
	text_asm
	ld hl, Route25TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route25Text8:
	text_asm
	ld hl, Route25TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route25Text9:
	text_asm
	ld hl, Route25TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route25BattleText1:
	text_far _Route25BattleText1
	text_end

Route25EndBattleText1:
	text_far _Route25EndBattleText1
	text_end

Route25AfterBattleText1:
	text_far _Route25AfterBattleText1
	text_end

Route25BattleText2:
	text_far _Route25BattleText2
	text_end

Route25EndBattleText2:
	text_far _Route25EndBattleText2
	text_end

Route25AfterBattleText2:
	text_far _Route25AfterBattleText2
	text_end

Route25BattleText3:
	text_far _Route25BattleText3
	text_end

Route25EndBattleText3:
	text_far _Route25EndBattleText3
	text_end

Route25AfterBattleText3:
	text_far _Route25AfterBattleText3
	text_end

Route25BattleText4:
	text_far _Route25BattleText4
	text_end

Route25EndBattleText4:
	text_far _Route25EndBattleText4
	text_end

Route25AfterBattleText4:
	text_far _Route25AfterBattleText4
	text_end

Route25BattleText5:
	text_far _Route25BattleText5
	text_end

Route25EndBattleText5:
	text_far _Route25EndBattleText5
	text_end

Route25AfterBattleText5:
	text_far _Route25AfterBattleText5
	text_end

Route25BattleText6:
	text_far _Route25BattleText6
	text_end

Route25EndBattleText6:
	text_far _Route25EndBattleText6
	text_end

Route25AfterBattleText6:
	text_far _Route25AfterBattleText6
	text_end

Route25BattleText7:
	text_far _Route25BattleText7
	text_end

Route25EndBattleText7:
	text_far _Route25EndBattleText7
	text_end

Route25AfterBattleText7:
	text_far _Route25AfterBattleText7
	text_end

Route25BattleText8:
	text_far _Route25BattleText8
	text_end

Route25EndBattleText8:
	text_far _Route25EndBattleText8
	text_end

Route25AfterBattleText8:
	text_far _Route25AfterBattleText8
	text_end

Route25BattleText9:
	text_far _Route25BattleText9
	text_end

Route25EndBattleText9:
	text_far _Route25EndBattleText9
	text_end

Route25AfterBattleText9:
	text_far _Route25AfterBattleText9
	text_end

Route25Text11:
	text_far _Route25Text11
	text_end

; new ----------------

Route25TextCompleted666Steps:
	text_far _Route25TextCompleted666Steps
	text_end

Route25TextToHauntedHouseMessage1:
	text_far _Route25TextToHauntedHouseMessage1
	text_end
	
Route25TextToHauntedHouseMessage2:
	text_far _Route25TextToHauntedHouseMessage2
	text_end
	
Route25TextToHauntedHouseMessage3:
	text_far _Route25TextToHauntedHouseMessage3
	text_end
	