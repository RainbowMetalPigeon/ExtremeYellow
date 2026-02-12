Route10_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route10TrainerHeaders
	ld de, Route10_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route10_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route10Script_PostSpecialBirdKeeper ; new

Route10_TextPointers:
	dw Route10Text1
	dw Route10Text2
	dw Route10Text3
	dw Route10Text4
	dw Route10Text5
	dw Route10Text6
	dw Route10SpecialBirdKeeperText ; new
	; signs
	dw Route10Text7
	dw PokeCenterSignText
	dw Route10Text9
	dw Route10Text10
	; scripts
	dw Route10ScriptText1 ; 12

Route10TrainerHeaders:
	def_trainers
Route10TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_0, 4, Route10BattleText1, Route10EndBattleText1, Route10AfterBattleText1
Route10TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_1, 3, Route10BattleText2, Route10EndBattleText2, Route10AfterBattleText2
Route10TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_2, 4, Route10BattleText3, Route10EndBattleText3, Route10AfterBattleText3
Route10TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_3, 5, Route10BattleText4, Route10EndBattleText4, Route10AfterBattleText4
Route10TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_4, 2, Route10BattleText5, Route10EndBattleText5, Route10AfterBattleText5
Route10TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_10_TRAINER_5, 2, Route10BattleText6, Route10EndBattleText6, Route10AfterBattleText6
	db -1 ; end

Route10Text1:
	text_asm
	ld hl, Route10TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText1:
	text_far _Route10BattleText1
	text_end

Route10EndBattleText1:
	text_far _Route10EndBattleText1
	text_end

Route10AfterBattleText1:
	text_far _Route10AfterBattleText1
	text_end

Route10Text2:
	text_asm
	ld hl, Route10TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText2:
	text_far _Route10BattleText2
	text_end

Route10EndBattleText2:
	text_far _Route10EndBattleText2
	text_end

Route10AfterBattleText2:
	text_far _Route10AfterBattleText2
	text_end

Route10Text3:
	text_asm
	ld hl, Route10TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText3:
	text_far _Route10BattleText3
	text_end

Route10EndBattleText3:
	text_far _Route10EndBattleText3
	text_end

Route10AfterBattleText3:
	text_far _Route10AfterBattleText3
	text_end

Route10Text4:
	text_asm
	ld hl, Route10TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText4:
	text_far _Route10BattleText4
	text_end

Route10EndBattleText4:
	text_far _Route10EndBattleText4
	text_end

Route10AfterBattleText4:
	text_far _Route10AfterBattleText4
	text_end

Route10Text5:
	text_asm
	ld hl, Route10TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText5:
	text_far _Route10BattleText5
	text_end

Route10EndBattleText5:
	text_far _Route10EndBattleText5
	text_end

Route10AfterBattleText5:
	text_far _Route10AfterBattleText5
	text_end

Route10Text6:
	text_asm
	ld hl, Route10TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route10BattleText6:
	text_far _Route10BattleText6
	text_end

Route10EndBattleText6:
	text_far _Route10EndBattleText6
	text_end

Route10AfterBattleText6:
	text_far _Route10AfterBattleText6
	text_end

Route10Text9:
Route10Text7:
	text_far _Route10Text7 ; _Route10Text9
	text_end

Route10Text10:
	text_far _Route10Text10
	text_end

; ===============================

Route10SpecialBirdKeeperText:
	text_asm
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld hl, Route10SpecialBirdKeeperText_Pre
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_BIRD_KEEPER
	ld [wCurOpponent], a
	ld a, 29
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, Route10SpecialBirdKeeperText_AfterBattle
	ld de, Route10SpecialBirdKeeperText_AfterBattle
	call SaveEndBattleTextPointers
	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 3 ; Hard mode (+10%)
	ld [wLevelScaling], a
	ld a, 3
	ld [wCurMapScript], a
	jp TextScriptEnd

Route10Script_PostSpecialBirdKeeper:
	ld a, [wLevelScalingBackup] ; restore level scaling
	ld [wLevelScaling], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route10ResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_ROUTE_10_SPECIAL_BIRDKEEPER
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	; fallthrough

Route10ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route10SpecialBirdKeeperText_Pre:
	text_far _Route10SpecialBirdKeeperText_Pre
	text_end

Route10SpecialBirdKeeperText_AfterBattle:
	text_far _Route10SpecialBirdKeeperText_AfterBattle
	text_end

Route10ScriptText1:
	text_far _Route10ScriptText1
	text_end
