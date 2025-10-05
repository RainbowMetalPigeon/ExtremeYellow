SeviiRoute37_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute37TrainerHeaders
	ld de, SeviiRoute37_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute37_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute37_TextPointers:
	dw SeviiRoute37Text1
	dw SeviiRoute37Text2
	dw SeviiRoute37Text3
	dw SeviiRoute37Text4
	dw SeviiRoute37Text5
	dw SeviiRoute37Text6
	dw SeviiRoute37Text7
	dw SeviiRoute37Text8
	dw SeviiRoute37Text9
	dw SeviiRoute37Text10
	dw SeviiRoute37Text11
	dw SeviiRoute37Text12
	dw RockSmashText

SeviiRoute37TrainerHeaders:
	def_trainers 1
SeviiRoute37TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_1, 4, SeviiRoute37BattleText1, SeviiRoute37EndBattleText1, SeviiRoute37AfterBattleText1
SeviiRoute37TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_2, 4, SeviiRoute37BattleText2, SeviiRoute37EndBattleText2, SeviiRoute37AfterBattleText2
SeviiRoute37TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_3, 4, SeviiRoute37BattleText3, SeviiRoute37EndBattleText3, SeviiRoute37AfterBattleText3
SeviiRoute37TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_4, 4, SeviiRoute37BattleText4, SeviiRoute37EndBattleText4, SeviiRoute37AfterBattleText4
SeviiRoute37TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_5, 4, SeviiRoute37BattleText5, SeviiRoute37EndBattleText5, SeviiRoute37AfterBattleText5
SeviiRoute37TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_6, 4, SeviiRoute37BattleText6, SeviiRoute37EndBattleText6, SeviiRoute37AfterBattleText6
SeviiRoute37TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_7, 4, SeviiRoute37BattleText7, SeviiRoute37EndBattleText7, SeviiRoute37AfterBattleText7
SeviiRoute37TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_8, 4, SeviiRoute37BattleText8, SeviiRoute37EndBattleText8, SeviiRoute37AfterBattleText8
SeviiRoute37TrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_9, 4, SeviiRoute37BattleText9, SeviiRoute37EndBattleText9, SeviiRoute37AfterBattleText9
SeviiRoute37TrainerHeader10:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_10, 4, SeviiRoute37BattleText10, SeviiRoute37EndBattleText10, SeviiRoute37AfterBattleText10
SeviiRoute37TrainerHeader11:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_11, 4, SeviiRoute37BattleText11, SeviiRoute37EndBattleText11, SeviiRoute37AfterBattleText11
SeviiRoute37TrainerHeader12:
	trainer EVENT_BEAT_SEVII_ROUTE_37_TRAINER_12, 4, SeviiRoute37BattleText12, SeviiRoute37EndBattleText12, SeviiRoute37AfterBattleText12
	db -1 ; end

SeviiRoute37_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute37Text1:
	text_asm
	ld hl, SeviiRoute37TrainerHeader1
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText1:
	text_far _SeviiRoute37BattleText1
	text_end

SeviiRoute37EndBattleText1:
	text_far _SeviiRoute37EndBattleText1
	text_end

SeviiRoute37AfterBattleText1:
	text_far _SeviiRoute37AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute37Text2:
	text_asm
	ld hl, SeviiRoute37TrainerHeader2
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText2:
	text_far _SeviiRoute37BattleText2
	text_end

SeviiRoute37EndBattleText2:
	text_far _SeviiRoute37EndBattleText2
	text_end

SeviiRoute37AfterBattleText2:
	text_far _SeviiRoute37AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute37Text3:
	text_asm
	ld hl, SeviiRoute37TrainerHeader3
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText3:
	text_far _SeviiRoute37BattleText3
	text_end

SeviiRoute37EndBattleText3:
	text_far _SeviiRoute37EndBattleText3
	text_end

SeviiRoute37AfterBattleText3:
	text_far _SeviiRoute37AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute37Text4:
	text_asm
	ld hl, SeviiRoute37TrainerHeader4
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText4:
	text_far _SeviiRoute37BattleText4
	text_end

SeviiRoute37EndBattleText4:
	text_far _SeviiRoute37EndBattleText4
	text_end

SeviiRoute37AfterBattleText4:
	text_far _SeviiRoute37AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute37Text5:
	text_asm
	ld hl, SeviiRoute37TrainerHeader5
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText5:
	text_far _SeviiRoute37BattleText5
	text_end

SeviiRoute37EndBattleText5:
	text_far _SeviiRoute37EndBattleText5
	text_end

SeviiRoute37AfterBattleText5:
	text_far _SeviiRoute37AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute37Text6:
	text_asm
	ld hl, SeviiRoute37TrainerHeader6
	jr SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText6:
	text_far _SeviiRoute37BattleText6
	text_end

SeviiRoute37EndBattleText6:
	text_far _SeviiRoute37EndBattleText6
	text_end

SeviiRoute37AfterBattleText6:
	text_far _SeviiRoute37AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute37Text7:
	text_asm
	ld hl, SeviiRoute37TrainerHeader7
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText7:
	text_far _SeviiRoute37BattleText7
	text_end

SeviiRoute37EndBattleText7:
	text_far _SeviiRoute37EndBattleText7
	text_end

SeviiRoute37AfterBattleText7:
	text_far _SeviiRoute37AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute37Text8:
	text_asm
	ld hl, SeviiRoute37TrainerHeader8
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText8:
	text_far _SeviiRoute37BattleText8
	text_end

SeviiRoute37EndBattleText8:
	text_far _SeviiRoute37EndBattleText8
	text_end

SeviiRoute37AfterBattleText8:
	text_far _SeviiRoute37AfterBattleText8
	text_end

; ---------------------------------------

SeviiRoute37Text9:
	text_asm
	ld hl, SeviiRoute37TrainerHeader9
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText9:
	text_far _SeviiRoute37BattleText9
	text_end

SeviiRoute37EndBattleText9:
	text_far _SeviiRoute37EndBattleText9
	text_end

SeviiRoute37AfterBattleText9:
	text_far _SeviiRoute37AfterBattleText9
	text_end

; ---------------------------------------

SeviiRoute37Text10:
	text_asm
	ld hl, SeviiRoute37TrainerHeader10
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText10:
	text_far _SeviiRoute37BattleText10
	text_end

SeviiRoute37EndBattleText10:
	text_far _SeviiRoute37EndBattleText10
	text_end

SeviiRoute37AfterBattleText10:
	text_far _SeviiRoute37AfterBattleText10
	text_end

; ---------------------------------------

SeviiRoute37Text11:
	text_asm
	ld hl, SeviiRoute37TrainerHeader11
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText11:
	text_far _SeviiRoute37BattleText11
	text_end

SeviiRoute37EndBattleText11:
	text_far _SeviiRoute37EndBattleText11
	text_end

SeviiRoute37AfterBattleText11:
	text_far _SeviiRoute37AfterBattleText11
	text_end

; ---------------------------------------

SeviiRoute37Text12:
	text_asm
	ld hl, SeviiRoute37TrainerHeader12
	jp SeviiRoute37_TalkToTrainer

SeviiRoute37BattleText12:
	text_far _SeviiRoute37BattleText12
	text_end

SeviiRoute37EndBattleText12:
	text_far _SeviiRoute37EndBattleText12
	text_end

SeviiRoute37AfterBattleText12:
	text_far _SeviiRoute37AfterBattleText12
	text_end
