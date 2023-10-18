CeladonGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, CeladonGymTrainerHeaders
	ld de, CeladonGym_ScriptPointers
	ld a, [wCeladonGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeladonGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "CELADON CITY@"

.LeaderName:
	db "ERIKA@"

CeladonGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	ret

CeladonGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw CeladonGymErikaPostBattle
	dw CeladonGymErikaPostBattleRematch ; new

CeladonGymErikaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeladonGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a

CeladonGymReceiveTM21:
	ld a, $a
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ERIKA
	lb bc, TM_GIGA_DRAIN, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $b
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM21
	jr .gymVictory
.BagFull
	ld a, $c
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_RAINBOWBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_RAINBOWBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_CELADON_GYM_TRAINER_0, EVENT_BEAT_CELADON_GYM_TRAINER_7

	jp CeladonGymResetScripts

CeladonGymErikaPostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeladonGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $d
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_ERIKA_REMATCH
	; block to check if with this we defeated all gym rematches
	; if yes, let's set one single event that will make League scripts so much nicer
	; in every gym we can skip the check corresponding to the gym itself
	CheckEvent EVENT_BEAT_BROCK_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_MISTY_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_LT_SURGE_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_KOGA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_SABRINA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_BLAINE_REMATCH
    jr z, .notAllRematchWons
    SetEvent EVENT_BEAT_ALL_GYMS_REMATCH
.notAllRematchWons
	jp CeladonGymResetScripts

CeladonGym_TextPointers:
	dw ErikaText
	dw CeladonGymTrainerText1
	dw CeladonGymTrainerText2
	dw CeladonGymTrainerText3
	dw CeladonGymTrainerText4
	dw CeladonGymTrainerText5
	dw CeladonGymTrainerText6
	dw CeladonGymTrainerText7
	dw CeladonGymTrainerText8
	dw ErikaRainbowBadgeInfoText
	dw ReceivedTM21Text
	dw TM21NoRoomText
	dw ErikaPostRematchText; new, $d

CeladonGymTrainerHeaders:
	def_trainers 2
CeladonGymTrainerHeader0:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_0, 2, CeladonGymBattleText2, CeladonGymEndBattleText2, CeladonGymAfterBattleText2
CeladonGymTrainerHeader1:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_1, 2, CeladonGymBattleText3, CeladonGymEndBattleText3, CeladonGymAfterBattleText3
CeladonGymTrainerHeader2:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_2, 4, CeladonGymBattleText4, CeladonGymEndBattleText4, CeladonGymAfterBattleText4
CeladonGymTrainerHeader3:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_3, 4, CeladonGymBattleText5, CeladonGymEndBattleText5, CeladonGymAfterBattleText5
CeladonGymTrainerHeader4:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_4, 2, CeladonGymBattleText6, CeladonGymEndBattleText6, CeladonGymAfterBattleText6
CeladonGymTrainerHeader5:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_5, 2, CeladonGymBattleText7, CeladonGymEndBattleText7, CeladonGymAfterBattleText7
CeladonGymTrainerHeader6:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_6, 3, CeladonGymBattleText8, CeladonGymEndBattleText8, CeladonGymAfterBattleText8
CeladonGymTrainerHeader7:
	trainer EVENT_BEAT_CELADON_GYM_TRAINER_7, 2, CeladonGymBattleText9, CeladonGymEndBattleText9, CeladonGymAfterBattleText9
	db -1 ; end

ErikaText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_ERIKA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM21
	jr nz, .afterBeat
	call z, CeladonGymReceiveTM21
	call DisableWaitingAfterTextDisplay
	jr .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, ErikaRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
;	ldh a, [hSpriteIndex]
;	ld [wSpriteIndex], a
;	call EngageMapTrainer
	call Delay3
	ld a, OPP_ERIKA
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld hl, ErikaRematchDefeatedText
	ld de, ErikaRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, ErikaPostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, ErikaPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedRainbowBadgeText
	ld de, ReceivedRainbowBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $4
	ld [wGymLeaderNo], a
	ld a, $3
	ld [wCeladonGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

ErikaPreBattleText:
	text_far _ErikaPreBattleText
	text_end

ReceivedRainbowBadgeText:
	text_far _ReceivedRainbowBadgeText
	text_end

ErikaPostBattleAdviceText:
	text_far _ErikaPostBattleAdviceText
	text_end

ErikaRainbowBadgeInfoText:
	text_far _ErikaRainbowBadgeInfoText
	text_end

ReceivedTM21Text:
	text_far _ReceivedTM21Text
	sound_get_item_1
	text_far _TM21ExplanationText
	text_end

TM21NoRoomText:
	text_far _TM21NoRoomText
	text_end

CeladonGymTrainerText1:
	text_asm
	ld hl, CeladonGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText2:
	text_far _CeladonGymBattleText2
	text_end

CeladonGymEndBattleText2:
	text_far _CeladonGymEndBattleText2
	text_end

CeladonGymAfterBattleText2:
	text_far _CeladonGymAfterBattleText2
	text_end

CeladonGymTrainerText2:
	text_asm
	ld hl, CeladonGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText3:
	text_far _CeladonGymBattleText3
	text_end

CeladonGymEndBattleText3:
	text_far _CeladonGymEndBattleText3
	text_end

CeladonGymAfterBattleText3:
	text_far _CeladonGymAfterBattleText3
	text_end

CeladonGymTrainerText3:
	text_asm
	ld hl, CeladonGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText4:
	text_far _CeladonGymBattleText4
	text_end

CeladonGymEndBattleText4:
	text_far _CeladonGymEndBattleText4
	text_end

CeladonGymAfterBattleText4:
	text_far _CeladonGymAfterBattleText4
	text_end

CeladonGymTrainerText4:
	text_asm
	ld hl, CeladonGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText5:
	text_far _CeladonGymBattleText5
	text_end

CeladonGymEndBattleText5:
	text_far _CeladonGymEndBattleText5
	text_end

CeladonGymAfterBattleText5:
	text_far _CeladonGymAfterBattleText5
	text_end

CeladonGymTrainerText5:
	text_asm
	ld hl, CeladonGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText6:
	text_far _CeladonGymBattleText6
	text_end

CeladonGymEndBattleText6:
	text_far _CeladonGymEndBattleText6
	text_end

CeladonGymAfterBattleText6:
	text_far _CeladonGymAfterBattleText6
	text_end

CeladonGymTrainerText6:
	text_asm
	ld hl, CeladonGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText7:
	text_far _CeladonGymBattleText7
	text_end

CeladonGymEndBattleText7:
	text_far _CeladonGymEndBattleText7
	text_end

CeladonGymAfterBattleText7:
	text_far _CeladonGymAfterBattleText7
	text_end

CeladonGymTrainerText7:
	text_asm
	ld hl, CeladonGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText8:
	text_far _CeladonGymBattleText8
	text_end

CeladonGymEndBattleText8:
	text_far _CeladonGymEndBattleText8
	text_end

CeladonGymAfterBattleText8:
	text_far _CeladonGymAfterBattleText8
	text_end

CeladonGymTrainerText8:
	text_asm
	ld hl, CeladonGymTrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

CeladonGymBattleText9:
	text_far _CeladonGymBattleText9
	text_end

CeladonGymEndBattleText9:
	text_far _CeladonGymEndBattleText9
	text_end

CeladonGymAfterBattleText9:
	text_far _CeladonGymAfterBattleText9
	text_end

; new ---------------------

ErikaRematchPreBattleText:
	text_far _ErikaRematchPreBattleText
	text_end

ErikaRematchDefeatedText:
	text_far _ErikaRematchDefeatedText
	text_end

ErikaPostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
