SeviiFiveIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandCityTrainerHeaders
	ld de, SeviiFiveIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiFiveIslandCity_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiFiveIslandCity_TextPointers:
	dw SeviiFiveIslandCityText1  ;  1 person
	dw SeviiFiveIslandCityText2  ;  2 person
	dw SeviiFiveIslandCityText3  ;  3 Monster Rocket
	dw SeviiFiveIslandCityText4  ;  4 Monster Pink
	dw SeviiFiveIslandCityText5  ;  5 Rocket
	dw SeviiFiveIslandCityText6  ;  6 Pink
	dw SeviiFiveIslandCityText7  ;  7 trainer
	dw SeviiFiveIslandCityText8  ;  8 trainer
	dw SeviiFiveIslandCityText9  ;  9 trainer
	dw SeviiFiveIslandCityText10 ; 10 trainer
	dw RockSmashText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14
	; signs
	dw SeviiFiveIslandCitySignText1 ; 15
	dw SeviiFiveIslandCitySignText2 ; 16
	dw SeviiFiveIslandCitySignText3 ; 17
	dw SeviiFiveIslandCitySignText4 ; 18
	dw SeviiFiveIslandCitySignText5 ; 19
	dw PokeCenterSignText ; 20
	dw MartSignText ; 21
	; scripts

SeviiFiveIslandCityTrainerHeaders:
	def_trainers 7
SeviiFiveIslandCityTrainerHeader1:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_1, 1, SeviiFiveIslandCityBattleText1, SeviiFiveIslandCityEndBattleText1, SeviiFiveIslandCityAfterBattleText1
SeviiFiveIslandCityTrainerHeader2:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_2, 1, SeviiFiveIslandCityBattleText2, SeviiFiveIslandCityEndBattleText2, SeviiFiveIslandCityAfterBattleText2
SeviiFiveIslandCityTrainerHeader3:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_3, 1, SeviiFiveIslandCityBattleText3, SeviiFiveIslandCityEndBattleText3, SeviiFiveIslandCityAfterBattleText3
SeviiFiveIslandCityTrainerHeader4:
	trainer EVENT_BEAT_SEVII_FIVE_ISLAND_CITY_TRAINER_4, 3, SeviiFiveIslandCityBattleText4, SeviiFiveIslandCityEndBattleText4, SeviiFiveIslandCityAfterBattleText4
	db -1 ; end

SeviiFiveIslandCity_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiFiveIslandCityText7:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader1
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText1:
	text_far _SeviiFiveIslandCityBattleText1
	text_end

SeviiFiveIslandCityEndBattleText1:
	text_far _SeviiFiveIslandCityEndBattleText1
	text_end

SeviiFiveIslandCityAfterBattleText1:
	text_far _SeviiFiveIslandCityAfterBattleText1
	text_end

; ---------------------------------------

SeviiFiveIslandCityText8:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader2
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText2:
	text_far _SeviiFiveIslandCityBattleText2
	text_end

SeviiFiveIslandCityEndBattleText2:
	text_far _SeviiFiveIslandCityEndBattleText2
	text_end

SeviiFiveIslandCityAfterBattleText2:
	text_far _SeviiFiveIslandCityAfterBattleText2
	text_end

; ---------------------------------------

SeviiFiveIslandCityText9:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader3
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText3:
	text_far _SeviiFiveIslandCityBattleText3
	text_end

SeviiFiveIslandCityEndBattleText3:
	text_far _SeviiFiveIslandCityEndBattleText3
	text_end

SeviiFiveIslandCityAfterBattleText3:
	text_far _SeviiFiveIslandCityAfterBattleText3
	text_end

; ---------------------------------------

SeviiFiveIslandCityText10:
	text_asm
	ld hl, SeviiFiveIslandCityTrainerHeader4
	jr SeviiFiveIslandCity_TalkToTrainer

SeviiFiveIslandCityBattleText4:
	text_far _SeviiFiveIslandCityBattleText4
	text_end

SeviiFiveIslandCityEndBattleText4:
	text_far _SeviiFiveIslandCityEndBattleText4
	text_end

SeviiFiveIslandCityAfterBattleText4:
	text_far _SeviiFiveIslandCityAfterBattleText4
	text_end

; ---------------------------------------

SeviiFiveIslandCityText1:
	text_far _SeviiFiveIslandCityText1
	text_end
	
SeviiFiveIslandCityText2:
	text_far _SeviiFiveIslandCityText2
	text_end

SeviiFiveIslandCityText3:
	text_far _SeviiFiveIslandCityText3
	text_end
	
SeviiFiveIslandCityText4:
	text_far _SeviiFiveIslandCityText4
	text_end

SeviiFiveIslandCityText5:
	text_far _SeviiFiveIslandCityText5
	text_end

SeviiFiveIslandCityText6:
	text_far _SeviiFiveIslandCityText6
	text_end

; ---------------------------------------

SeviiFiveIslandCitySignText1:
	text_far _SeviiFiveIslandCitySignText1
	text_end
	
SeviiFiveIslandCitySignText2:
	text_far _SeviiFiveIslandCitySignText2
	text_end
	
SeviiFiveIslandCitySignText3:
	text_far _SeviiFiveIslandCitySignText3
	text_end
	
SeviiFiveIslandCitySignText4:
	text_far _SeviiFiveIslandCitySignText4
	text_end
	
SeviiFiveIslandCitySignText5:
	text_far _SeviiFiveIslandCitySignText5
	text_end
	