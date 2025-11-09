SeviiRoute38Dive_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute38DiveTrainerHeaders
;	ld de, SeviiRoute38Dive_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute38Dive_TextPointers:
;	dw SeviiRoute38DiveText1
	text_end

;SeviiRoute38Dive_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute38DiveTrainerHeaders:
;	def_trainers
;SeviiRoute38DiveTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute38DiveBattleText1, SeviiRoute38DiveEndBattleText1, SeviiRoute38DiveAfterBattleText1
;	db -1 ; end
;
;SeviiRoute38DiveText1:
;	text_asm
;	ld hl, SeviiRoute38DiveTrainerHeader1
;	jr SeviiRoute38Dive_TalkToTrainer
;
;SeviiRoute38Dive_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute38DiveBattleText1:
;	text_far _SeviiRoute38DiveBattleText1
;	text_end
;
;SeviiRoute38DiveEndBattleText1:
;	text_far _SeviiRoute38DiveEndBattleText1
;	text_end
;
;SeviiRoute38DiveAfterBattleText1:
;	text_far _SeviiRoute38DiveAfterBattleText1
;	text_end
