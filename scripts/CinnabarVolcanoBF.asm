CinnabarVolcanoBF_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CinnabarVolcanoBFTrainerHeaders
	ld de, CinnabarVolcanoBF_ScriptPointers
	ld a, [wCinnabarVolcanoBFCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCinnabarVolcanoBFCurScript], a
	ret

CinnabarVolcanoBF_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

CinnabarVolcanoBF_TextPointers:
	dw MoltresText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText

CinnabarVolcanoBFTrainerHeaders:
	def_trainers
MoltresTrainerHeader:
	trainer EVENT_BEAT_MOLTRES, 0, MoltresBattleText, MoltresBattleText, MoltresBattleText
	db -1 ; end

MoltresText:
	text_asm
	ld hl, MoltresTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MoltresBattleText:
	text_far _MoltresBattleText
	text_asm
	ld a, MOLTRES
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
