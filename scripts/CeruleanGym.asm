CeruleanGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeruleanGymTrainerHeaders
	ld de, CeruleanGym_ScriptPointers
	ld a, [wCeruleanGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "CERULEAN CITY@"

.LeaderName:
	db "MISTY@"

CeruleanGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	ret

CeruleanGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw CeruleanGymMistyPostBattle
	dw CeruleanGymMistyPostBattleRematch ; new

CeruleanGymMistyPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a

CeruleanGymReceiveTM11:
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_MISTY
	lb bc, TM_BUBBLEBEAM, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM11
	jr .gymVictory
.BagFull
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_CASCADEBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_CASCADEBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_CERULEAN_GYM_TRAINER_0, EVENT_BEAT_CERULEAN_GYM_TRAINER_2 ; new

	jp CeruleanGymResetScripts

CeruleanGymMistyPostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_MISTY_REMATCH
	jp CeruleanGymResetScripts

CeruleanGym_TextPointers:
	dw MistyText
	dw CeruleanGymTrainerText1
	dw CeruleanGymTrainerText2
	dw CeruleanGymTrainerText3
	dw CeruleanGymGuideText
	dw MistyCascadeBadgeInfoText
	dw ReceivedTM11Text
	dw TM11NoRoomText
	dw MistyPostRematchText; new, $9

CeruleanGymTrainerHeaders:
	def_trainers 2
CeruleanGymTrainerHeader0:
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_0, 1, CeruleanGymBattleText1, CeruleanGymEndBattleText1, CeruleanGymAfterBattleText1
CeruleanGymTrainerHeader1:
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_1, 3, CeruleanGymBattleText2, CeruleanGymEndBattleText2, CeruleanGymAfterBattleText2 ; updated, shortened visual
CeruleanGymTrainerHeader2:
	trainer EVENT_BEAT_CERULEAN_GYM_TRAINER_2, 1, CeruleanGymBattleText3, CeruleanGymEndBattleText3, CeruleanGymAfterBattleText3
	db -1 ; end

MistyText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_MISTY
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM11
	jr nz, .afterBeat
	call z, CeruleanGymReceiveTM11
	call DisableWaitingAfterTextDisplay
	jr .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, MistyRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_MISTY
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld hl, MistyRematchDefeatedText
	ld de, MistyRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wCeruleanGymCurScript], a
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, TM11ExplanationText
	call PrintText
	jr .done
.beforeBeat
	ld hl, MistyPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedCascadeBadgeText
	ld de, ReceivedCascadeBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $2
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wCeruleanGymCurScript], a
.done
	jp TextScriptEnd

MistyPreBattleText:
	text_far _MistyPreBattleText
	text_end

TM11ExplanationText:
	text_far _TM11ExplanationText
	text_end

MistyCascadeBadgeInfoText:
	text_far _MistyCascadeBadgeInfoText
	text_end

ReceivedTM11Text:
	text_far _ReceivedTM11Text
	sound_get_item_1
	text_end

TM11NoRoomText:
	text_far _TM11NoRoomText
	text_end

ReceivedCascadeBadgeText:
	text_far _ReceivedCascadeBadgeText
	text_end

CeruleanGymTrainerText1:
	text_asm
	ld hl, CeruleanGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymBattleText1:
	text_far _CeruleanGymBattleText1
	text_end

CeruleanGymEndBattleText1:
	text_far _CeruleanGymEndBattleText1
	text_end

CeruleanGymAfterBattleText1:
	text_far _CeruleanGymAfterBattleText1
	text_end

CeruleanGymTrainerText2:
	text_asm
	ld hl, CeruleanGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymBattleText2:
	text_far _CeruleanGymBattleText2
	text_end

CeruleanGymEndBattleText2:
	text_far _CeruleanGymEndBattleText2
	text_end

CeruleanGymAfterBattleText2:
	text_far _CeruleanGymAfterBattleText2
	text_end

CeruleanGymTrainerText3:
	text_asm
	ld hl, CeruleanGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

CeruleanGymBattleText3:
	text_far _CeruleanGymBattleText3
	text_end

CeruleanGymEndBattleText3:
	text_far _CeruleanGymEndBattleText3
	text_end

CeruleanGymAfterBattleText3:
	text_far _CeruleanGymAfterBattleText3
	text_end

CeruleanGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_MISTY
	jr nz, .afterBeat
	ld hl, CeruleanGymGuidePreBattleText
	call PrintText
	jr .done
.afterBeat
	ld hl, CeruleanGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd

CeruleanGymGuidePreBattleText:
	text_far _CeruleanGymGuidePreBattleText
	text_end

CeruleanGymGuidePostBattleText:
	text_far _CeruleanGymGuidePostBattleText
	text_end

; new ---------------------

MistyRematchPreBattleText:
	text_far _MistyRematchPreBattleText
	text_end

MistyRematchDefeatedText:
	text_far _MistyRematchDefeatedText
	text_end

MistyPostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
