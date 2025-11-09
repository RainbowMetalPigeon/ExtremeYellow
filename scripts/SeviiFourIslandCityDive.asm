SeviiFourIslandCityDive_Script:
	jp EnableAutoTextBoxDrawing
;	call EnableAutoTextBoxDrawing
;	ld hl, SeviiFourIslandCityDiveTrainerHeaders
;	ld de, SeviiFourIslandCityDive_ScriptPointers
;	ld a, [wCurMapScript]
;	call ExecuteCurMapScriptInTable
;	ld [wCurMapScript], a
;	ret

SeviiFourIslandCityDive_TextPointers:
;	dw SeviiFourIslandCityDiveText1
	text_end

;SeviiFourIslandCityDive_ScriptPointers:
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle
;
;SeviiFourIslandCityDiveTrainerHeaders:
;	def_trainers
;SeviiFourIslandCityDiveTrainerHeader1:
;	trainer EVENT_BEAT_SEVII_ROUTE_32_DIVE_TRAINER_1, 4, SeviiFourIslandCityDiveBattleText1, SeviiFourIslandCityDiveEndBattleText1, SeviiFourIslandCityDiveAfterBattleText1
;	db -1 ; end
;
;SeviiFourIslandCityDiveText1:
;	text_asm
;	ld hl, SeviiFourIslandCityDiveTrainerHeader1
;	jr SeviiFourIslandCityDive_TalkToTrainer
;
;SeviiFourIslandCityDive_TalkToTrainer:
;	call TalkToTrainer
;	jp TextScriptEnd
;
;SeviiFourIslandCityDiveBattleText1:
;	text_far _SeviiFourIslandCityDiveBattleText1
;	text_end
;
;SeviiFourIslandCityDiveEndBattleText1:
;	text_far _SeviiFourIslandCityDiveEndBattleText1
;	text_end
;
;SeviiFourIslandCityDiveAfterBattleText1:
;	text_far _SeviiFourIslandCityDiveAfterBattleText1
;	text_end
