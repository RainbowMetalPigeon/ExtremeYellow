FuchsiaGym_Script:
	RPTextChooser FuchsiaGym_TextPointers, FuchsiaGym_TextPointers_Rocket
	call .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, FuchsiaGymTrainerHeaders
	ld de, FuchsiaGym_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

.LoadNames:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	ret

.CityName:
	db "FUCHSIA CITY@"

.LeaderName:
	db "KOGA@"

FuchsiaGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

FuchsiaGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw FuchsiaGymKogaPostBattle
	dw FuchsiaGymKogaPostBattleRematch ; new
	dw FuchsiaGymAdvanceTrainerCounter ; new

FuchsiaGymKogaPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; fallthrough
FuchsiaGymReceiveTM06:
	ld a, $a
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA
	lb bc, TM_TOXIC, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $b
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM06
	jr .gymVictory
.BagFull
	ld a, $c
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_SOULBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, EVENT_BEAT_FUCHSIA_GYM_TRAINER_5

	jp FuchsiaGymResetScripts

FuchsiaGymKogaPostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymResetScripts
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $d
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA_REMATCH
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
    CheckEvent EVENT_BEAT_SABRINA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_BLAINE_REMATCH
    jr z, .notAllRematchWons
    SetEvent EVENT_BEAT_ALL_GYMS_REMATCH
.notAllRematchWons
	jp FuchsiaGymResetScripts

FuchsiaGym_TextPointers:
	dw FuchsiaGymRandomizeTrainersText1 ; edited
	dw FuchsiaGymRandomizeTrainersText2 ; edited
	dw FuchsiaGymRandomizeTrainersText3 ; edited
	dw FuchsiaGymRandomizeTrainersText4 ; edited
	dw FuchsiaGymRandomizeTrainersText5 ; edited
	dw FuchsiaGymRandomizeTrainersText6 ; edited
	dw FuchsiaGymRandomizeTrainersText7 ; edited
	dw FuchsiaGymRandomizeTrainersText8 ; edited
	dw FuchsiaGymGuideText ; 9
	; scripts
	dw KogaSoulBadgeInfoText
	dw ReceivedTM06Text
	dw TM06NoRoomText
	dw KogaPostRematchText; new, $d = 13

FuchsiaGym_TextPointers_Rocket:
	dw KogaText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymTrainerText_RP
	dw FuchsiaGymGuideText_RP ; 9
	; scripts
	dw KogaSoulBadgeInfoText_RP
	dw ReceivedTM06Text_RP
	dw TM06NoRoomText_RP

FuchsiaGymTrainerHeaders:
	def_trainers 2
FuchsiaGymTrainerHeader0:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, 0, FuchsiaGymBattleText1, FuchsiaGymEndBattleText1, FuchsiaGymAfterBattleText1
FuchsiaGymTrainerHeader1:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_1, 0, FuchsiaGymBattleText2, FuchsiaGymEndBattleText2, FuchsiaGymAfterBattleText2
FuchsiaGymTrainerHeader2:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_2, 0, FuchsiaGymBattleText3, FuchsiaGymEndBattleText3, FuchsiaGymAfterBattleText3
FuchsiaGymTrainerHeader3:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_3, 0, FuchsiaGymBattleText4, FuchsiaGymEndBattleText4, FuchsiaGymAfterBattleText4
FuchsiaGymTrainerHeader4:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_4, 0, FuchsiaGymBattleText5, FuchsiaGymEndBattleText5, FuchsiaGymAfterBattleText5
FuchsiaGymTrainerHeader5:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_5, 0, FuchsiaGymBattleText6, FuchsiaGymEndBattleText6, FuchsiaGymAfterBattleText6
FuchsiaGymTrainerHeader6:
	trainer EVENT_BEAT_FUCHSIA_GYM_TRAINER_6, 0, FuchsiaGymBattleText7, FuchsiaGymEndBattleText7, FuchsiaGymAfterBattleText7
	db -1 ; end

DumbFunction2:
	ret

KogaText:
	text_asm
	call DumbFunction2 ; TBE
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_KOGA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM06
	jr nz, .afterBeat
	call z, FuchsiaGymReceiveTM06
	call DisableWaitingAfterTextDisplay
	jp .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, KogaRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_KOGA
	ld [wCurOpponent], a
	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, KogaRematchDefeatedText
	ld de, KogaRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, KogaPostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, KogaBeforeBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedSoulBadgeText
	ld de, ReceivedSoulBadgeText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, OPP_KOGA ; repeated for new multi-Koga gimmick
	ld [wCurOpponent], a
; new, for the adaptive gym teams
	callfar CountHowManyBadges ; d=#badges
	ld a, d
	inc a
	ld [wTrainerNo], a
; back to vanilla
	ld a, $5
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wCurMapScript], a ; edited
.done
	jp TextScriptEnd

KogaBeforeBattleText:
	text_far _KogaBeforeBattleText
	text_end

ReceivedSoulBadgeText:
	text_far _ReceivedSoulBadgeText
	text_end

KogaPostBattleAdviceText:
	text_far _KogaPostBattleAdviceText
	text_end

KogaSoulBadgeInfoText:
	text_far _KogaSoulBadgeInfoText
	text_end

ReceivedTM06Text:
	text_far _ReceivedTM06Text
	sound_get_item_1 ; edited

TM06ExplanationText:
	text_far _TM06ExplanationText
	text_end

TM06NoRoomText:
	text_far _TM06NoRoomText
	text_end

FuchsiaGymTrainerText1:
	text_asm
	ld hl, FuchsiaGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText1:
	text_far _FuchsiaGymBattleText1
	text_end

FuchsiaGymEndBattleText1:
	text_far _FuchsiaGymEndBattleText1
	text_end

FuchsiaGymAfterBattleText1:
	text_far _FuchsiaGymAfterBattleText1
	text_end

FuchsiaGymTrainerText2:
	text_asm
	ld hl, FuchsiaGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText2:
	text_far _FuchsiaGymBattleText2
	text_end

FuchsiaGymEndBattleText2:
	text_far _FuchsiaGymEndBattleText2
	text_end

FuchsiaGymAfterBattleText2:
	text_far _FuchsiaGymAfterBattleText2
	text_end

FuchsiaGymTrainerText3:
	text_asm
	ld hl, FuchsiaGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText3:
	text_far _FuchsiaGymBattleText3
	text_end

FuchsiaGymEndBattleText3:
	text_far _FuchsiaGymEndBattleText3
	text_end

FuchsiaGymAfterBattleText3:
	text_far _FuchsiaGymAfterBattleText3
	text_end

FuchsiaGymTrainerText4:
	text_asm
	ld hl, FuchsiaGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText4:
	text_far _FuchsiaGymBattleText4
	text_end

FuchsiaGymEndBattleText4:
	text_far _FuchsiaGymEndBattleText4
	text_end

FuchsiaGymAfterBattleText4:
	text_far _FuchsiaGymAfterBattleText4
	text_end

FuchsiaGymTrainerText5:
	text_asm
	ld hl, FuchsiaGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText5:
	text_far _FuchsiaGymBattleText5
	text_end

FuchsiaGymEndBattleText5:
	text_far _FuchsiaGymEndBattleText5
	text_end

FuchsiaGymAfterBattleText5:
	text_far _FuchsiaGymAfterBattleText5
	text_end

FuchsiaGymTrainerText6:
	text_asm
	ld hl, FuchsiaGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText6:
	text_far _FuchsiaGymBattleText6
	text_end

FuchsiaGymEndBattleText6:
	text_far _FuchsiaGymEndBattleText6
	text_end

FuchsiaGymAfterBattleText6:
	text_far _FuchsiaGymAfterBattleText6
	text_end

FuchsiaGymTrainerText7:
	text_asm
	ld hl, FuchsiaGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText7:
	text_far _FuchsiaGymBattleText7
	text_end

FuchsiaGymEndBattleText7:
	text_far _FuchsiaGymEndBattleText7
	text_end

FuchsiaGymAfterBattleText7:
	text_far _FuchsiaGymAfterBattleText7
	text_end

FuchsiaGymGuideText:
	text_asm
; new, modify text if Koga is absent
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymGuidePreKogaReturn
	jr z, .afterBeat
; back to vanilla
	CheckEvent EVENT_BEAT_KOGA
	ld hl, FuchsiaGymGuidePostBattleText
	jr nz, .afterBeat
	ld hl, FuchsiaGymGuidePreBattleText
.afterBeat
	call PrintText
	jp TextScriptEnd

FuchsiaGymGuidePreKogaReturn: ; new
	text_far _FuchsiaGymGuidePreKogaReturn
	text_end

FuchsiaGymGuidePreBattleText:
	text_far _FuchsiaGymGuidePreBattleText
	text_end

FuchsiaGymGuidePostBattleText:
	text_far _FuchsiaGymGuidePostBattleText
	text_end

; new ---------------------

KogaRematchPreBattleText:
	text_far _KogaRematchPreBattleText
	text_end

KogaRematchDefeatedText:
	text_far _KogaRematchDefeatedText
	text_end

KogaPostRematchText:
	text_far _GymLeaderPostRematchText
	text_end

; new for randomizing trainers ===================

DumbFunction:
	ret

FuchsiaGymRandomizeTrainersText1:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_0
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText2:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_1
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText3:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_2
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText4:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_3
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText5:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_4
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText6:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_5
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText7:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_6
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText8:
	text_asm
	call DumbFunction
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymNoBattleText_Common
	jr z, .printAndEnd
	CheckEvent EVENT_BEAT_KOGA
	jr z, .kogaNotYetBeaten
	ld a, [wKogaSpriteIndex]
	ld b, a
	ld a, [hSpriteIndex]
	cp b
	jr nz, .commonPostBattle
	ld hl, KogaText
.printAndEnd
	call PrintText
	jp TextScriptEnd
.kogaNotYetBeaten
	CheckEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_7
	jr z, .notYetEngaged
.commonPostBattle
	ld hl, FuchsiaGymAfterBattleText_Common
	call PrintText
	jp TextScriptEnd
.notYetEngaged
	ld a, [hSpriteIndex]
	ld [wUniQuizAnswer+9], a
	call FuchsiaGymRandomizeTrainersText_Core
	jp TextScriptEnd

FuchsiaGymRandomizeTrainersText_Core:
	ld hl, FuchsiaGym_TextPointers_ForRandomization
	ld a, [wHowManyTrainersBeforeKoga]
	cp 7 ; Koga
	jr nz, .notKogaYet
; finally Koga
	ld a, [wUniQuizAnswer+9]
	ld [wKogaSpriteIndex], a
	ld hl, KogaText
	call PrintText
	jp TextScriptEnd
.notKogaYet
	add a ; double
	add a ; quadruple, as we have dw+db+db
	ld c, a
	ld b, 0
	add hl, bc ; now hl points to the new next trainer text pointer
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a ; now we have the pointer itself
	call TalkToTrainer
	pop hl
	inc hl
	inc hl
	ld a, [hli]
	ld [wCurOpponent], a
	ld a, [hl]
	ld [wTrainerNo], a
	ld a, 5
	ld [wCurMapScript], a
	ret

FuchsiaGym_TextPointers_ForRandomization:
	dwbb FuchsiaGymTrainerHeader0, OPP_JUGGLER, 7
	dwbb FuchsiaGymTrainerHeader1, OPP_JUGGLER, 3
	dwbb FuchsiaGymTrainerHeader2, OPP_JUGGLER, 8
	dwbb FuchsiaGymTrainerHeader3, OPP_TAMER, 1
	dwbb FuchsiaGymTrainerHeader4, OPP_TAMER, 2
	dwbb FuchsiaGymTrainerHeader5, OPP_JUGGLER, 4 ; explosive
	dwbb FuchsiaGymTrainerHeader6, OPP_COOLTRAINER, 33 ; Koga's kid

FuchsiaGymAdvanceTrainerCounter:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymResetScripts
; we won
; set proper flag
	ld a, [wUniQuizAnswer+9]
	cp 1
	jr z, .setFlag0
	cp 2
	jr z, .setFlag1
	cp 3
	jr z, .setFlag2
	cp 4
	jr z, .setFlag3
	cp 5
	jr z, .setFlag4
	cp 6
	jr z, .setFlag5
	cp 7
	jr z, .setFlag6
; otherwise
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_7
	jr .continue
.setFlag6
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_6
	jr .continue
.setFlag0
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_0
	jr .continue
.setFlag1
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_1
	jr .continue
.setFlag2
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_2
	jr .continue
.setFlag3
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_3
	jr .continue
.setFlag4
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_4
	jr .continue
.setFlag5
	SetEvent EVENT_ENGAGED_WITH_FUCHSIA_TRAINER_5
.continue
; advance counter
	ld a, [wHowManyTrainersBeforeKoga]
	inc a
	ld [wHowManyTrainersBeforeKoga], a
	jp FuchsiaGymResetScripts

FuchsiaGymAfterBattleText_Common:
	text_far _FuchsiaGymAfterBattleText_Common
	text_end

FuchsiaGymNoBattleText_Common:
	text_far _FuchsiaGymNoBattleText_Common
	text_end

; new for RP =====================================

KogaText_RP:
	text_asm
	CheckEvent EVENT_BEAT_KOGA
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM06
	jr nz, .afterBeat
	call z, FuchsiaGymReceiveTM06
	call DisableWaitingAfterTextDisplay
	jr .done

.afterBeat
	ld hl, KogaPostBattleText_RP
	call PrintText
	jr .done
.beforeBeat
	ld hl, KogaBeforeBattleText_RP
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedSoulBadgeText_RP
	ld de, ReceivedSoulBadgeText_RP
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters

	ld a, 8
	ld [wTrainerNo], a

	ld a, $5
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

KogaPostBattleText_RP:
	text_far _KogaPostBattleText_RP
	text_end

KogaBeforeBattleText_RP:
	text_far _KogaBeforeBattleText_RP
	text_end

ReceivedSoulBadgeText_RP:
	text_far _ReceivedSoulBadgeText_RP
	text_end

KogaSoulBadgeInfoText_RP:
	text_far _KogaSoulBadgeInfoText_RP
	text_end

TM06NoRoomText_RP:
	text_far _TM06NoRoomText_RP
	text_end

ReceivedTM06Text_RP:
	text_far _ReceivedTM06Text
	sound_get_item_1
	text_end

FuchsiaGymGuideText_RP:
	text_far _GymGuideText_RocketPath
	text_end

FuchsiaGymTrainerText_RP:
	text_asm
	CheckEvent EVENT_BEAT_KOGA
	ld hl, FuchsiaGymTrainerText_RP_AfterBeatKoga
	jr nz, .printAndEnd
	CheckEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld hl, FuchsiaGymTrainerText_RP_AfterMeetingRoom
	jr nz, .printAndEnd
	ld hl, FuchsiaGymTrainerText_RP_BeforeMeetingRoom
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaGymTrainerText_RP_AfterBeatKoga::
	text_far _FuchsiaGymTrainerText_RP_AfterBeatKoga
	text_end

FuchsiaGymTrainerText_RP_AfterMeetingRoom::
	text_far _FuchsiaGymTrainerText_RP_AfterMeetingRoom
	text_end

FuchsiaGymTrainerText_RP_BeforeMeetingRoom::
	text_far _FuchsiaGymTrainerText_RP_BeforeMeetingRoom
	text_end
