RocketHideoutB1F_Script:
	RPTextChooser RocketHideoutB1F_TextPointers, RocketHideoutB1F_TextPointers_Rocket
	call RocketHideout1Script_OpenOrCloseLiftDoor
	call EnableAutoTextBoxDrawing
	ld hl, RocketHideout1TrainerHeaders
	ld de, RocketHideoutB1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

RocketHideout1Script_OpenOrCloseLiftDoor:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_ROCKET_PATH ; edited
	jr nz, .freeBlock
	CheckEvent EVENT_BEAT_ROCKET_HIDEOUT_GIOVANNI	; new
	jr nz, .freeBlock								; new
	CheckEventReuseA EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_4
	jr nz, .playSound
	ld a, $54 ; 84, closed
	jr .changeBlock
.playSound
	ld a, SFX_GO_INSIDE
	call PlaySound
.freeBlock
	ld a, $e ; free
.changeBlock
	ld [wNewTileBlockID], a
	lb bc, 8, 12
	predef_jump ReplaceTileBlock

RocketHideoutB1F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

RocketHideoutB1F_TextPointers:
	dw RocketHideout1Text1
	dw RocketHideout1Text2
	dw RocketHideout1Text3
	dw RocketHideout1Text4
	dw RocketHideout1Text5
	dw PickUpItemText
	dw PickUpItemText

RocketHideoutB1F_TextPointers_Rocket:
	dw RocketHideout1Text1
	dw RocketHideout1Text2
	dw RocketHideout1Text3
	dw RocketHideout1Text4
	dw RocketHideout1Text5
	dw PickUpItemText
	dw PickUpItemText

RocketHideout1TrainerHeaders:
	def_trainers
RocketHideout1TrainerHeader0:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_0, 3, RocketHideout1BattleText2, RocketHideout1EndBattleText2, RocketHideout1AfterBattleTxt2
RocketHideout1TrainerHeader1:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_1, 2, RocketHideout1BattleText3, RocketHideout1EndBattleText3, RocketHideout1AfterBattleTxt3
RocketHideout1TrainerHeader2:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_2, 2, RocketHideout1BattleText4, RocketHideout1EndBattleText4, RocketHideout1AfterBattleTxt4
RocketHideout1TrainerHeader3:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_3, 3, RocketHideout1BattleText5, RocketHideout1EndBattleText5, RocketHideout1AfterBattleTxt5
RocketHideout1TrainerHeader4:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_4, 3, RocketHideout1BattleText6, RocketHideout1EndBattleText6, RocketHideout1AfterBattleTxt6
	db -1 ; end

RocketHideout1Text1:
	text_asm
	ld hl, RocketHideout1TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout1Text2:
	text_asm
	ld hl, RocketHideout1TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout1Text3:
	text_asm
	ld hl, RocketHideout1TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout1Text4:
	text_asm
	ld hl, RocketHideout1TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout1Text5:
	text_asm
	ld hl, RocketHideout1TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout1EndBattleText6:
	text_far _RocketHideout1EndBattleText6
	text_asm
	SetEvent EVENT_BEAT_ROCKET_HIDEOUT_1_TRAINER_4
	ld hl, RocketHideout1Text_44c9f
	ret

RocketHideout1Text_44c9f:
	text_promptbutton
	text_end

RocketHideout1BattleText2:
	text_far _RocketHideout1BattleText2
	text_end

RocketHideout1EndBattleText2:
	text_far _RocketHideout1EndBattleText2
	text_end

RocketHideout1AfterBattleTxt2:
	text_far _RocketHideout1AfterBattleTxt2
	text_end

RocketHideout1BattleText3:
	text_far _RocketHideout1BattleText3
	text_end

RocketHideout1EndBattleText3:
	text_far _RocketHideout1EndBattleText3
	text_end

RocketHideout1AfterBattleTxt3:
	text_far _RocketHideout1AfterBattleTxt3
	text_end

RocketHideout1BattleText4:
	text_far _RocketHideout1BattleText4
	text_end

RocketHideout1EndBattleText4:
	text_far _RocketHideout1EndBattleText4
	text_end

RocketHideout1AfterBattleTxt4:
	text_far _RocketHideout1AfterBattleTxt4
	text_end

RocketHideout1BattleText5:
	text_far _RocketHideout1BattleText5
	text_end

RocketHideout1EndBattleText5:
	text_far _RocketHideout1EndBattleText5
	text_end

RocketHideout1AfterBattleTxt5:
	text_far _RocketHideout1AfterBattleTxt5
	text_end

RocketHideout1BattleText6:
	text_far _RocketHideout1BattleText6
	text_end

RocketHideout1AfterBattleTxt6:
	text_far _RocketHideout1AfterBattleTxt6
	text_end
