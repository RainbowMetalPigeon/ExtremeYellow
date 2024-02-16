Route29_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route29TrainerHeaders
	ld de, Route29_ScriptPointers
	ld a, [wRoute29CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute29CurScript], a
	ret

Route29_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route29_TextPointers:
	; trainers
	dw Route29Text1
	; non-trainers
	dw Route29TextSlowking
	; signs

Route29TrainerHeaders:
	def_trainers
Route29TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_0, 0, Route29BattleText1, Route29EndBattleText1, Route29AfterBattleText1
	db -1 ; end

; signs

Route29Text1:
	text_asm
	ld hl, Route29TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText1:
	text_far _Route29BattleText1
	text_end

Route29EndBattleText1:
	text_far _Route29EndBattleText1
	text_end

Route29AfterBattleText1:
	text_far _Route29AfterBattleText1
	text_end

; non-trainers

Route29TextSlowking:
	text_far _Route29TextSlowking
	text_end

; signs
