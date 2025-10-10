SeviiPatternBush_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiPatternBushTrainerHeaders
	ld de, SeviiPatternBush_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiPatternBush_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiPatternBush_TextPointers:
	dw SeviiPatternBushText1  ;  1 person
	dw SeviiPatternBushText2  ;  2 person
	dw SeviiPatternBushText3  ;  3 person
	dw SeviiPatternBushText4  ;  4 person
	dw SeviiPatternBushText5  ;  5 trainer
	dw SeviiPatternBushText6  ;  6 trainer
	dw SeviiPatternBushText7  ;  7 trainer
	dw SeviiPatternBushText8  ;  8 trainer

; ---------------------------------------

SeviiPatternBushText1:
	text_far _SeviiPatternBushText1
	text_end

SeviiPatternBushText2:
	text_far _SeviiPatternBushText2
	text_end

SeviiPatternBushText3:
	text_far _SeviiPatternBushText3
	text_end

SeviiPatternBushText4:
	text_far _SeviiPatternBushText4
	text_end

; ---------------------------------------

SeviiPatternBushTrainerHeaders:
	def_trainers 5
SeviiPatternBushTrainerHeader1:
	trainer EVENT_BEAT_SEVII_PATTERN_BUSH_TRAINER_1, 2, SeviiPatternBushBattleText1, SeviiPatternBushEndBattleText1, SeviiPatternBushAfterBattleText1
SeviiPatternBushTrainerHeader2:
	trainer EVENT_BEAT_SEVII_PATTERN_BUSH_TRAINER_2, 2, SeviiPatternBushBattleText2, SeviiPatternBushEndBattleText2, SeviiPatternBushAfterBattleText2
SeviiPatternBushTrainerHeader3:
	trainer EVENT_BEAT_SEVII_PATTERN_BUSH_TRAINER_3, 2, SeviiPatternBushBattleText3, SeviiPatternBushEndBattleText3, SeviiPatternBushAfterBattleText3
SeviiPatternBushTrainerHeader4:
	trainer EVENT_BEAT_SEVII_PATTERN_BUSH_TRAINER_4, 2, SeviiPatternBushBattleText4, SeviiPatternBushEndBattleText4, SeviiPatternBushAfterBattleText4
	db -1 ; end

SeviiPatternBush_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiPatternBushText5:
	text_asm
	ld hl, SeviiPatternBushTrainerHeader1
	jr SeviiPatternBush_TalkToTrainer

SeviiPatternBushBattleText1:
	text_far _SeviiPatternBushBattleText1
	text_end

SeviiPatternBushEndBattleText1:
	text_far _SeviiPatternBushEndBattleText1
	text_end

SeviiPatternBushAfterBattleText1:
	text_far _SeviiPatternBushAfterBattleText1
	text_end

; ---------------------------------------

SeviiPatternBushText6:
	text_asm
	ld hl, SeviiPatternBushTrainerHeader2
	jr SeviiPatternBush_TalkToTrainer

SeviiPatternBushBattleText2:
	text_far _SeviiPatternBushBattleText2
	text_end

SeviiPatternBushEndBattleText2:
	text_far _SeviiPatternBushEndBattleText2
	text_end

SeviiPatternBushAfterBattleText2:
	text_far _SeviiPatternBushAfterBattleText2
	text_end

; ---------------------------------------

SeviiPatternBushText7:
	text_asm
	ld hl, SeviiPatternBushTrainerHeader3
	jr SeviiPatternBush_TalkToTrainer

SeviiPatternBushBattleText3:
	text_far _SeviiPatternBushBattleText3
	text_end

SeviiPatternBushEndBattleText3:
	text_far _SeviiPatternBushEndBattleText3
	text_end

SeviiPatternBushAfterBattleText3:
	text_far _SeviiPatternBushAfterBattleText3
	text_end

; ---------------------------------------

SeviiPatternBushText8:
	text_asm
	ld hl, SeviiPatternBushTrainerHeader4
	jr SeviiPatternBush_TalkToTrainer

SeviiPatternBushBattleText4:
	text_far _SeviiPatternBushBattleText4
	text_end

SeviiPatternBushEndBattleText4:
	text_far _SeviiPatternBushEndBattleText4
	text_end

SeviiPatternBushAfterBattleText4:
	text_far _SeviiPatternBushAfterBattleText4
	text_end
