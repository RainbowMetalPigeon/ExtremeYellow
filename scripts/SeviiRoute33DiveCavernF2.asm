SeviiRoute33DiveCavernF2_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute33DiveCavernF2TrainerHeaders
;	ld de, SeviiRoute33DiveCavernF2_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute33DiveCavernF2_TextPointers:
;	dw SeviiRoute33DiveCavernF2Text1
	text_end

;SeviiRoute33DiveCavernF2_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute33DiveCavernF2TrainerHeaders:
;	def_trainers
;SeviiRoute33DiveCavernF2TrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute33DiveCavernF2BattleText1, SeviiRoute33DiveCavernF2EndBattleText1, SeviiRoute33DiveCavernF2AfterBattleText1
;	db -1 ; end
;
;SeviiRoute33DiveCavernF2Text1:
;	text_asm
;	ld hl, SeviiRoute33DiveCavernF2TrainerHeader1
;	jr SeviiRoute33DiveCavernF2_TalkToTrainer
;
;SeviiRoute33DiveCavernF2_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute33DiveCavernF2BattleText1:
;	text_far _SeviiRoute33DiveCavernF2BattleText1
;	text_end
;
;SeviiRoute33DiveCavernF2EndBattleText1:
;	text_far _SeviiRoute33DiveCavernF2EndBattleText1
;	text_end
;
;SeviiRoute33DiveCavernF2AfterBattleText1:
;	text_far _SeviiRoute33DiveCavernF2AfterBattleText1
;	text_end
