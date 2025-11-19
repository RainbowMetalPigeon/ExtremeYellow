SeviiRoute39Dive_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute39DiveTrainerHeaders
;	ld de, SeviiRoute39Dive_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute39Dive_TextPointers:
;	dw SeviiRoute39DiveText1
;	dw PickUpItemText
	text_end

;SeviiRoute39Dive_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute39DiveTrainerHeaders:
;	def_trainers
;SeviiRoute39DiveTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute39DiveBattleText1, SeviiRoute39DiveEndBattleText1, SeviiRoute39DiveAfterBattleText1
;	db -1 ; end
;
;SeviiRoute39DiveText1:
;	text_asm
;	ld hl, SeviiRoute39DiveTrainerHeader1
;	jr SeviiRoute39Dive_TalkToTrainer
;
;SeviiRoute39Dive_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute39DiveBattleText1:
;	text_far _SeviiRoute39DiveBattleText1
;	text_end
;
;SeviiRoute39DiveEndBattleText1:
;	text_far _SeviiRoute39DiveEndBattleText1
;	text_end
;
;SeviiRoute39DiveAfterBattleText1:
;	text_far _SeviiRoute39DiveAfterBattleText1
;	text_end
