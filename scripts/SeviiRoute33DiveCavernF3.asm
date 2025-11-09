SeviiRoute33DiveCavernF3_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute33DiveCavernF3TrainerHeaders
;	ld de, SeviiRoute33DiveCavernF3_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute33DiveCavernF3_TextPointers:
;	dw SeviiRoute33DiveCavernF3Text1
	text_end

;SeviiRoute33DiveCavernF3_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute33DiveCavernF3TrainerHeaders:
;	def_trainers
;SeviiRoute33DiveCavernF3TrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute33DiveCavernF3BattleText1, SeviiRoute33DiveCavernF3EndBattleText1, SeviiRoute33DiveCavernF3AfterBattleText1
;	db -1 ; end
;
;SeviiRoute33DiveCavernF3Text1:
;	text_asm
;	ld hl, SeviiRoute33DiveCavernF3TrainerHeader1
;	jr SeviiRoute33DiveCavernF3_TalkToTrainer
;
;SeviiRoute33DiveCavernF3_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute33DiveCavernF3BattleText1:
;	text_far _SeviiRoute33DiveCavernF3BattleText1
;	text_end
;
;SeviiRoute33DiveCavernF3EndBattleText1:
;	text_far _SeviiRoute33DiveCavernF3EndBattleText1
;	text_end
;
;SeviiRoute33DiveCavernF3AfterBattleText1:
;	text_far _SeviiRoute33DiveCavernF3AfterBattleText1
;	text_end
