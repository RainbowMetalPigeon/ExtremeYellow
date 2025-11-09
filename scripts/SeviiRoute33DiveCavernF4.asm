SeviiRoute33DiveCavernF4_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute33DiveCavernF4TrainerHeaders
;	ld de, SeviiRoute33DiveCavernF4_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute33DiveCavernF4_TextPointers:
	dw PickUpItemText

;SeviiRoute33DiveCavernF4_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute33DiveCavernF4TrainerHeaders:
;	def_trainers
;SeviiRoute33DiveCavernF4TrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute33DiveCavernF4BattleText1, SeviiRoute33DiveCavernF4EndBattleText1, SeviiRoute33DiveCavernF4AfterBattleText1
;	db -1 ; end
;
;SeviiRoute33DiveCavernF4Text1:
;	text_asm
;	ld hl, SeviiRoute33DiveCavernF4TrainerHeader1
;	jr SeviiRoute33DiveCavernF4_TalkToTrainer
;
;SeviiRoute33DiveCavernF4_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute33DiveCavernF4BattleText1:
;	text_far _SeviiRoute33DiveCavernF4BattleText1
;	text_end
;
;SeviiRoute33DiveCavernF4EndBattleText1:
;	text_far _SeviiRoute33DiveCavernF4EndBattleText1
;	text_end
;
;SeviiRoute33DiveCavernF4AfterBattleText1:
;	text_far _SeviiRoute33DiveCavernF4AfterBattleText1
;	text_end
