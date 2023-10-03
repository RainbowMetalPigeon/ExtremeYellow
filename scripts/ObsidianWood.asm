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

ObsidianWood_TextPointers:
	dw ObsidianWoodText1
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw ObsidianWoodTextSignEntrance
	dw ObsidianWoodTextSignSpiral
	dw ObsidianWoodTextSignPlateau
	dw ObsidianWoodTextSignExit

ObsidianWoodTrainerHeaders:
	def_trainers
ObsidianWoodTrainerHeader0:
	trainer EVENT_BEAT_OBSIDIAN_WOOD_TRAINER_0, 3, ObsidianWoodBattleText1, ObsidianWoodEndBattleText1, ObsidianWoodAfterBattleText1
	db -1 ; end

; ====================== texts ======================

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
