SeviiFourIslandCityDiveCavern_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiFourIslandCityDiveCavernTrainerHeaders
;	ld de, SeviiFourIslandCityDiveCavern_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiFourIslandCityDiveCavern_TextPointers:
	dw PickUpItemText

;SeviiFourIslandCityDiveCavern_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiFourIslandCityDiveCavernTrainerHeaders:
;	def_trainers
;SeviiFourIslandCityDiveCavernTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiFourIslandCityDiveCavernBattleText1, SeviiFourIslandCityDiveCavernEndBattleText1, SeviiFourIslandCityDiveCavernAfterBattleText1
;	db -1 ; end
;
;SeviiFourIslandCityDiveCavernText1:
;	text_asm
;	ld hl, SeviiFourIslandCityDiveCavernTrainerHeader1
;	jr SeviiFourIslandCityDiveCavern_TalkToTrainer
;
;SeviiFourIslandCityDiveCavern_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiFourIslandCityDiveCavernBattleText1:
;	text_far _SeviiFourIslandCityDiveCavernBattleText1
;	text_end
;
;SeviiFourIslandCityDiveCavernEndBattleText1:
;	text_far _SeviiFourIslandCityDiveCavernEndBattleText1
;	text_end
;
;SeviiFourIslandCityDiveCavernAfterBattleText1:
;	text_far _SeviiFourIslandCityDiveCavernAfterBattleText1
;	text_end
