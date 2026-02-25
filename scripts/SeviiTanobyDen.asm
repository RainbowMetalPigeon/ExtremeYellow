SeviiTanobyDen_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiTanobyDen_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SeviiTanobyDen_ScriptPointers:
	dw SeviiTanobyDenScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiTanobyDenScript0:
	ret

SeviiTanobyDen_TextPointers:
	dw SeviiTanobyDenArmMewtwoText
	dw SeviiTanobyDenMewText

SeviiTanobyDenTrainerHeaders:
	def_trainers
SeviiTanobyDenArmMewtwoTrainerHeader:
	trainer EVENT_BEAT_ARM_MEWTWO_TANOBY, 0, SeviiTanobyDenArmMewtwoBattleText, SeviiTanobyDenArmMewtwoBattleText, SeviiTanobyDenArmMewtwoBattleText
SeviiTanobyDenMewTrainerHeader:
	trainer EVENT_BEAT_MEW_TANOBY, 0, SeviiTanobyDenMewBattleText, SeviiTanobyDenMewBattleText, SeviiTanobyDenMewBattleText
	db -1 ; end

SeviiTanobyDenInitStaticEncounterBattle:
	call TalkToTrainer

    ld a, [wOpponentMonShiny]
    set BIT_MON_DELTA, a
    ld [wOpponentMonShiny], a

	jp TextScriptEnd

SeviiTanobyDenArmMewtwoText:
	text_asm
	ld hl, SeviiTanobyDenArmMewtwoTrainerHeader
	jr SeviiTanobyDenInitStaticEncounterBattle

SeviiTanobyDenArmMewtwoBattleText:
	text_far _SeviiTanobyDenArmMewtwoBattleText
	text_asm
	ld a, ARM_MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

SeviiTanobyDenMewText:
	text_asm
	ld hl, SeviiTanobyDenMewTrainerHeader
	jr SeviiTanobyDenInitStaticEncounterBattle

SeviiTanobyDenMewBattleText:
	text_far _SeviiTanobyDenMewBattleText
	text_asm
	ld a, MEW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
