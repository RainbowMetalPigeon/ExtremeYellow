ViridianForest_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ViridianForestTrainerHeaders
	ld de, ViridianForest_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

ViridianForest_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ViridianForestErikaPostBattleRematch ; new, map-dependent

ViridianForest_TextPointers:
	dw ViridianForestTextErika ; new
	dw ViridianForestText1
	dw ViridianForestText2
	dw ViridianForestText3
	dw ViridianForestText4
	dw ViridianForestText5
	dw ViridianForestText6
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw ViridianForestText10
	dw ViridianForestText11
	dw ViridianForestText12
	dw ViridianForestText13
	dw ViridianForestText14
	dw ViridianForestText15
	dw ViridianForestText16
	dw ViridianForestTextErikaPostBattle ; 18, new, map-dependent

ViridianForestTrainerHeaders:
	def_trainers 3 ; edited because of rematch Erika
ViridianForestTrainerHeader0:
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_0, 4, ViridianForestBattleText1, ViridianForestEndBattleText1, ViridianForestAfterBattleText1
ViridianForestTrainerHeader1:
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_1, 4, ViridianForestBattleText2, ViridianForestEndBattleText2, ViridianForestAfterBattleText2
ViridianForestTrainerHeader2:
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_2, 1, ViridianForestBattleText3, ViridianForestEndBattleText3, ViridianForestAfterBattleText3
ViridianForestTrainerHeader3:
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_3, 0, ViridianForestBattleText4, ViridianForestEndBattleText4, ViridianForestAfterBattleText4
ViridianForestTrainerHeader4:
	trainer EVENT_BEAT_VIRIDIAN_FOREST_TRAINER_4, 4, ViridianForestBattleText5, ViridianForestEndBattleText5, ViridianForestAfterBattleText5
	db -1 ; end

ViridianForestText1:
	text_far _ViridianForestText1
	text_end

ViridianForestText2:
	text_asm
	ld hl, ViridianForestTrainerHeader0
	jr ViridianForestTalkToTrainer

ViridianForestText3:
	text_asm
	ld hl, ViridianForestTrainerHeader1
	jr ViridianForestTalkToTrainer

ViridianForestText4:
	text_asm
	ld hl, ViridianForestTrainerHeader2
	jr ViridianForestTalkToTrainer

ViridianForestText5:
	text_asm
	ld hl, ViridianForestTrainerHeader3
	jr ViridianForestTalkToTrainer

ViridianForestText6:
	text_asm
	ld hl, ViridianForestTrainerHeader4
ViridianForestTalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

ViridianForestBattleText1:
	text_far _ViridianForestBattleText1
	text_end

ViridianForestEndBattleText1:
	text_far _ViridianForestEndBattleText1
	text_end

ViridianForestAfterBattleText1:
	text_far _ViridianFrstAfterBattleText1
	text_end

ViridianForestBattleText2:
	text_far _ViridianForestBattleText2
	text_end

ViridianForestEndBattleText2:
	text_far _ViridianForestEndBattleText2
	text_end

ViridianForestAfterBattleText2:
	text_far _ViridianFrstAfterBattleText2
	text_end

ViridianForestBattleText3:
	text_far _ViridianForestBattleText3
	text_end

ViridianForestEndBattleText3:
	text_far _ViridianForestEndBattleText3
	text_end

ViridianForestAfterBattleText3:
	text_far _ViridianFrstAfterBattleText3
	text_end

ViridianForestBattleText4:
	text_far _ViridianForestBattleTextPikaGirl
	text_end

ViridianForestEndBattleText4:
	text_far _ViridianForestEndBattleTextPikaGirl
	text_end

ViridianForestAfterBattleText4:
	text_far _ViridianForestAfterBattleTextPikaGirl
	text_end

ViridianForestBattleText5:
	text_far _ViridianForestBattleTextSamurai
	text_end

ViridianForestEndBattleText5:
	text_far _ViridianForestEndBattleTextSamurai
	text_end

ViridianForestAfterBattleText5:
	text_far _ViridianForestAfterBattleTextSamurai
	text_end

ViridianForestText10:
	text_far _ViridianForestText8
	text_end

ViridianForestText11:
	text_asm
	ld hl, Func_f2528
	jp ViridianForestScript_6120d

ViridianForestText12:
	text_asm
	ld hl, Func_f2534
	jp ViridianForestScript_6120d

ViridianForestText13:
	text_asm
	ld hl, Func_f2540
	jp ViridianForestScript_6120d

ViridianForestText14:
	text_asm
	ld hl, Func_f254c
	jp ViridianForestScript_6120d

ViridianForestText15:
	text_asm
	ld hl, Func_f2558
	jp ViridianForestScript_6120d

ViridianForestText16:
	text_asm
	ld hl, Func_f2528
ViridianForestScript_6120d:
	ld b, BANK(Func_f2528)
	call Bankswitch
	jp TextScriptEnd

; new ------------------------------------------------

ViridianForestTextErika:
	text_asm
	ld hl, ViridianForestErikaBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic

	; make this an inverse battle
	ld a, 1
	ld [wInverseBattle], a

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_ERIKA
	ld [wCurOpponent], a

	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, ViridianForestErikaPostBattleText
	ld de, ViridianForestErikaPostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $3 ; new script, map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

ViridianForestErikaBeforeBattleText:
	text_far _ViridianForestErikaBeforeBattleText
	text_end

ViridianForestErikaPostBattleText:
	text_far _ViridianForestErikaPostBattleText
	text_end

ViridianForestErikaPostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, ViridianForestResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 18 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ERIKA_REMATCH_INVERSE ; map-dependent
	jp ViridianForestResetScripts

ViridianForestResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

ViridianForestTextErikaPostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
