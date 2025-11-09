SeviiFiveIslandCityDive_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiFiveIslandCityDiveTrainerHeaders
;	ld de, SeviiFiveIslandCityDive_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiFiveIslandCityDive_TextPointers:
;	dw SeviiFiveIslandCityDiveText1
	text_end

;SeviiFiveIslandCityDive_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiFiveIslandCityDiveTrainerHeaders:
;	def_trainers
;SeviiFiveIslandCityDiveTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiFiveIslandCityDiveBattleText1, SeviiFiveIslandCityDiveEndBattleText1, SeviiFiveIslandCityDiveAfterBattleText1
;	db -1 ; end
;
;SeviiFiveIslandCityDiveText1:
;	text_asm
;	ld hl, SeviiFiveIslandCityDiveTrainerHeader1
;	jr SeviiFiveIslandCityDive_TalkToTrainer
;
;SeviiFiveIslandCityDive_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiFiveIslandCityDiveBattleText1:
;	text_far _SeviiFiveIslandCityDiveBattleText1
;	text_end
;
;SeviiFiveIslandCityDiveEndBattleText1:
;	text_far _SeviiFiveIslandCityDiveEndBattleText1
;	text_end
;
;SeviiFiveIslandCityDiveAfterBattleText1:
;	text_far _SeviiFiveIslandCityDiveAfterBattleText1
;	text_end
