SeviiFiveIslandCityDiveCavern_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiFiveIslandCityDiveCavernTrainerHeaders
;	ld de, SeviiFiveIslandCityDiveCavern_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiFiveIslandCityDiveCavern_TextPointers:
	dw PickUpItemText
	dw PickUpItemText

;SeviiFiveIslandCityDiveCavern_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiFiveIslandCityDiveCavernTrainerHeaders:
;	def_trainers
;SeviiFiveIslandCityDiveCavernTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiFiveIslandCityDiveCavernBattleText1, SeviiFiveIslandCityDiveCavernEndBattleText1, SeviiFiveIslandCityDiveCavernAfterBattleText1
;	db -1 ; end
;
;SeviiFiveIslandCityDiveCavernText1:
;	text_asm
;	ld hl, SeviiFiveIslandCityDiveCavernTrainerHeader1
;	jr SeviiFiveIslandCityDiveCavern_TalkToTrainer
;
;SeviiFiveIslandCityDiveCavern_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiFiveIslandCityDiveCavernBattleText1:
;	text_far _SeviiFiveIslandCityDiveCavernBattleText1
;	text_end
;
;SeviiFiveIslandCityDiveCavernEndBattleText1:
;	text_far _SeviiFiveIslandCityDiveCavernEndBattleText1
;	text_end
;
;SeviiFiveIslandCityDiveCavernAfterBattleText1:
;	text_far _SeviiFiveIslandCityDiveCavernAfterBattleText1
;	text_end
