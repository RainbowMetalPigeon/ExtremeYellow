Route4_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route4TrainerHeaders
	ld de, Route4_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route4_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route4Script_PostSpecialBirdKeeper

Route4_TextPointers:
	dw Route4Text1
	dw Route4TextHiker1 ; new
	dw Route4TextHiker2 ; new
	dw Route4Text2 ; trainer
	dw PickUpItemText
	dw PickUpItemText ; new
	dw BoulderText ; new
	dw BoulderText ; new
	dw BoulderText ; new
	dw BoulderText ; new
	dw Route4SpecialBirdKeeperText ; new
	; signs
	dw PokeCenterSignText
	dw Route4Text5
	dw Route4Text6
	; scripts
	dw Route4ScriptText1 ; 15
	dw Route4ScriptText2 ; 16
	dw Route4ScriptText3 ; 17

Route4TrainerHeaders:
	def_trainers 4 ; edited, was 2
Route4TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_4_TRAINER_0, 3, Route4BattleText1, Route4EndBattleText1, Route4AfterBattleText1
	db -1 ; end

Route4Text1:
	text_far _Route4Text1
	text_end

Route4TextHiker1: ; new
	text_far _Route4TextHiker1
	text_end
	
Route4TextHiker2: ; new
	text_far _Route4TextHiker2
	text_end
	
Route4Text2:
	text_asm
	ld hl, Route4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route4BattleText1:
	text_far _Route4BattleText1
	text_end

Route4EndBattleText1:
	text_far _Route4EndBattleText1
	text_end

Route4AfterBattleText1:
	text_far _Route4AfterBattleText1
	text_end

Route4Text5:
	text_far _Route4Text5
	text_end

Route4Text6:
	text_far _Route4Text6
	text_end

; ===============================

Route4SpecialBirdKeeperText:
	text_asm
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld hl, Route4SpecialBirdKeeperText_Pre
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_BIRD_KEEPER
	ld [wCurOpponent], a
	ld a, 26
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, Route4SpecialBirdKeeperText_AfterBattle
	ld de, Route4SpecialBirdKeeperText_AfterBattle
	call SaveEndBattleTextPointers

	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 3 ; Hard mode (+10%)
	ld [wLevelScaling], a

	ld a, 3
	ld [wCurMapScript], a
	jp TextScriptEnd

Route4Script_PostSpecialBirdKeeper:
	ld a, [wLevelScalingBackup] ; restore level scaling
	ld [wLevelScaling], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route4ResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	SetEvent EVENT_OBTAINED_SEEDS_BAG

	ld a, HS_ROUTE_4_SPECIAL_BIRDKEEPER
	ld [wMissableObjectIndex], a
	predef HideObject

	ld a, HS_CINNABAR_ISLAND_SPECIAL_BIRDKEEPER
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

	; TBE: show the other 2

	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	; fallthrough

Route4ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route4SpecialBirdKeeperText_Pre:
	text_far _Route4SpecialBirdKeeperText_Pre
	text_end

Route4SpecialBirdKeeperText_AfterBattle:
	text_far _Route4SpecialBirdKeeperText_AfterBattle
	text_end

Route4ScriptText1:
	text_far _Route4ScriptText1
	text_end

Route4ScriptText2:
	text_far _Route4ScriptText2
	sound_get_key_item
	text_end

Route4ScriptText3:
	text_far _Route4ScriptText3
	text_end
