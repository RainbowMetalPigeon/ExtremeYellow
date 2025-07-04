VictoryRoad1F_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, .next
	call EnableAutoTextBoxDrawing
	ld hl, VictoryRoad1TrainerHeaders
	ld de, VictoryRoad1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret
.next
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret z
	ld a, $1d
	ld [wNewTileBlockID], a
	lb bc, 6, 4
	predef_jump ReplaceTileBlock

VictoryRoad1F_ScriptPointers:
	dw VictoryRoad1Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

VictoryRoad1Script0:
	CheckEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	jp nz, CheckFightingMapTrainers
	ld hl, CoordsData_5da5c
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ldh a, [hSpriteIndex]
	cp $f
	jp z, CheckFightingMapTrainers
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	SetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
	ret

CoordsData_5da5c:
	dbmapcoord 17, 13
	db -1 ; end

VictoryRoad1F_TextPointers:
	dw VictoryRoad1Text1
	dw VictoryRoad1Text2
	dw VictoryRoad1Text3
	dw VictoryRoad1Text4
	dw PickUpItemText
	dw PickUpItemText
	dw BoulderText
	dw BoulderText
	dw BoulderText

VictoryRoad1TrainerHeaders:
	def_trainers
VictoryRoad1TrainerHeader0: ; pseudo-GREEN
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_0, 2, VictoryRoad1BattleText1, VictoryRoad1EndBattleText1, VictoryRoad1AfterBattleText1
VictoryRoad1TrainerHeader1: ; pseudo-RED
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_1, 4, VictoryRoad1BattleText2, VictoryRoad1EndBattleText2, VictoryRoad1AfterBattleText2
VictoryRoad1TrainerHeader2: ; pseudo-YELLOW
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_2, 1, VictoryRoad1BattleText3, VictoryRoad1EndBattleText3, VictoryRoad1AfterBattleText3
VictoryRoad1TrainerHeader3: ; pseudo-BLUE
	trainer EVENT_BEAT_VICTORY_ROAD_1_TRAINER_3, 1, VictoryRoad1BattleText4, VictoryRoad1EndBattleText4, VictoryRoad1AfterBattleText4
	db -1 ; end

VictoryRoad1Text1:
	text_asm
	ld hl, VictoryRoad1TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1Text2:
	text_asm
	ld hl, VictoryRoad1TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1Text3:
	text_asm
	ld hl, VictoryRoad1TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1Text4:
	text_asm
	ld hl, VictoryRoad1TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad1BattleText1:
	text_far _VictoryRoad1BattleText1
	text_end

VictoryRoad1EndBattleText1:
	text_far _VictoryRoad1EndBattleText1
	text_end

VictoryRoad1AfterBattleText1:
	text_far _VictoryRoad1AfterBattleText1
	text_end

VictoryRoad1BattleText2:
	text_far _VictoryRoad1BattleText2
	text_end

VictoryRoad1EndBattleText2:
	text_far _VictoryRoad1EndBattleText2
	text_end

VictoryRoad1AfterBattleText2:
	text_far _VictoryRoad1AfterBattleText2
	text_end

VictoryRoad1BattleText3:
	text_far _VictoryRoad1BattleText3
	text_end

VictoryRoad1EndBattleText3:
	text_far _VictoryRoad1EndBattleText3
	text_end

VictoryRoad1AfterBattleText3:
	text_far _VictoryRoad1AfterBattleText3
	text_end

VictoryRoad1BattleText4:
	text_far _VictoryRoad1BattleText4
	text_end

VictoryRoad1EndBattleText4:
	text_far _VictoryRoad1EndBattleText4
	text_end

VictoryRoad1AfterBattleText4:
	text_far _VictoryRoad1AfterBattleText4
	text_end
