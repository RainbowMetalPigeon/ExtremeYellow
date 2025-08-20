SeviiRoute32Dive_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute32DiveTrainerHeaders
	ld de, SeviiRoute32Dive_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SeviiRoute32Dive_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute32Dive_TextPointers:
	dw SeviiRoute32DiveText1
;	dw RockSmashText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw SeviiRoute32DiveText1
	text_end

SeviiRoute32DiveTrainerHeaders:
	def_trainers
SeviiRoute32DiveTrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute32DiveBattleText1, SeviiRoute32DiveEndBattleText1, SeviiRoute32DiveAfterBattleText1
	db -1 ; end

SeviiRoute32DiveText1:
	text_asm
	ld hl, SeviiRoute32DiveTrainerHeader1
	jr SeviiRoute32Dive_TalkToTrainer

SeviiRoute32Dive_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

SeviiRoute32DiveBattleText1:
	text_far _SeviiRoute32DiveBattleText1
	text_end

SeviiRoute32DiveEndBattleText1:
	text_far _SeviiRoute32DiveEndBattleText1
	text_end

SeviiRoute32DiveAfterBattleText1:
	text_far _SeviiRoute32DiveAfterBattleText1
	text_end
