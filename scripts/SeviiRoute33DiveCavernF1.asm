SeviiRoute33DiveCavernF1_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute33DiveCavernF1TrainerHeaders
;	ld de, SeviiRoute33DiveCavernF1_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute33DiveCavernF1_TextPointers:
;	dw SeviiRoute33DiveCavernF1Text1
	text_end

;SeviiRoute33DiveCavernF1_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute33DiveCavernF1TrainerHeaders:
;	def_trainers
;SeviiRoute33DiveCavernF1TrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute33DiveCavernF1BattleText1, SeviiRoute33DiveCavernF1EndBattleText1, SeviiRoute33DiveCavernF1AfterBattleText1
;	db -1 ; end
;
;SeviiRoute33DiveCavernF1Text1:
;	text_asm
;	ld hl, SeviiRoute33DiveCavernF1TrainerHeader1
;	jr SeviiRoute33DiveCavernF1_TalkToTrainer
;
;SeviiRoute33DiveCavernF1_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute33DiveCavernF1BattleText1:
;	text_far _SeviiRoute33DiveCavernF1BattleText1
;	text_end
;
;SeviiRoute33DiveCavernF1EndBattleText1:
;	text_far _SeviiRoute33DiveCavernF1EndBattleText1
;	text_end
;
;SeviiRoute33DiveCavernF1AfterBattleText1:
;	text_far _SeviiRoute33DiveCavernF1AfterBattleText1
;	text_end
