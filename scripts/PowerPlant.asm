PowerPlant_Script:
	call EnableAutoTextBoxDrawing
	ld hl, PowerPlantTrainerHeaders
	ld de, PowerPlant_ScriptPointers
	ld a, [wPowerPlantCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPowerPlantCurScript], a
	ret

PowerPlant_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw PowerPlantLtSurgePostBattleRematch ; new, map-dependent

PowerPlant_TextPointers:
	dw PowerPlantTextLtSurge ; new
	dw Voltorb0Text
	dw Voltorb1Text
	dw Voltorb2Text
	dw Voltorb3Text
	dw Voltorb4Text
	dw Voltorb5Text
	dw Voltorb6Text
	dw Voltorb7Text
	dw ZapdosText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PowerPlantTextLtSurgePostBattle ; 15, new, map-dependent

PowerPlantTrainerHeaders:
	def_trainers
Voltorb0TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_0, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb1TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_1, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb2TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_2, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb3TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_3, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb4TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_4, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb5TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_5, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb6TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_6, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
Voltorb7TrainerHeader:
	trainer EVENT_BEAT_POWER_PLANT_VOLTORB_7, 0, VoltorbBattleText, VoltorbBattleText, VoltorbBattleText
ZapdosTrainerHeader:
	trainer EVENT_BEAT_ZAPDOS, 0, ZapdosBattleText, ZapdosBattleText, ZapdosBattleText
	db -1 ; end

InitVoltorbBattle:
	call TalkToTrainer
	ld a, [wCurMapScript]
	ld [wPowerPlantCurScript], a
	jp TextScriptEnd

Voltorb0Text:
	text_asm
	ld hl, Voltorb0TrainerHeader
	jr InitVoltorbBattle

Voltorb1Text:
	text_asm
	ld hl, Voltorb1TrainerHeader
	jr InitVoltorbBattle

Voltorb2Text:
	text_asm
	ld hl, Voltorb2TrainerHeader
	jr InitVoltorbBattle

Voltorb3Text:
	text_asm
	ld hl, Voltorb3TrainerHeader
	jr InitVoltorbBattle

Voltorb4Text:
	text_asm
	ld hl, Voltorb4TrainerHeader
	jr InitVoltorbBattle

Voltorb5Text:
	text_asm
	ld hl, Voltorb5TrainerHeader
	jr InitVoltorbBattle

Voltorb6Text:
	text_asm
	ld hl, Voltorb6TrainerHeader
	jr InitVoltorbBattle

Voltorb7Text:
	text_asm
	ld hl, Voltorb7TrainerHeader
	jr InitVoltorbBattle

ZapdosText:
	text_asm
	ld hl, ZapdosTrainerHeader
	jr InitVoltorbBattle

VoltorbBattleText:
	text_far _VoltorbBattleText
	text_end

ZapdosBattleText:
	text_far _ZapdosBattleText
	text_asm
	ld a, ZAPDOS
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; new ------------------------------------------------

PowerPlantTextLtSurge:
	text_asm
	ld hl, PowerPlantLtSurgeBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	; make this an inverse battle
	ld a, 1
	ld [wInverseBattle], a

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_LT_SURGE
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, PowerPlantLtSurgePostBattleText
	ld de, PowerPlantLtSurgePostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $3 ; new script, map-dependent
	ld [wPowerPlantCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

PowerPlantLtSurgeBeforeBattleText:
	text_far _PowerPlantLtSurgeBeforeBattleText
	text_end

PowerPlantLtSurgePostBattleText:
	text_far _PowerPlantLtSurgePostBattleText
	text_end

PowerPlantLtSurgePostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, PowerPlantResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 15 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LT_SURGE_REMATCH_INVERSE ; map-dependent
	jp PowerPlantResetScripts

PowerPlantResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wPowerPlantCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

PowerPlantTextLtSurgePostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
	
