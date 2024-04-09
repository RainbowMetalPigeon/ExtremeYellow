PokemonTower6F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PokemonTower6TrainerHeaders
	ld de, PokemonTower6F_ScriptPointers
	ld a, [wPokemonTower6FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonTower6FCurScript], a
	ret

PokemonTower6Script_60b02:
	xor a
	ld [wJoyIgnore], a
	ld [wPokemonTower6FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower6F_ScriptPointers:
	dw PokemonTower6Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw PokemonTower6Script3
	dw PokemonTower6Script4

PokemonTower6Script0:
	CheckEvent EVENT_BEAT_GHOST_MAROWAK
	jp nz, CheckFightingMapTrainers
	ld hl, CoordsData_60b45
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	xor a
	ldh [hJoyHeld], a
	ld a, $7 ; edited
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, RESTLESS_SOUL
	ld [wCurOpponent], a
	ld a, 30
	ld [wCurEnemyLVL], a
	ld a, $4
	ld [wPokemonTower6FCurScript], a
	ld [wCurMapScript], a
	ret

CoordsData_60b45:
	dbmapcoord 10, 16
	db -1 ; end

PokemonTower6Script4:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonTower6Script_60b02
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd72d]
	bit 6, a
	ret nz
	call UpdateSprites
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, [wBattleResult]
	and a
	jr nz, .asm_60b82
	SetEvent EVENT_BEAT_GHOST_MAROWAK
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ld a, $0
	ld [wPokemonTower6FCurScript], a
	ld [wCurMapScript], a
	ret
.asm_60b82
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, $10
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ld hl, wd730
	set 7, [hl]
	ld a, $3
	ld [wPokemonTower6FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower6Script3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wPokemonTower6FCurScript], a
	ld [wCurMapScript], a
	ret

PokemonTower6F_TextPointers:
	dw PokemonTower6TextAgatha ; new
	dw PokemonTower6Text1
	dw PokemonTower6Text2
	dw PokemonTower6Text3
	dw PickUpItemText
	dw PickUpItemText
	dw PokemonTower6Text6
	dw PokemonTower6Text7

PokemonTower6TrainerHeaders:
	def_trainers 2 ; edited because of rematch Agatha
PokemonTower6TrainerHeader0:
	trainer EVENT_BEAT_POKEMONTOWER_6_TRAINER_0, 3, PokemonTower6BattleText1, PokemonTower6EndBattleText1, PokemonTower6AfterBattleText1
PokemonTower6TrainerHeader1:
	trainer EVENT_BEAT_POKEMONTOWER_6_TRAINER_1, 3, PokemonTower6BattleText2, PokemonTower6EndBattleText2, PokemonTower6AfterBattleText2
PokemonTower6TrainerHeader2:
	trainer EVENT_BEAT_POKEMONTOWER_6_TRAINER_2, 2, PokemonTower6BattleText3, PokemonTower6EndBattleText3, PokemonTower6AfterBattleText3
	db -1 ; end

PokemonTower6Text1:
	text_asm
	ld hl, PokemonTower6TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower6Text2:
	text_asm
	ld hl, PokemonTower6TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower6Text3:
	text_asm
	ld hl, PokemonTower6TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

PokemonTower6Text7:
	text_asm
	ld hl, PokemonTower2Text_60c1f
	call PrintText
	ld a, RESTLESS_SOUL
	call PlayCry
	call WaitForSoundToFinish
	ld c, 30
	call DelayFrames
	ld hl, PokemonTower2Text_60c24
	call PrintText
	jp TextScriptEnd

PokemonTower2Text_60c1f:
	text_far _PokemonTower2Text_60c1f
	text_end

PokemonTower2Text_60c24:
	text_far _PokemonTower2Text_60c24
	text_end

PokemonTower6BattleText1:
	text_far _PokemonTower6BattleText1
	text_end

PokemonTower6EndBattleText1:
	text_far _PokemonTower6EndBattleText1
	text_end

PokemonTower6AfterBattleText1:
	text_far _PokemonTower6AfterBattleText1
	text_end

PokemonTower6BattleText2:
	text_far _PokemonTower6BattleText2
	text_end

PokemonTower6EndBattleText2:
	text_far _PokemonTower6EndBattleText2
	text_end

PokemonTower6AfterBattleText2:
	text_far _PokemonTower6AfterBattleText2
	text_end

PokemonTower6BattleText3:
	text_far _PokemonTower6BattleText3
	text_end

PokemonTower6EndBattleText3:
	text_far _PokemonTower6EndBattleText3
	text_end

PokemonTower6AfterBattleText3:
	text_far _PokemonTower6AfterBattleText3
	text_end

PokemonTower6Text6:
	text_far _PokemonTower6Text6
	text_end

; new ------------------------------------------------

PokemonTower6TextAgatha:
	text_asm
	ld hl, PokemonTower6AgathaBeforeBattleText
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
	ld a, OPP_AGATHA
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, PokemonTower6AgathaPostBattleText
	ld de, PokemonTower6AgathaPostBattleText
	call SaveEndBattleTextPointers
	jp TextScriptEnd

PokemonTower6AgathaBeforeBattleText:
	text_far _PokemonTower6AgathaBeforeBattleText
	text_end

PokemonTower6AgathaPostBattleText:
	text_far _PokemonTower6AgathaPostBattleText
	text_end
