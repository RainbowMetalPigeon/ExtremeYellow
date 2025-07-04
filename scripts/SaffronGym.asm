SaffronGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, SaffronGymTrainerHeaders
	ld de, SaffronGym_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "SAFFRON CITY@"

.LeaderName:
	db "SABRINA@"

SaffronGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SaffronGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SaffronGymSabrinaPostBattle
	dw SaffronGymSabrinaPostBattleRematch ; new

SaffronGymSabrinaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SaffronGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a

SaffronGymReceiveTM46:
	ld a, $b
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA
	lb bc, TM_PSYWAVE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $c
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM46
	jr .gymVictory
.BagFull
	ld a, $d
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_MARSHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_MARSHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_SAFFRON_GYM_TRAINER_0, EVENT_BEAT_SAFFRON_GYM_TRAINER_6

	jp SaffronGymResetScripts

SaffronGymSabrinaPostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, SaffronGymResetScripts
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $e
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA_REMATCH
	; block to check if with this we defeated all gym rematches
	; if yes, let's set one single event that will make League scripts so much nicer
	; in every gym we can skip the check corresponding to the gym itself
	CheckEvent EVENT_BEAT_BROCK_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_MISTY_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_LT_SURGE_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_ERIKA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_KOGA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_BLAINE_REMATCH
    jr z, .notAllRematchWons
    SetEvent EVENT_BEAT_ALL_GYMS_REMATCH
.notAllRematchWons
	jp SaffronGymResetScripts

SaffronGym_TextPointers:
	dw SabrinaText
	dw SaffronGymTrainerText1
	dw SaffronGymTrainerText2
	dw SaffronGymTrainerText3
	dw SaffronGymTrainerText4
	dw SaffronGymTrainerText5
	dw SaffronGymTrainerText6
	dw SaffronGymTrainerText7
	dw SaffronGymTrainerText8
	dw SaffronGymGuideText
	dw KogaMarshBadgeInfoText ; why Koga lol
	dw ReceivedTM46Text
	dw TM46NoRoomText
	dw SabrinaPostRematchText; new, $e

SaffronGymTrainerHeaders:
	def_trainers 2
SaffronGymTrainerHeader0:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_0, 3, SaffronGymBattleText1, SaffronGymEndBattleText1, SaffronGymAfterBattleText1
SaffronGymTrainerHeader1:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_1, 3, SaffronGymBattleText2, SaffronGymEndBattleText2, SaffronGymAfterBattleText2
SaffronGymTrainerHeader2:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_2, 3, SaffronGymBattleText3, SaffronGymEndBattleText3, SaffronGymAfterBattleText3
SaffronGymTrainerHeader3:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_3, 3, SaffronGymBattleText4, SaffronGymEndBattleText4, SaffronGymAfterBattleText4
SaffronGymTrainerHeader4:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_4, 3, SaffronGymBattleText5, SaffronGymEndBattleText5, SaffronGymAfterBattleText5
SaffronGymTrainerHeader5:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_5, 3, SaffronGymBattleText6, SaffronGymEndBattleText6, SaffronGymAfterBattleText6
SaffronGymTrainerHeader6:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_6, 3, SaffronGymBattleText7, SaffronGymEndBattleText7, SaffronGymAfterBattleText7
SaffronGymTrainerHeader7:
	trainer EVENT_BEAT_SAFFRON_GYM_TRAINER_7, 4, SaffronGymBattleText8, SaffronGymEndBattleText8, SaffronGymAfterBattleText8
	db -1 ; end

SabrinaText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_SABRINA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM46
	jr nz, .afterBeat
	call z, SaffronGymReceiveTM46
	call DisableWaitingAfterTextDisplay
	jr .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, SabrinaRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SABRINA
	ld [wCurOpponent], a
	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, SabrinaRematchDefeatedText
	ld de, SabrinaRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, SabrinaPostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, SabrinaPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedMarshBadgeText
	ld de, ReceivedMarshBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
; new, for the adaptive gym teams
	callfar CountHowManyBadges ; d=#badges
	ld a, d
	inc a
	ld [wTrainerNo], a
; back to vanilla
	ld a, $6
	ld [wGymLeaderNo], a
	ld a, $3
	ld [wCurMapScript], a ; edited
.done
	jp TextScriptEnd

SabrinaPreBattleText:
	text_far _SabrinaPreBattleText
	text_end

ReceivedMarshBadgeText:
	text_far _ReceivedMarshBadgeText
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_promptbutton
	text_end

SabrinaPostBattleAdviceText:
	text_far _SabrinaPostBattleAdviceText
	text_end

KogaMarshBadgeInfoText:
	text_far _KogaMarshBadgeInfoText
	text_end

ReceivedTM46Text:
	text_far _ReceivedTM46Text
	sound_get_item_1
	text_far _TM46ExplanationText
	text_end

TM46NoRoomText:
	text_far _TM46NoRoomText
	text_end

SaffronGymTrainerText1:
	text_asm
	ld hl, SaffronGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText2:
	text_asm
	ld hl, SaffronGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText3:
	text_asm
	ld hl, SaffronGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText4:
	text_asm
	ld hl, SaffronGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText5:
	text_asm
	ld hl, SaffronGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText6:
	text_asm
	ld hl, SaffronGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText7:
	text_asm
	ld hl, SaffronGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymTrainerText8:
	text_asm
	ld hl, SaffronGymTrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

SaffronGymGuideText:
	text_asm
	CheckEvent EVENT_BEAT_SABRINA
	jr nz, .afterBeat
	ld hl, SaffronGymGuidePreBattleText
	call PrintText
	jr .done
.afterBeat
	ld hl, SaffronGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd

SaffronGymGuidePreBattleText:
	text_far _SaffronGymGuidePreBattleText
	text_end

SaffronGymGuidePostBattleText:
	text_far _SaffronGymGuidePostBattleText
	text_end

SaffronGymBattleText1:
	text_far _SaffronGymBattleText1
	text_end

SaffronGymEndBattleText1:
	text_far _SaffronGymEndBattleText1
	text_end

SaffronGymAfterBattleText1:
	text_far _SaffronGymAfterBattleText1
	text_end

SaffronGymBattleText2:
	text_far _SaffronGymBattleText2
	text_end

SaffronGymEndBattleText2:
	text_far _SaffronGymEndBattleText2
	text_end

SaffronGymAfterBattleText2:
	text_far _SaffronGymAfterBattleText2
	text_end

SaffronGymBattleText3:
	text_far _SaffronGymBattleText3
	text_end

SaffronGymEndBattleText3:
	text_far _SaffronGymEndBattleText3
	text_end

SaffronGymAfterBattleText3:
	text_far _SaffronGymAfterBattleText3
	text_end

SaffronGymBattleText4:
	text_far _SaffronGymBattleText4
	text_end

SaffronGymEndBattleText4:
	text_far _SaffronGymEndBattleText4
	text_end

SaffronGymAfterBattleText4:
	text_far _SaffronGymAfterBattleText4
	text_end

SaffronGymBattleText5:
	text_far _SaffronGymBattleText5
	text_end

SaffronGymEndBattleText5:
	text_far _SaffronGymEndBattleText5
	text_end

SaffronGymAfterBattleText5:
	text_far _SaffronGymAfterBattleText5
	text_end

SaffronGymBattleText6:
	text_far _SaffronGymBattleText6
	text_end

SaffronGymEndBattleText6:
	text_far _SaffronGymEndBattleText6
	text_end

SaffronGymAfterBattleText6:
	text_far _SaffronGymAfterBattleText6
	text_end

SaffronGymBattleText7:
	text_far _SaffronGymBattleText7
	text_end

SaffronGymEndBattleText7:
	text_far _SaffronGymEndBattleText7
	text_end

SaffronGymAfterBattleText7:
	text_far _SaffronGymAfterBattleText7
	text_end

SaffronGymBattleText8:
	text_far _SaffronGymBattleText8
	text_end

SaffronGymEndBattleText8:
	text_far _SaffronGymEndBattleText8
	text_end

SaffronGymAfterBattleText8:
	text_far _SaffronGymAfterBattleText8
	text_end

; new ---------------------

SabrinaRematchPreBattleText:
	text_far _SabrinaRematchPreBattleText
	text_end

SabrinaRematchDefeatedText:
	text_far _SabrinaRematchDefeatedText
	text_end

SabrinaPostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
