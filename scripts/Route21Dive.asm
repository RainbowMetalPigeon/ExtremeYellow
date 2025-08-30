Route21Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route21DiveTrainerHeaders
	ld de, Route21Dive_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route21Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

Route21Dive_TextPointers:
	text_end

Route21DiveTrainerHeaders:
	def_trainers
	db -1 ; end
