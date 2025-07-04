CinnabarGym_Script:
	call CinnabarGymSetMapAndTiles
	call EnableAutoTextBoxDrawing
	ld hl, CinnabarGym_ScriptPointers
	ld a, [wCurMapScript] ; edited
	jp CallFunctionInTable

CinnabarGymSetMapAndTiles:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	push hl
	call nz, .LoadNames
	pop hl
	bit 5, [hl]
	res 5, [hl]
	call nz, UpdateCinnabarGymGateTileBlocks
;	ResetEvent EVENT_2A7 ; edited because useless?
	ret

.LoadNames:
	ld hl, .CityName
	ld de, .LeaderName
	jp LoadGymLeaderAndCityName

.CityName:
	db "CINNABAR ISLAND@"

.LeaderName:
	db "BLAINE@"

CinnabarGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ld [wOpponentAfterWrongAnswer], a
	ret

CinnabarGymSetTrainerHeader:
	ldh a, [hSpriteIndexOrTextID]
	ld [wTrainerHeaderFlagBit], a
	ret

CinnabarGymFlagAction:
	predef_jump FlagActionPredef

CinnabarGym_ScriptPointers:
	dw CinnabarGymScript0
	dw CinnabarGymScript1
	dw CinnabarGymScript2
	dw CinnabarGymBlainePostBattle
	dw CinnabarGymBlainePostBattleRematch ; new

CinnabarGymScript0:
	ld a, [wOpponentAfterWrongAnswer]
	and a
	ret z
	ldh [hSpriteIndex], a
	cp $4
	jr nz, .asm_757c3
	ld a, PLAYER_DIR_DOWN
	ld [wPlayerMovingDirection], a
	ld hl, PikachuMovementData_74f97
	ld b, SPRITE_FACING_DOWN
	call CinnabarGymScript_74fa3
	ld de, MovementNpcToLeftAndUp
	jr .MoveSprite
.asm_757c3
	ld a, PLAYER_DIR_RIGHT
	ld [wPlayerMovingDirection], a
	ld hl, PikachuMovementData_74f9e
	ld b, SPRITE_FACING_RIGHT
	call CinnabarGymScript_74fa3
	ld de, MovementNpcToLeft
.MoveSprite
	call MoveSprite
	ld a, $1
	ld [wCurMapScript], a
	ret

MovementNpcToLeftAndUp:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_UP
	db -1 ; end

PikachuMovementData_74f97:
	db $00
	db $20
	db $1e
	db $35
	db $3f

MovementNpcToLeft:
	db NPC_MOVEMENT_LEFT
	db -1 ; end

PikachuMovementData_74f9e:
	db $00
	db $1d
	db $1f
	db $38
	db $3f

CinnabarGymScript_74fa3:
	ld a, [wd472]
	bit 7, a
	ret z
	push hl
	push bc
	callfar GetPikachuFacingDirectionAndReturnToE
	pop bc
	pop hl
	ld a, b
	cp e
	ret nz
	call ApplyPikachuMovementData
	ret

CinnabarGymScript1:
	ld a, [wd730]
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, [wOpponentAfterWrongAnswer]
	ld [wTrainerHeaderFlagBit], a
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

CinnabarGymScript2:
	call CinnabarGymScript_753e9
	ld a, [wIsInBattle]
	cp $ff
	jp z, CinnabarGymResetScripts
	ld a, [wTrainerHeaderFlagBit]
	sub $2
	ld c, a
	ld b, FLAG_TEST
	EventFlagAddress hl, EVENT_CINNABAR_GYM_GATE0_UNLOCKED
	call CinnabarGymFlagAction
	ld a, c
	and a
	jr nz, .asm_7500d
	ld a, [wTrainerHeaderFlagBit]
	cp 2
	jr z, .asm_7500d
	ld c, 30
	call DelayFrames
	call CinnabarGymScript_75023
	call CinnabarGymScript_75041
	call WaitForSoundToFinish
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
	jr .asm_75013
.asm_7500d
	call CinnabarGymScript_75023
	call CinnabarGymScript_75041
.asm_75013
	xor a
	ld [wJoyIgnore], a
	ld [wOpponentAfterWrongAnswer], a
	ld a, $0
	ld [wCurMapScript], a
	ret

CinnabarGymScript_75023:
	ld a, [wTrainerHeaderFlagBit]
	ldh [hGymGateIndex], a
	ld c, a
	ld b, FLAG_SET
	EventFlagAddress hl, EVENT_BEAT_CINNABAR_GYM_TRAINER_0
	call CinnabarGymFlagAction
	ret

CinnabarGymScript_75032:
	ld a, [wTrainerHeaderFlagBit]
	ldh [hGymGateIndex], a
	ld c, a
	ld b, FLAG_TEST
	EventFlagAddress hl, EVENT_BEAT_CINNABAR_GYM_TRAINER_0
	call CinnabarGymFlagAction
	ret

CinnabarGymScript_75041:
	ld a, [wTrainerHeaderFlagBit]
	sub 2
	ld c, a
	ld b, FLAG_SET
	EventFlagAddress hl, EVENT_CINNABAR_GYM_GATE0_UNLOCKED
	call CinnabarGymFlagAction
	call UpdateCinnabarGymGateTileBlocks
	ret

CinnabarGymBlainePostBattle:
	call CinnabarGymScript_753e9
	ld a, [wIsInBattle]
	cp $ff
	jp z, CinnabarGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; fallthrough
CinnabarGymReceiveTM38:
	ld a, $a
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BLAINE
	lb bc, TM_FIRE_BLAST, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $b
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM38
	jr .gymVictory
.BagFull
	ld a, $c
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set BIT_VOLCANOBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_VOLCANOBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_CINNABAR_GYM_TRAINER_0, EVENT_BEAT_CINNABAR_GYM_TRAINER_6

	ld hl, wCurrentMapScriptFlags
	set 5, [hl]

	jp CinnabarGymResetScripts

CinnabarGymBlainePostBattleRematch: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, CinnabarGymResetScripts
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, $d
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BLAINE_REMATCH
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
    CheckEvent EVENT_BEAT_SABRINA_REMATCH
    jr z, .notAllRematchWons
    SetEvent EVENT_BEAT_ALL_GYMS_REMATCH
.notAllRematchWons
	jp CinnabarGymResetScripts

CinnabarGym_TextPointers:
	dw BlaineText
	dw CinnabarGymTrainerText1
	dw CinnabarGymTrainerText2
	dw CinnabarGymTrainerText3
	dw CinnabarGymTrainerText4
	dw CinnabarGymTrainerText5
	dw CinnabarGymTrainerText6
	dw CinnabarGymTrainerText7
	dw CinnabarGymGuideText
	dw BlaineVolcanoBadgeInfoText
	dw ReceivedTM38Text
	dw TM38NoRoomText
	dw BlainePostRematchText; new, $d

CinnabarGymScript_750c3:
	ldh a, [hSpriteIndexOrTextID]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld a, [wSpriteIndex]
	cp $1
	jr z, .asm_758d4
	ld a, $2
	jr .asm_758d6
.asm_758d4
; new, for the adaptive gym teams
	callfar CountHowManyBadges ; d=#badges
	ld a, d
	inc a
	ld [wTrainerNo], a
; back to vanilla
	ld a, $3
.asm_758d6
	ld [wCurMapScript], a
	jp TextScriptEnd

BlaineText:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE	; new
	jr nz, .postGameCode						; new
	CheckEvent EVENT_BEAT_BLAINE
	jr z, .beforeBeat
	CheckEventReuseA EVENT_GOT_TM38
	jr nz, .afterBeat
	call z, CinnabarGymReceiveTM38
	call DisableWaitingAfterTextDisplay
	jp TextScriptEnd
; new block of code for rematch
.postGameCode
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld hl, BlaineRematchPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_BLAINE
	ld [wCurOpponent], a
	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, BlaineRematchDefeatedText
	ld de, BlaineRematchDefeatedText
	call SaveEndBattleTextPointers
	ld a, $4 ; new script
	ld [wCurMapScript], a
	jp TextScriptEnd ; slightly different from other gyms' rematches and from the rest of Cinnabar Gym, but should do
; back to vanilla code

.afterBeat
	ld hl, BlainePostBattleAdviceText
	call PrintText
	jp TextScriptEnd
.beforeBeat
	ld hl, BlainePreBattleText
	call PrintText
	ld hl, ReceivedVolcanoBadgeText
	ld de, ReceivedVolcanoBadgeText
	call SaveEndBattleTextPointers
	ld a, $7
	ld [wGymLeaderNo], a
	jp CinnabarGymScript_750c3

BlainePreBattleText:
	text_far _BlainePreBattleText
	text_end

ReceivedVolcanoBadgeText:
	text_far _ReceivedVolcanoBadgeText
	sound_get_key_item ; actually plays the second channel of SFX_BALL_POOF due to the wrong music bank being loaded
	text_waitbutton
	text_end

BlainePostBattleAdviceText:
	text_far _BlainePostBattleAdviceText
	text_end

BlaineVolcanoBadgeInfoText:
	text_far _BlaineVolcanoBadgeInfoText
	text_end

ReceivedTM38Text:
	text_far _ReceivedTM38Text
	sound_get_item_1
	text_far _TM38ExplanationText
	text_end

TM38NoRoomText:
	text_far _TM38NoRoomText
	text_end

CinnabarGymTrainerText1:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_0
	jr nz, .asm_46bb4
	ld hl, CinnabarGymBattleText2
	call PrintText
	ld hl, CinnabarGymEndBattleText2
	ld de, CinnabarGymEndBattleText2
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.asm_46bb4
	ld hl, CinnabarGymAfterBattleText2
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText2:
	text_far _CinnabarGymBattleText2
	text_end

CinnabarGymEndBattleText2:
	text_far _CinnabarGymEndBattleText2
	text_end

CinnabarGymAfterBattleText2:
	text_far _CinnabarGymAfterBattleText2
	text_end

CinnabarGymTrainerText2:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_1
	jr nz, .asm_751a8
	call CinnabarGymScript_753f3
	jr nz, .asm_75196
	CheckEvent EVENT_CINNABAR_GYM_GATE1_UNLOCKED
	jr nz, .asm_75196
	ld e, $00
	jp CinnabarGymScript_753de

.asm_75196
	ld hl, CinnabarGymBattleText1
	call PrintText
	ld hl, CinnabarGymEndBattleText1
	ld de, CinnabarGymEndBattleText1
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3

.asm_751a8
	ld hl, CinnabarGymAfterBattleText1
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText1:
	text_far _CinnabarGymBattleText1
	text_end

CinnabarGymEndBattleText1:
	text_far _CinnabarGymEndBattleText1
	text_end

CinnabarGymAfterBattleText1:
	text_far _CinnabarGymAfterBattleText1
	text_end

CinnabarGymTrainerText3:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_2
	jr nz, .afterBeat
	call CinnabarGymScript_753f3
	jr nz, .asm_751dc
	CheckEvent EVENT_CINNABAR_GYM_GATE2_UNLOCKED
	jr nz, .asm_751dc
	ld e, $1
	jp CinnabarGymScript_753de

.asm_751dc
	ld hl, CinnabarGymBattleText3
	call PrintText
	ld hl, CinnabarGymEndBattleText3
	ld de, CinnabarGymEndBattleText3
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.afterBeat
	ld hl, CinnabarGymAfterBattleText3
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText3:
	text_far _CinnabarGymBattleText3
	text_end

CinnabarGymEndBattleText3:
	text_far _CinnabarGymEndBattleText3
	text_end

CinnabarGymAfterBattleText3:
	text_far _CinnabarGymAfterBattleText3
	text_end

CinnabarGymTrainerText4:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_3
	jr nz, .afterBeat
	call CinnabarGymScript_753f3
	jr nz, .asm_75222
	CheckEvent EVENT_CINNABAR_GYM_GATE3_UNLOCKED
	jr nz, .asm_75222
	ld e, $2
	jp CinnabarGymScript_753de

.asm_75222
	ld hl, CinnabarGymBattleText4
	call PrintText
	ld hl, CinnabarGymEndBattleText4
	ld de, CinnabarGymEndBattleText4
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.afterBeat
	ld hl, CinnabarGymAfterBattleText4
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText4:
	text_far _CinnabarGymBattleText4
	text_end

CinnabarGymEndBattleText4:
	text_far _CinnabarGymEndBattleText4
	text_end

CinnabarGymAfterBattleText4:
	text_far _CinnabarGymAfterBattleText4
	text_end

CinnabarGymTrainerText5:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_4
	jr nz, .afterBeat
	call CinnabarGymScript_753f3
	jr nz, .asm_75222
	CheckEvent EVENT_CINNABAR_GYM_GATE4_UNLOCKED
	jr nz, .asm_75222
	ld e, $3
	jp CinnabarGymScript_753de

.asm_75222
	ld hl, CinnabarGymBattleText5
	call PrintText
	ld hl, CinnabarGymEndBattleText5
	ld de, CinnabarGymEndBattleText5
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.afterBeat
	ld hl, CinnabarGymAfterBattleText5
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText5:
	text_far _CinnabarGymBattleText5
	text_end

CinnabarGymEndBattleText5:
	text_far _CinnabarGymEndBattleText5
	text_end

CinnabarGymAfterBattleText5:
	text_far _CinnabarGymAfterBattleText5
	text_end

CinnabarGymTrainerText6:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_5
	jr nz, .afterBeat
	call CinnabarGymScript_753f3
	jr nz, .asm_75222
	CheckEvent EVENT_CINNABAR_GYM_GATE5_UNLOCKED
	jr nz, .asm_75222
	ld e, $4
	jp CinnabarGymScript_753de

.asm_75222
	ld hl, CinnabarGymBattleText6
	call PrintText
	ld hl, CinnabarGymEndBattleText6
	ld de, CinnabarGymEndBattleText6
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.afterBeat
	ld hl, CinnabarGymAfterBattleText6
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText6:
	text_far _CinnabarGymBattleText6
	text_end

CinnabarGymEndBattleText6:
	text_far _CinnabarGymEndBattleText6
	text_end

CinnabarGymAfterBattleText6:
	text_far _CinnabarGymAfterBattleText6
	text_end

CinnabarGymTrainerText7:
	text_asm
	call CinnabarGymSetTrainerHeader
	CheckEvent EVENT_BEAT_CINNABAR_GYM_TRAINER_6
	jr nz, .afterBeat
	call CinnabarGymScript_753f3
	jr nz, .asm_75222
	CheckEvent EVENT_CINNABAR_GYM_GATE6_UNLOCKED
	jr nz, .asm_75222
	ld e, $5
	jp CinnabarGymScript_753de

.asm_75222
	ld hl, CinnabarGymBattleText7
	call PrintText
	ld hl, CinnabarGymEndBattleText7
	ld de, CinnabarGymEndBattleText7
	call SaveEndBattleTextPointers
	jp CinnabarGymScript_750c3
.afterBeat
	ld hl, CinnabarGymAfterBattleText7
	call PrintText
	jp TextScriptEnd

CinnabarGymBattleText7:
	text_far _CinnabarGymBattleText7
	text_end

CinnabarGymEndBattleText7:
	text_far _CinnabarGymEndBattleText7
	text_end

CinnabarGymAfterBattleText7:
	text_far _CinnabarGymAfterBattleText7
	text_end

CinnabarGymGuideText:
	text_asm
	callfar Func_f2133
	jp TextScriptEnd

; new ---------------------

BlaineRematchPreBattleText:
	text_far _BlaineRematchPreBattleText
	text_end

BlaineRematchDefeatedText:
	text_far _BlaineRematchDefeatedText
	text_end

BlainePostRematchText:
	text_far _GymLeaderPostRematchText
	text_end
