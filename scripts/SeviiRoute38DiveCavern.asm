SeviiRoute38DiveCavern_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiRoute38DiveCavernTrainerHeaders
;	ld de, SeviiRoute38DiveCavern_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiRoute38DiveCavern_TextPointers:
	dw PickUpItemText

;SeviiRoute38DiveCavern_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiRoute38DiveCavernTrainerHeaders:
;	def_trainers
;SeviiRoute38DiveCavernTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiRoute38DiveCavernBattleText1, SeviiRoute38DiveCavernEndBattleText1, SeviiRoute38DiveCavernAfterBattleText1
;	db -1 ; end
;
;SeviiRoute38DiveCavernText1:
;	text_asm
;	ld hl, SeviiRoute38DiveCavernTrainerHeader1
;	jr SeviiRoute38DiveCavern_TalkToTrainer
;
;SeviiRoute38DiveCavern_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiRoute38DiveCavernBattleText1:
;	text_far _SeviiRoute38DiveCavernBattleText1
;	text_end
;
;SeviiRoute38DiveCavernEndBattleText1:
;	text_far _SeviiRoute38DiveCavernEndBattleText1
;	text_end
;
;SeviiRoute38DiveCavernAfterBattleText1:
;	text_far _SeviiRoute38DiveCavernAfterBattleText1
;	text_end
