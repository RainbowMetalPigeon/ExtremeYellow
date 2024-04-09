CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanCaveB1FTrainerHeaders
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

CeruleanCaveB1F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

CeruleanCaveB1F_TextPointers:
	dw MewtwoText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw CeruleanCaveB1FTextTraveler ; new

CeruleanCaveB1FTrainerHeaders:
	def_trainers
MewtwoTrainerHeader:
	trainer EVENT_BEAT_MEWTWO, 0, MewtwoBattleText, MewtwoBattleText, MewtwoBattleText
	db -1 ; end

MewtwoText:
	text_asm
	ld hl, MewtwoTrainerHeader
	call TalkToTrainer
	jp TextScriptEnd

MewtwoBattleText:
	text_far _MewtwoBattleText
	text_asm
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

; Traveler rematch, new ------------------------------------------------

CeruleanCaveB1FTextTraveler:
	text_asm
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic

	ld hl, TravelerBeforeBattleText
	call PrintText

	callfar NormalInverseChoice
	ld a, [wCurrentMenuItem]
	ld [wInverseBattle], a

	ld hl, TravelerBeforeBattleText2
	call PrintText

	; they seem to do nothing?
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]		; Turn on battle animations to make the battle feel more epic

	call Delay3
	ld a, OPP_TRAVELER
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, TravelerPostBattleTextVictory
	ld de, TravelerPostBattleTextDefeat
	call SaveEndBattleTextPointers
	jp TextScriptEnd

TravelerBeforeBattleText:
	text_far _TravelerBeforeBattleText
	text_end

TravelerBeforeBattleText2:
	text_far _TravelerBeforeBattleText2
	text_end

TravelerPostBattleTextVictory:
	text_far _TravelerPostBattleTextVictory
	text_end

TravelerPostBattleTextDefeat:
	text_far _TravelerPostBattleTextDefeat
	text_end
