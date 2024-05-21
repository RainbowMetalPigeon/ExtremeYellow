VictoryRoad2F_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, VictoryRoad2Script_517c4
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, VictoryRoad2Script_517c9
	call EnableAutoTextBoxDrawing
	ld hl, VictoryRoad2TrainerHeaders
	ld de, VictoryRoad2F_ScriptPointers
	ld a, [wVictoryRoad2FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wVictoryRoad2FCurScript], a
	ret

VictoryRoad2Script_517c4:
	ResetEvent EVENT_VICTORY_ROAD_1_BOULDER_ON_SWITCH
VictoryRoad2Script_517c9:
	CheckEvent EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	jr z, .asm_517da
	push af
	ld a, $15
	lb bc, 4, 3
	call VictoryRoad2Script_517e2
	pop af
.asm_517da
	bit 7, a
	ret z
	ld a, $1d
	lb bc, 7, 11
VictoryRoad2Script_517e2:
	ld [wNewTileBlockID], a
	predef ReplaceTileBlock
	ret

VictoryRoad2F_ScriptPointers:
	dw VictoryRoad2Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw VictoryRoad2FKogaPostBattleRematch ; new, map-dependent

VictoryRoad2Script0:
	ld hl, CoordsData_51816
	call CheckBoulderCoords
	jp nc, CheckFightingMapTrainers
	ldh a, [hSpriteIndexOrTextID]
	cp $f
	jp z, CheckFightingMapTrainers
	EventFlagAddress hl, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ld a, [wCoordIndex]
	cp $2
	jr z, .asm_5180b
	CheckEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	ret nz
	jr .asm_51810
.asm_5180b
	CheckEventAfterBranchReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2, EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH1
	SetEventReuseHL EVENT_VICTORY_ROAD_2_BOULDER_ON_SWITCH2
	ret nz
.asm_51810
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ret

CoordsData_51816:
	dbmapcoord  1, 16
	dbmapcoord  9, 16
	db -1 ; end

VictoryRoad2F_TextPointers:
	dw VictoryRoad2Text1
	dw VictoryRoad2Text2
	dw VictoryRoad2Text3
	dw VictoryRoad2Text4
	dw VictoryRoad2Text5
	dw VictoryRoad2Text6 ; new
;	dw MoltresText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw VictoryRoad2TextKoga ; new, testing
	dw VictoryRoad2FTextKogaPostBattle ; 15, new, map-dependent

VictoryRoad2TrainerHeaders:
	def_trainers
VictoryRoad2TrainerHeader0:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_0, 4, VictoryRoad2BattleText1, VictoryRoad2EndBattleText1, VictoryRoad2AfterBattleText1
VictoryRoad2TrainerHeader1:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_1, 3, VictoryRoad2BattleText2, VictoryRoad2EndBattleText2, VictoryRoad2AfterBattleText2
VictoryRoad2TrainerHeader2:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_2, 3, VictoryRoad2BattleText3, VictoryRoad2EndBattleText3, VictoryRoad2AfterBattleText3
VictoryRoad2TrainerHeader3:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_3, 1, VictoryRoad2BattleText4, VictoryRoad2EndBattleText4, VictoryRoad2AfterBattleText4
VictoryRoad2TrainerHeader4:
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_4, 3, VictoryRoad2BattleText5, VictoryRoad2EndBattleText5, VictoryRoad2AfterBattleText5
VictoryRoad2TrainerHeader5: ; new
	trainer EVENT_BEAT_VICTORY_ROAD_2_TRAINER_5, 3, VictoryRoad2BattleText6, VictoryRoad2EndBattleText6, VictoryRoad2AfterBattleText6
;MoltresTrainerHeader:
;	trainer EVENT_BEAT_MOLTRES, 0, MoltresBattleText, MoltresBattleText, MoltresBattleText
	db -1 ; end

VictoryRoad2Text1:
	text_asm
	ld hl, VictoryRoad2TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2Text2:
	text_asm
	ld hl, VictoryRoad2TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2Text3:
	text_asm
	ld hl, VictoryRoad2TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2Text4:
	text_asm
	ld hl, VictoryRoad2TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2Text5:
	text_asm
	ld hl, VictoryRoad2TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

VictoryRoad2Text6: ; new
	text_asm
	ld hl, VictoryRoad2TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

;MoltresText:
;	text_asm
;	ld hl, MoltresTrainerHeader
;	call TalkToTrainer
;	jp TextScriptEnd

;MoltresBattleText:
;	text_far _MoltresBattleText
;	text_asm
;	ld a, MOLTRES
;	call PlayCry
;	call WaitForSoundToFinish
;	jp TextScriptEnd

VictoryRoad2BattleText1:
	text_far _VictoryRoad2BattleText1
	text_end

VictoryRoad2EndBattleText1:
	text_far _VictoryRoad2EndBattleText1
	text_end

VictoryRoad2AfterBattleText1:
	text_far _VictoryRoad2AfterBattleText1
	text_end

VictoryRoad2BattleText2:
	text_far _VictoryRoad2BattleText2
	text_end

VictoryRoad2EndBattleText2:
	text_far _VictoryRoad2EndBattleText2
	text_end

VictoryRoad2AfterBattleText2:
	text_far _VictoryRoad2AfterBattleText2
	text_end

VictoryRoad2BattleText3:
	text_far _VictoryRoad2BattleText3
	text_end

VictoryRoad2EndBattleText3:
	text_far _VictoryRoad2EndBattleText3
	text_end

VictoryRoad2AfterBattleText3:
	text_far _VictoryRoad2AfterBattleText3
	text_end

VictoryRoad2BattleText4:
	text_far _VictoryRoad2BattleText4
	text_end

VictoryRoad2EndBattleText4:
	text_far _VictoryRoad2EndBattleText4
	text_end

VictoryRoad2AfterBattleText4:
	text_far _VictoryRoad2AfterBattleText4
	text_end

VictoryRoad2BattleText5:
	text_far _VictoryRoad2BattleText5
	text_end

VictoryRoad2EndBattleText5:
	text_far _VictoryRoad2EndBattleText5
	text_end

VictoryRoad2AfterBattleText5:
	text_far _VictoryRoad2AfterBattleText5
	text_end

VictoryRoad2BattleText6: ; new
	text_far _VictoryRoad2BattleText6
	text_end

VictoryRoad2EndBattleText6: ; new
	text_far _VictoryRoad2EndBattleText6
	text_end

VictoryRoad2AfterBattleText6: ; new
	text_far _VictoryRoad2AfterBattleText6
	text_end

; new ------------------------------------------------

VictoryRoad2TextKoga:
	text_asm
	ld hl, VictoryRoad2KogaBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	; make this an inverse battle
	ld a, 1
	ld [wInverseBattle], a

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_KOGA
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, VictoryRoad2KogaPostBattleText
	ld de, VictoryRoad2KogaPostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $3 ; new script, map-dependent
	ld [wVictoryRoad2FCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

VictoryRoad2KogaBeforeBattleText:
	text_far _VictoryRoad2KogaBeforeBattleText
	text_end

VictoryRoad2KogaPostBattleText:
	text_far _VictoryRoad2KogaPostBattleText
	text_end

VictoryRoad2FKogaPostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, VictoryRoad2FResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 15 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA_REMATCH_INVERSE ; map-dependent
	jp VictoryRoad2FResetScripts

VictoryRoad2FResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wVictoryRoad2FCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

VictoryRoad2FTextKogaPostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
