SeviiRoute35_Script:
	RPTextChooser SeviiRoute35_TextPointers, SeviiRoute35_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute35TrainerHeaders
	ld de, SeviiRoute35_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute35_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute35_TextPointers:
	dw SeviiRoute35Text1 ; trainer: deciphering Hiker
	dw PickUpItemText
	; signs
	dw SeviiRoute35Text3
	dw SeviiRoute35Text4

SeviiRoute35_TextPointers_Rocket:
	dw SeviiRoute35Text1 ; trainer: deciphering Hiker
	dw PickUpItemText
	; signs
	dw SeviiRoute35Text3
	dw SeviiRoute35Text4

SeviiRoute35TrainerHeaders:
	def_trainers
SeviiRoute35TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_35_TRAINER_1, 1, SeviiRoute35BattleText1, SeviiRoute35EndBattleText1, SeviiRoute35AfterBattleText1
	db -1 ; end

SeviiRoute35Text1:
	text_asm
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, SeviiRoute35TrainerHeader1
	jr SeviiRoute35_TalkToTrainer

SeviiRoute35_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

SeviiRoute35BattleText1:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, SeviiRoute35BattleText1_RP
	jr nz, .printAndEnd
	ld hl, SeviiRoute35BattleText1_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute35BattleText1_HP:
	text_far _SeviiRoute35BattleText1_HP
	text_end

SeviiRoute35BattleText1_RP:
	text_far _SeviiRoute35BattleText1_RP
	text_end

SeviiRoute35EndBattleText1:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, SeviiRoute35EndBattleText1_RP
	jr nz, .printAndEnd
	ld hl, SeviiRoute35EndBattleText1_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute35EndBattleText1_HP:
	text_far _SeviiRoute35EndBattleText1_HP
	text_end

SeviiRoute35EndBattleText1_RP:
	text_far _SeviiRoute35EndBattleText1_RP
	text_end

SeviiRoute35AfterBattleText1:
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, SeviiRoute35AfterBattleText1_RP
	jr nz, .printAndEnd
	ld hl, SeviiRoute35AfterBattleText1_HP
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute35AfterBattleText1_HP:
	text_far _SeviiRoute35AfterBattleText1_HP
	text_end

SeviiRoute35AfterBattleText1_RP:
	text_far _SeviiRoute35AfterBattleText1_RP
	text_end

SeviiRoute35Text3:
	text_far _SeviiRoute35Text3
	text_end

SeviiRoute35Text4:
	text_far _SeviiRoute35Text4
	text_end
