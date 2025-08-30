SeviiRoute32DiveCavern1F1_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute32DiveCavern1F1TrainerHeaders
;	ld de, SeviiRoute32DiveCavern1F1_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute32DiveCavern1F1_TextPointers:
;	dw SeviiRoute32DiveCavern1F1Text1
	text_end

;SeviiRoute32DiveCavern1F1_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute32DiveCavern1F1TrainerHeaders:
;	def_trainers
;SeviiRoute32DiveCavern1F1TrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute32DiveCavern1F1BattleText1, SeviiRoute32DiveCavern1F1EndBattleText1, SeviiRoute32DiveCavern1F1AfterBattleText1
;	db -1 ; end
;
;SeviiRoute32DiveCavern1F1Text1:
;	text_asm
;	ld hl, SeviiRoute32DiveCavern1F1TrainerHeader1
;	jr SeviiRoute32DiveCavern1F1_TalkToTrainer
;
;SeviiRoute32DiveCavern1F1_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute32DiveCavern1F1BattleText1:
;	text_far _SeviiRoute32DiveCavern1F1BattleText1
;	text_end
;
;SeviiRoute32DiveCavern1F1EndBattleText1:
;	text_far _SeviiRoute32DiveCavern1F1EndBattleText1
;	text_end
;
;SeviiRoute32DiveCavern1F1AfterBattleText1:
;	text_far _SeviiRoute32DiveCavern1F1AfterBattleText1
;	text_end
