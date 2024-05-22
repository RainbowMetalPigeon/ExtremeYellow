PewterGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .LoadNames
	call EnableAutoTextBoxDrawing
	ld hl, PewterGymTrainerHeaders
	ld de, PewterGym_ScriptPointers
	ld a, [wPewterGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPewterGymCurScript], a
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	ret

.CityName:
	db "PEWTER CITY@"

.LeaderName:
	db "BROCK@"

PewterGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
	ret

PewterGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw PewterGymBrockPostBattle
	dw PewterGymBrockPostBattleRematch ; new

PewterGymBrockPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PewterGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; fallthrough
PewterGymScriptReceiveTM34:
	ld a, $5
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BROCK
	lb bc, TM_BIDE, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM34
	jr .gymVictory
.BagFull
	ld a, $7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_BOULDERBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_BOULDERBADGE, [hl]

; edited, commented out, don't hide the gym guy anymore
;	ld a, HS_GYM_GUY
;	ld [wMissableObjectIndex], a
;	predef HideObject
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject

	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE

	; deactivate gym trainers
	SetEvents EVENT_BEAT_PEWTER_GYM_TRAINER_0, EVENT_BEAT_PEWTER_GYM_TRAINER_1

	jp PewterGymResetScripts

PewterGymBrockPostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, PewterGymResetScripts
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BROCK_REMATCH
	; block to check if with this we defeated all gym rematches
	; if yes, let's set one single event that will make League scripts so much nicer
	; in every gym we can skip the check corresponding to the gym itself
    CheckEvent EVENT_BEAT_MISTY_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_LT_SURGE_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_ERIKA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_KOGA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_SABRINA_REMATCH
    jr z, .notAllRematchWons
    CheckEvent EVENT_BEAT_BLAINE_REMATCH
    jr z, .notAllRematchWons
    SetEvent EVENT_BEAT_ALL_GYMS_REMATCH
.notAllRematchWons
	jp PewterGymResetScripts

PewterGym_TextPointers:
	dw BrockText
	dw PewterGymTrainerText1
	dw PewterGymTrainerText2
	dw PewterGymGuideText
	dw BeforeReceivedTM34Text
	dw ReceivedTM34Text
	dw TM34NoRoomText
	dw BrockPostRematchText; new, $8

PewterGymTrainerHeaders:
	def_trainers 2
PewterGymTrainerHeader0:
	trainer EVENT_BEAT_PEWTER_GYM_TRAINER_0, 5, PewterGymBattleText1, PewterGymEndBattleText1, PewterGymAfterBattleText1
PewterGymTrainerHeader1:
	trainer EVENT_BEAT_PEWTER_GYM_TRAINER_1, 5, PewterGymBattleText2, PewterGymEndBattleText2, PewterGymAfterBattleText2
	db -1 ; end

BrockText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_BROCK
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM34
	jr nz, .afterBeat
	call z, PewterGymScriptReceiveTM34
	call DisableWaitingAfterTextDisplay
	jr .done
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld hl, BrockRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_BROCK
	ld [wCurOpponent], a
	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, BrockRematchDefeatedText
	ld de, BrockRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
	jr .done
; back to vanilla code

.afterBeat
	ld hl, BrockPostBattleAdviceText
	call PrintText
	jr .done
.beforeBeat
	ld hl, BrockPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, ReceivedBoulderBadgeText
	ld de, ReceivedBoulderBadgeText
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
	ld a, $1
	ld [wGymLeaderNo], a
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

BrockPreBattleText:
	text_far _BrockPreBattleText
	text_end

BrockPostBattleAdviceText:
	text_far _BrockPostBattleAdviceText
	text_end

BeforeReceivedTM34Text:
	text_far _BeforeReceivedTM34Text
	text_end

ReceivedTM34Text:
	text_far _ReceivedTM34Text
	sound_get_item_1
	text_far _TM34ExplanationText
	text_end

TM34NoRoomText:
	text_far _TM34NoRoomText
	text_end

ReceivedBoulderBadgeText:
	text_far _ReceivedBoulderBadgeText
	sound_get_item_1
	text_far _BrockBoulerBadgeInfoText ; Text to tell that the flash technique can be used
	text_end

PewterGymTrainerText1:
	text_asm
	ld hl, PewterGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

PewterGymBattleText1:
	text_far _PewterGymBattleText1
	text_end

PewterGymEndBattleText1:
	text_far _PewterGymEndBattleText1
	text_end

PewterGymAfterBattleText1:
	text_far _PewterGymAfterBattleText1
	text_end

PewterGymTrainerText2:
	text_asm
	ld hl, PewterGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

PewterGymBattleText2:
	text_far _PewterGymBattleText2
	text_end

PewterGymEndBattleText2:
	text_far _PewterGymEndBattleText2
	text_end

PewterGymAfterBattleText2:
	text_far _PewterGymAfterBattleText2
	text_end

PewterGymGuideText:
	text_asm
	ld a, [wBeatGymFlags]
	bit BIT_BOULDERBADGE, a
	jr nz, .afterBeat
	ld hl, PewterGymGuidePreAdviceText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .PewterGymGuideBeginAdviceText
	ld a, [wd472]
	bit 7, a
	jp nz, .asm_5c3fa
	ld hl, PewterGymGuideBeginAdviceText
	call PrintText
	jr .PewterGymGuideAdviceText
.PewterGymGuideBeginAdviceText
	ld hl, PewterGymText_5c524
	call PrintText
.PewterGymGuideAdviceText
	ld hl, PewterGymGuideAdviceText
	call PrintText
	jr .done
.afterBeat
	ld hl, PewterGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd
.asm_5c3fa
	ld hl, PewterGymText_5c41c
	call PrintText
	jp TextScriptEnd

PewterGymGuidePreAdviceText:
	text_far _PewterGymGuidePreAdviceText
	text_end

PewterGymGuideBeginAdviceText:
	text_far _PewterGymGuideBeginAdviceText
	text_end

PewterGymGuideAdviceText:
	text_far _PewterGymGuideAdviceText
	text_end

PewterGymText_5c524:
	text_far _PewterGymText_5c524
	text_end

PewterGymGuidePostBattleText:
	text_far _PewterGymGuidePostBattleText
	text_end

PewterGymText_5c41c:
	text_far _PewterGymGuyText
	text_end

; new ---------------------

BrockRematchPreBattleText:
	text_far _BrockRematchPreBattleText
	text_end

BrockRematchDefeatedText:
	text_far _BrockRematchDefeatedText
	text_end

BrockPostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
