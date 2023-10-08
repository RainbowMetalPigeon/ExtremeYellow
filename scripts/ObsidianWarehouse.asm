ObsidianWarehouse_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ObsidianWarehouseSetDoorBlock
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianWarehouseTrainerHeaders
	ld de, ObsidianWarehouse_ScriptPointers
	ld a, [wObsidianWarehouseCurScript]
	call ExecuteCurMapScriptInTable
	ld [wObsidianWarehouseCurScript], a
	ret

ObsidianWarehouseSetDoorBlock:
	CheckEvent EVENT_OBSIDIAN_WAREHOUSE_SWITCH_CLICKED
	jr nz, .doorsOpen
	ld a, $54 ; double door block ID
	jr .replaceBlock
.doorsOpen
	ld a, $0E ; clear floor block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 3, 24
	predef_jump ReplaceTileBlock

ObsidianWarehouseResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wObsidianWarehouseCurScript], a
	ld [wCurMapScript], a
	ret

ObsidianWarehouse_ScriptPointers:
	dw ObsidianWarehouseScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ObsidianWarehouseScript3

ObsidianWarehouseScript0:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, ObsidianWarehouseArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	call StartSimulatingJoypadStates
	ld hl, wd736
	set 7, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $3
	ld [wCurMapScript], a
	ret

ObsidianWarehouseScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .ObsidianWarehouseLoadSpinnerArrow
	xor a
	ld [wJoyIgnore], a
	ld hl, wd736
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret
.ObsidianWarehouseLoadSpinnerArrow
	farjp LoadSpinnerArrowTiles

;ObsidianWarehouseOragePostBattle:
;	ld a, [wIsInBattle]
;	cp $ff
;	jp z, ObsidianWarehouseResetScripts
;	ld a, $f0
;	ld [wJoyIgnore], a
;	jp ObsidianWarehouseResetScripts

; ================ spinners - beginning ================

ObsidianWarehouseArrowTilePlayerMovement:
	; left room

	map_coord_movement  1, 26, Spinner_RIGHT_4
	map_coord_movement  5, 26, Spinner_RIGHT_6
	map_coord_movement 15, 26, Spinner_RIGHT_7
	map_coord_movement 22, 26, Spinner_DOWN_5
	map_coord_movement 26, 26, Spinner_LEFT_4

	map_coord_movement  4, 27, Spinner_RIGHT_7
	map_coord_movement 11, 27, Spinner_RIGHT_3
	map_coord_movement 14, 27, Spinner_RIGHT_2
	map_coord_movement 16, 27, Spinner_DOWN_10

	map_coord_movement  2, 28, Spinner_LEFT_1

	map_coord_movement  1, 29, Spinner_RIGHT_2
	map_coord_movement  3, 29, Spinner_RIGHT_3
	map_coord_movement  6, 29, Spinner_RIGHT_2
	map_coord_movement  8, 29, Spinner_RIGHT_4
	map_coord_movement 12, 29, Spinner_RIGHT_2
	map_coord_movement 14, 29, Spinner_DOWN_3

	map_coord_movement  4, 30, Spinner_DOWN_4
	map_coord_movement  8, 30, Spinner_LEFT_4
	map_coord_movement 26, 30, Spinner_UP_4

	map_coord_movement  9, 31, Spinner_RIGHT_3
	map_coord_movement 15, 31, Spinner_RIGHT_7
	map_coord_movement 22, 31, Spinner_DOWN_1

	map_coord_movement  3, 32, Spinner_UP_3
	map_coord_movement  5, 32, Spinner_LEFT_2
	map_coord_movement 14, 32, Spinner_DOWN_5
	map_coord_movement 18, 32, Spinner_LEFT_4
	map_coord_movement 22, 32, Spinner_LEFT_4

	map_coord_movement  4, 34, Spinner_RIGHT_4
	map_coord_movement  8, 34, Spinner_UP_3
	map_coord_movement 12, 34, Spinner_UP_5
	map_coord_movement 20, 34, Spinner_DOWN_3
	map_coord_movement 24, 34, Spinner_LEFT_4

	map_coord_movement  5, 35, Spinner_UP_3
	map_coord_movement 15, 35, Spinner_LEFT_5
	map_coord_movement 24, 35, Spinner_LEFT_3

	map_coord_movement  7, 36, Spinner_DOWN_3
	map_coord_movement 15, 36, Spinner_UP_1
	map_coord_movement 18, 36, Spinner_UP_4
	map_coord_movement 22, 36, Spinner_UP_4
	map_coord_movement 26, 36, Spinner_DOWN_6

	map_coord_movement  6, 37, Spinner_UP_8
	map_coord_movement 13, 37, Spinner_LEFT_7
	map_coord_movement 16, 37, Spinner_LEFT_2
	map_coord_movement 20, 37, Spinner_LEFT_4
	map_coord_movement 24, 37, Spinner_LEFT_4

	map_coord_movement  6, 38, Spinner_LEFT_2
	map_coord_movement 12, 38, Spinner_UP_4
	map_coord_movement 13, 38, Spinner_RIGHT_8
	map_coord_movement 21, 38, Spinner_RIGHT_5

	map_coord_movement  7, 39, Spinner_DOWN_3

	map_coord_movement  5, 40, Spinner_RIGHT_3
	map_coord_movement  8, 40, Spinner_UP_1
	map_coord_movement 16, 40, Spinner_UP_3
	map_coord_movement 21, 40, Spinner_LEFT_5

	map_coord_movement 17, 41, Spinner_DOWN_1
	map_coord_movement 21, 41, Spinner_UP_1
	map_coord_movement 25, 41, Spinner_LEFT_4

	map_coord_movement  1, 42, Spinner_UP_13
	map_coord_movement  7, 42, Spinner_LEFT_6
	map_coord_movement 18, 42, Spinner_RIGHT_8

	; right room

	map_coord_movement 36, 25, Spinner_DOWN_1
	map_coord_movement 49, 25, Spinner_LEFT_13
	map_coord_movement 52, 25, Spinner_RIGHT_6

	map_coord_movement 36, 26, Spinner_DOWN_6
	map_coord_movement 52, 26, Spinner_UP_1

	map_coord_movement 35, 27, Spinner_UP_1
	map_coord_movement 39, 27, Spinner_DOWN_10
	map_coord_movement 42, 27, Spinner_LEFT_3
	map_coord_movement 45, 27, Spinner_RIGHT_4
	map_coord_movement 49, 27, Spinner_DOWN_4
	map_coord_movement 50, 27, Spinner_UP_2
	map_coord_movement 53, 27, Spinner_DOWN_4

	map_coord_movement 35, 28, Spinner_UP_1
	map_coord_movement 37, 28, Spinner_LEFT_2
	map_coord_movement 43, 28, Spinner_LEFT_6
	map_coord_movement 46, 28, Spinner_LEFT_3
	map_coord_movement 51, 28, Spinner_LEFT_5

	map_coord_movement 37, 29, Spinner_RIGHT_6
	map_coord_movement 43, 29, Spinner_RIGHT_3
	map_coord_movement 47, 29, Spinner_RIGHT_3
	map_coord_movement 50, 29, Spinner_UP_2
	
	map_coord_movement 35, 30, Spinner_RIGHT_2
	map_coord_movement 37, 30, Spinner_UP_1
	map_coord_movement 43, 30, Spinner_LEFT_6
	map_coord_movement 46, 30, Spinner_RIGHT_6
	map_coord_movement 52, 30, Spinner_DOWN_1
	map_coord_movement 57, 30, Spinner_LEFT_5

	map_coord_movement 38, 31, Spinner_DOWN_9
	map_coord_movement 42, 31, Spinner_LEFT_4
	map_coord_movement 47, 31, Spinner_DOWN_3
	map_coord_movement 52, 31, Spinner_DOWN_1

	map_coord_movement 36, 32, Spinner_DOWN_6
	map_coord_movement 40, 32, Spinner_LEFT_4
	map_coord_movement 52, 32, Spinner_DOWN_7
	map_coord_movement 58, 32, Spinner_UP_7

	map_coord_movement 48, 33, Spinner_LEFT_6
	map_coord_movement 53, 33, Spinner_LEFT_5

	map_coord_movement 47, 34, Spinner_DOWN_5
	map_coord_movement 51, 34, Spinner_UP_6
	map_coord_movement 55, 34, Spinner_LEFT_4

	map_coord_movement 37, 35, Spinner_RIGHT_4
	map_coord_movement 41, 35, Spinner_RIGHT_2
	map_coord_movement 43, 35, Spinner_RIGHT_1
	map_coord_movement 46, 35, Spinner_UP_5
	map_coord_movement 51, 35, Spinner_RIGHT_4

	map_coord_movement 35, 36, Spinner_UP_6
	map_coord_movement 50, 36, Spinner_UP_7
	map_coord_movement 53, 36, Spinner_RIGHT_3
	map_coord_movement 56, 36, Spinner_DOWN_4

	map_coord_movement 36, 38, Spinner_RIGHT_5
	map_coord_movement 41, 38, Spinner_DOWN_2
	map_coord_movement 46, 38, Spinner_LEFT_5

	map_coord_movement 37, 39, Spinner_UP_4
	map_coord_movement 40, 39, Spinner_UP_7
	map_coord_movement 47, 39, Spinner_RIGHT_5
	map_coord_movement 52, 39, Spinner_DOWN_1

	map_coord_movement 38, 40, Spinner_RIGHT_3
	map_coord_movement 41, 40, Spinner_RIGHT_2
	map_coord_movement 43, 40, Spinner_RIGHT_3
	map_coord_movement 48, 40, Spinner_LEFT_2
	map_coord_movement 52, 40, Spinner_LEFT_4
	map_coord_movement 56, 40, Spinner_LEFT_4
	map_coord_movement 58, 40, Spinner_LEFT_2

	map_coord_movement 40, 41, Spinner_UP_2
	map_coord_movement 53, 41, Spinner_UP_5

	map_coord_movement 37, 42, Spinner_UP_3
	map_coord_movement 39, 42, Spinner_LEFT_2
	map_coord_movement 45, 42, Spinner_LEFT_2
	map_coord_movement 48, 42, Spinner_RIGHT_5
	map_coord_movement 55, 42, Spinner_UP_8

	db -1 ; end

Spinner_UP_1:
	db D_UP, 1
	db -1 ; end
Spinner_UP_2:
	db D_UP, 2
	db -1 ; end
Spinner_UP_3:
	db D_UP, 3
	db -1 ; end
Spinner_UP_4:
	db D_UP, 4
	db -1 ; end
Spinner_UP_5:
	db D_UP, 5
	db -1 ; end
Spinner_UP_6:
	db D_UP, 6
	db -1 ; end
Spinner_UP_7:
	db D_UP, 7
	db -1 ; end
Spinner_UP_8:
	db D_UP, 8
	db -1 ; end
Spinner_UP_13:
	db D_UP, 13
	db -1 ; end

Spinner_DOWN_1:
	db D_DOWN, 1
	db -1 ; end
Spinner_DOWN_2:
	db D_DOWN, 2
	db -1 ; end
Spinner_DOWN_3:
	db D_DOWN, 3
	db -1 ; end
Spinner_DOWN_4:
	db D_DOWN, 4
	db -1 ; end
Spinner_DOWN_5:
	db D_DOWN, 5
	db -1 ; end
Spinner_DOWN_6:
	db D_DOWN, 6
	db -1 ; end
Spinner_DOWN_7:
	db D_DOWN, 7
	db -1 ; end
Spinner_DOWN_9:
	db D_DOWN, 9
	db -1 ; end
Spinner_DOWN_10:
	db D_DOWN, 10
	db -1 ; end

Spinner_LEFT_1:
	db D_LEFT, 1
	db -1 ; end
Spinner_LEFT_2:
	db D_LEFT, 2
	db -1 ; end
Spinner_LEFT_3:
	db D_LEFT, 3
	db -1 ; end
Spinner_LEFT_4:
	db D_LEFT, 4
	db -1 ; end
Spinner_LEFT_5:
	db D_LEFT, 5
	db -1 ; end
Spinner_LEFT_6:
	db D_LEFT, 6
	db -1 ; end
Spinner_LEFT_7:
	db D_LEFT, 7
	db -1 ; end
Spinner_LEFT_13:
	db D_LEFT, 13
	db -1 ; end

Spinner_RIGHT_1:
	db D_RIGHT, 1
	db -1 ; end
Spinner_RIGHT_2:
	db D_RIGHT, 2
	db -1 ; end
Spinner_RIGHT_3:
	db D_RIGHT, 3
	db -1 ; end
Spinner_RIGHT_4:
	db D_RIGHT, 4
	db -1 ; end
Spinner_RIGHT_5:
	db D_RIGHT, 5
	db -1 ; end
Spinner_RIGHT_6:
	db D_RIGHT, 6
	db -1 ; end
Spinner_RIGHT_7:
	db D_RIGHT, 7
	db -1 ; end
Spinner_RIGHT_8:
	db D_RIGHT, 8
	db -1 ; end

; ================ spinners - end ================

ObsidianWarehouse_TextPointers:
	dw ObsidianWarehouseTrainerText1
	dw ObsidianWarehouseTrainerText2
	dw ObsidianWarehouseTrainerText3
	dw ObsidianWarehouseTrainerText4
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw ObsidianWarehouseStatueText

ObsidianWarehouseTrainerHeaders:
	def_trainers
ObsidianWarehouseTrainerHeader0:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_TRAINER_0, 1, ObsidianWarehouseBattleText1, ObsidianWarehouseEndBattleText1, ObsidianWarehouseAfterBattleText1
ObsidianWarehouseTrainerHeader1:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_TRAINER_1, 1, ObsidianWarehouseBattleText2, ObsidianWarehouseEndBattleText2, ObsidianWarehouseAfterBattleText2
ObsidianWarehouseTrainerHeader2:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_TRAINER_2, 1, ObsidianWarehouseBattleText3, ObsidianWarehouseEndBattleText3, ObsidianWarehouseAfterBattleText3
ObsidianWarehouseTrainerHeader3:
	trainer EVENT_BEAT_OBSIDIAN_WAREHOUSE_TRAINER_3, 1, ObsidianWarehouseBattleText4, ObsidianWarehouseEndBattleText4, ObsidianWarehouseAfterBattleText4
	db -1 ; end

; ----- trainers' texts -----

ObsidianWarehouseTrainerText1:
	text_asm
	ld hl, ObsidianWarehouseTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseBattleText1:
	text_far _ObsidianWarehouseBattleText1
	text_end

ObsidianWarehouseEndBattleText1:
	text_far _ObsidianWarehouseEndBattleText1
	text_end

ObsidianWarehouseAfterBattleText1:
	text_far _ObsidianWarehouseAfterBattleText1
	text_end

ObsidianWarehouseTrainerText2:
	text_asm
	ld hl, ObsidianWarehouseTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseBattleText2:
	text_far _ObsidianWarehouseBattleText2
	text_end

ObsidianWarehouseEndBattleText2:
	text_far _ObsidianWarehouseEndBattleText2
	text_end

ObsidianWarehouseAfterBattleText2:
	text_far _ObsidianWarehouseAfterBattleText2
	text_end

ObsidianWarehouseTrainerText3:
	text_asm
	ld hl, ObsidianWarehouseTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseBattleText3:
	text_far _ObsidianWarehouseBattleText3
	text_end

ObsidianWarehouseEndBattleText3:
	text_far _ObsidianWarehouseEndBattleText3
	text_end

ObsidianWarehouseAfterBattleText3:
	text_far _ObsidianWarehouseAfterBattleText3
	text_end

ObsidianWarehouseTrainerText4:
	text_asm
	ld hl, ObsidianWarehouseTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWarehouseBattleText4:
	text_far _ObsidianWarehouseBattleText4
	text_end

ObsidianWarehouseEndBattleText4:
	text_far _ObsidianWarehouseEndBattleText4
	text_end

ObsidianWarehouseAfterBattleText4:
	text_far _ObsidianWarehouseAfterBattleText4
	text_end

; ----- "signs" -----

ObsidianWarehouseStatueText:
	text_asm
    CheckEvent EVENT_OBSIDIAN_WAREHOUSE_SWITCH_CLICKED
    jr nz, .secondTry
; first click at the statue, open door
    ld hl, ObsidianWarehouseStatueText_Click1Pre
    call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .notClick
    ld a, SFX_GO_INSIDE
    call PlaySound
    ld hl, ObsidianWarehouseStatueText_Click1Post1
    call PrintText
    SetEvent EVENT_OBSIDIAN_WAREHOUSE_SWITCH_CLICKED
    ld a, $0E ; clear floor block ID
    ld [wNewTileBlockID], a
    lb bc, 3, 24
    predef ReplaceTileBlock
	ld a, HS_OBSIDIAN_WAREHOUSE_ITEM_EXTRA ; gift escape rope
	ld [wMissableObjectIndex], a
	predef ShowObject
    ld hl, ObsidianWarehouseStatueText_Click1Post2
    call PrintText
    jr .done
.secondTry
; second click at the statue, door already open, switch broken
    ld hl, ObsidianWarehouseStatueText_Click2
    call PrintText
	jr .done
.notClick
    ld hl, ObsidianWarehouseStatueText_Click1Not
    call PrintText
.done
    jp TextScriptEnd

ObsidianWarehouseStatueText_Click1Pre:
	text_far _ObsidianWarehouseStatueText_Click1Pre
	text_end

ObsidianWarehouseStatueText_Click1Post1:
	text_far _ObsidianWarehouseStatueText_Click1Post1
	text_end

ObsidianWarehouseStatueText_Click1Post2:
	text_far _ObsidianWarehouseStatueText_Click1Post2
	text_end

ObsidianWarehouseStatueText_Click1Not:
	text_far _ObsidianWarehouseStatueText_Click1Not
	text_end

ObsidianWarehouseStatueText_Click2:
	text_far _ObsidianWarehouseStatueText_Click2
	text_end
