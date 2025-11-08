SeviiRoute32_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute32TrainerHeaders
	ld de, SeviiRoute32_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute32_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute32_TextPointers:
	dw SeviiRoute32Text0
	dw SeviiRoute32Text1
	dw SeviiRoute32Text2
	dw SeviiRoute32Text3
	dw PickUpItemText
	dw PickUpItemText
	; signs
	dw SeviiRoute32SignText1

SeviiRoute32TrainerHeaders:
	def_trainers 2
SeviiRoute32TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_32_TRAINER_1, 4, SeviiRoute32BattleText1, SeviiRoute32EndBattleText1, SeviiRoute32AfterBattleText1
SeviiRoute32TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_32_TRAINER_2, 4, SeviiRoute32BattleText2, SeviiRoute32EndBattleText2, SeviiRoute32AfterBattleText2
SeviiRoute32TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_32_TRAINER_3, 4, SeviiRoute32BattleText3, SeviiRoute32EndBattleText3, SeviiRoute32AfterBattleText3
	db -1 ; end

SeviiRoute32Text0:
	text_far _SeviiRoute32Text0
	text_end

SeviiRoute32Text1:
	text_asm
	ld hl, SeviiRoute32TrainerHeader1
	jr SeviiRoute32_TalkToTrainer
	
SeviiRoute32BattleText1:
	text_far _SeviiRoute32BattleText1
	text_end

SeviiRoute32EndBattleText1:
	text_far _SeviiRoute32EndBattleText1
	text_end

SeviiRoute32AfterBattleText1:
	text_far _SeviiRoute32AfterBattleText1
	text_end

SeviiRoute32Text2:
	text_asm
	ld hl, SeviiRoute32TrainerHeader2
	jr SeviiRoute32_TalkToTrainer
	
SeviiRoute32BattleText2:
	text_far _SeviiRoute32BattleText2
	text_end

SeviiRoute32EndBattleText2:
	text_far _SeviiRoute32EndBattleText2
	text_end

SeviiRoute32AfterBattleText2:
	text_far _SeviiRoute32AfterBattleText2
	text_end

SeviiRoute32Text3:
	text_asm
	ld hl, SeviiRoute32TrainerHeader3
	jr SeviiRoute32_TalkToTrainer

SeviiRoute32BattleText3:
	text_far _SeviiRoute32BattleText3
	text_end

SeviiRoute32EndBattleText3:
	text_far _SeviiRoute32EndBattleText3
	text_end

SeviiRoute32AfterBattleText3:
	text_far _SeviiRoute32AfterBattleText3
	text_end

SeviiRoute32_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

SeviiRoute32SignText1:
	text_asm
	ld hl, TreasureBeachSignText
	call PrintText
;	callfar ResetSeviiRoute32HiddenItems
	jp TextScriptEnd

TreasureBeachSignText:
	text_far _TreasureBeachSignText
	text_end
