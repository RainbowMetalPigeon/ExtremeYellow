ObsidianWood_Script:
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianWoodTrainerHeaders
	ld de, ObsidianWood_ScriptPointers
	ld a, [wObsidianWoodCurScript]
	call ExecuteCurMapScriptInTable
	ld [wObsidianWoodCurScript], a
	ret

ObsidianWood_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ObsidianWoodOragePostBattleRematch ; new, map-dependent

ObsidianWood_TextPointers:
	dw ObsidianWoodText1
	dw ObsidianWoodText2
	dw ObsidianWoodText3
	dw ObsidianWoodText4
	dw ObsidianWoodTextOrage ; rematch
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw ObsidianWoodTextSignEntrance
	dw ObsidianWoodTextSignSpiral
	dw ObsidianWoodTextSignPlateau
	dw ObsidianWoodTextSignExit
	dw ObsidianWoodTextOragePostBattle ; 13, new, map-dependent

ObsidianWoodTrainerHeaders:
	def_trainers
ObsidianWoodTrainerHeader0:
	trainer EVENT_BEAT_OBSIDIAN_WOOD_TRAINER_0, 3, ObsidianWoodBattleText1, ObsidianWoodEndBattleText1, ObsidianWoodAfterBattleText1
ObsidianWoodTrainerHeader1:
	trainer EVENT_BEAT_OBSIDIAN_WOOD_TRAINER_1, 3, ObsidianWoodBattleText2, ObsidianWoodEndBattleText2, ObsidianWoodAfterBattleText2
ObsidianWoodTrainerHeader2:
	trainer EVENT_BEAT_OBSIDIAN_WOOD_TRAINER_2, 2, ObsidianWoodBattleText3, ObsidianWoodEndBattleText3, ObsidianWoodAfterBattleText3
ObsidianWoodTrainerHeader3:
	trainer EVENT_BEAT_OBSIDIAN_WOOD_TRAINER_3, 2, ObsidianWoodBattleText4, ObsidianWoodEndBattleText4, ObsidianWoodAfterBattleText4
	db -1 ; end

; ====================== texts ======================

; trainers ------------------------------

ObsidianWoodText1:
	text_asm
	ld hl, ObsidianWoodTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWoodBattleText1:
	text_far _ObsidianWoodBattleText1
	text_end

ObsidianWoodEndBattleText1:
	text_far _ObsidianWoodEndBattleText1
	text_end

ObsidianWoodAfterBattleText1:
	text_far _ObsidianWoodAfterBattleText1
	text_end

; ------------------------------

ObsidianWoodText2:
	text_asm
	ld hl, ObsidianWoodTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWoodBattleText2:
	text_far _ObsidianWoodBattleText2
	text_end

ObsidianWoodEndBattleText2:
	text_far _ObsidianWoodEndBattleText2
	text_end

ObsidianWoodAfterBattleText2:
	text_far _ObsidianWoodAfterBattleText2
	text_end

; ------------------------------

ObsidianWoodText3:
	text_asm
	ld hl, ObsidianWoodTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWoodBattleText3:
	text_far _ObsidianWoodBattleText3
	text_end

ObsidianWoodEndBattleText3:
	text_far _ObsidianWoodEndBattleText3
	text_end

ObsidianWoodAfterBattleText3:
	text_far _ObsidianWoodAfterBattleText3
	text_end

; ------------------------------

ObsidianWoodText4:
	text_asm
	ld hl, ObsidianWoodTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ObsidianWoodBattleText4:
	text_far _ObsidianWoodBattleText4
	text_end

ObsidianWoodEndBattleText4:
	text_far _ObsidianWoodEndBattleText4
	text_end

ObsidianWoodAfterBattleText4:
	text_far _ObsidianWoodAfterBattleText4
	text_end

; signs ------------------------------

ObsidianWoodTextSignEntrance:
	text_far _ObsidianWoodTextSignEntrance
	text_end

ObsidianWoodTextSignSpiral:
	text_far _ObsidianWoodTextSignSpiral
	text_end

ObsidianWoodTextSignPlateau:
	text_far _ObsidianWoodTextSignPlateau
	text_end

ObsidianWoodTextSignExit:
	text_far _ObsidianWoodTextSignExit
	text_end

; rematch ------------------------------

ObsidianWoodTextOrage:
	text_asm
	ld hl, ObsidianWoodOrageBeforeBattleText
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
	ld a, OPP_ORAGE
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, ObsidianWoodOragePostBattleText
	ld de, ObsidianWoodOragePostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $3 ; new script, map-dependent
	ld [wObsidianWoodCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

ObsidianWoodOrageBeforeBattleText:
	text_far _ObsidianWoodOrageBeforeBattleText
	text_end

ObsidianWoodOragePostBattleText:
	text_far _ObsidianWoodOragePostBattleText
	text_end

ObsidianWoodOragePostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, ObsidianWoodResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 13 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ORAGE_REMATCH_INVERSE ; map-dependent
	jp ObsidianWoodResetScripts

ObsidianWoodResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wObsidianWoodCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

ObsidianWoodTextOragePostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
