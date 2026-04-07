ViridianGym_Script:
	ld hl, .CityName
	ld de, .LeaderName
	call LoadGymLeaderAndCityName
	call EnableAutoTextBoxDrawing
	ld hl, ViridianGymTrainerHeaders
	ld de, ViridianGym_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

.CityName:
	db "VIRIDIAN CITY@"

.LeaderName:
	db "GIOVANNI@"

ViridianGymResetScriptsAfterLosingAsInterimLeaders:
	ld a, HS_VIRIDIAN_GYM_CHALLENGER
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	xor a
	ld [wViridianGymChallengerAttempt], a
	; fallthrough
ViridianGymResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

ViridianGym_ScriptPointers:
	dw ViridianGymScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw ViridianGymGiovanniPostBattle
	dw ViridianGymScript4
	; new
	dw ViridianGymScriptMovePlayerIntoPosition ; 5
	dw ViridianGymScriptWaitForAndTurnPlayer ; 6
	dw ViridianGymScriptMovePikachu ; 7
	dw ViridianGymScriptMoveChallenger ; 8
	dw ViridianGymScriptStartBattleVsChallenger ; 9
	dw ViridianGymScriptPostBattleVsChallenger ; 10
	dw ViridianGymScriptWaitForChallengerToGoAway ; 11

ViridianGymScript0:
	ld a, [wYCoord]
	ld b, a
	ld a, [wXCoord]
	ld c, a
	ld hl, ViridianGymArrowTilePlayerMovement
	call DecodeArrowMovementRLE
	cp $ff
	jp z, CheckFightingMapTrainers
	call StartSimulatingJoypadStates
	ld hl, wd736
	set 7, [hl]
	ld a, SFX_ARROW_TILES
	call PlaySound
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $4
	ld [wCurMapScript], a
	ret

ViridianGymArrowTilePlayerMovement:
	map_coord_movement 19, 11, ViridianGymArrowMovement1
	map_coord_movement 19,  1, ViridianGymArrowMovement2
	map_coord_movement 18,  2, ViridianGymArrowMovement3
	map_coord_movement 11,  2, ViridianGymArrowMovement4
	map_coord_movement 16, 10, ViridianGymArrowMovement5
	map_coord_movement  4,  6, ViridianGymArrowMovement6
	map_coord_movement  5, 13, ViridianGymArrowMovement7
	map_coord_movement  4, 14, ViridianGymArrowMovement8
	map_coord_movement  0, 15, ViridianGymArrowMovement9
	map_coord_movement  1, 15, ViridianGymArrowMovement10
	map_coord_movement 13, 16, ViridianGymArrowMovement11
	map_coord_movement 13, 17, ViridianGymArrowMovement12
	db -1 ; end

ViridianGymArrowMovement1:
	db D_UP, 9
	db -1 ; end

ViridianGymArrowMovement2:
	db D_LEFT, 8
	db -1 ; end

ViridianGymArrowMovement3:
	db D_DOWN, 9
	db -1 ; end

ViridianGymArrowMovement4:
	db D_RIGHT, 6
	db -1 ; end

ViridianGymArrowMovement5:
	db D_DOWN, 2
	db -1 ; end

ViridianGymArrowMovement6:
	db D_DOWN, 7
	db -1 ; end

ViridianGymArrowMovement7:
	db D_RIGHT, 8
	db -1 ; end

ViridianGymArrowMovement8:
	db D_RIGHT, 9
	db -1 ; end

ViridianGymArrowMovement9:
	db D_UP, 8
	db -1 ; end

ViridianGymArrowMovement10:
	db D_UP, 6
	db -1 ; end

ViridianGymArrowMovement11:
	db D_LEFT, 6
	db -1 ; end

ViridianGymArrowMovement12:
	db D_LEFT, 12
	db -1 ; end

ViridianGymScript4:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	jr nz, .ViridianGymLoadSpinnerArrow
	xor a
	ld [wJoyIgnore], a
	ld hl, wd736
	res 7, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret
.ViridianGymLoadSpinnerArrow
	farjp LoadSpinnerArrowTiles

ViridianGymGiovanniPostBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, ViridianGymResetScripts
	ld a, $f0
	ld [wJoyIgnore], a

	ld a, 15 ; ViridianGymGiovanniPostBattleText
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID

	SetEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI

	ld hl, wObtainedBadges
	set BIT_EARTHBADGE, [hl]
	ld hl, wBeatGymFlags
	set BIT_EARTHBADGE, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_VIRIDIAN_GYM_TRAINER_1, EVENT_BEAT_VIRIDIAN_GYM_TRAINER_8 ; edited

	call GBFadeOutToBlack
	ld a, HS_VIRIDIAN_GYM_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_VIRIDIAN_GYM_ITEM_2 ; new, show TM_FISSURE
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack

	jp ViridianGymResetScripts

; new scripts --------------------------------------------

ViridianGymScriptMovePlayerIntoPosition:
; determine which movement list to select
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_RIGHT ; no need to move the player
	jr z, .noNeedToMovePlayer
	cp SPRITE_FACING_LEFT
	ld de, ViridianGym_RLEMovement_PlayerRightOfGuide
	jr z, .playerMovementsGot
	ld de, ViridianGym_RLEMovement_PlayerDownOfGuide
.playerMovementsGot
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 6
	ld [wCurMapScript], a
	ret
.noNeedToMovePlayer
	ld a, 7
	ld [wCurMapScript], a
	ret

ViridianGym_RLEMovement_PlayerRightOfGuide:
	db D_UP, 1
	db D_LEFT, 1
	db D_LEFT, 1
	db D_DOWN, 1
	db -1 ; end

ViridianGym_RLEMovement_PlayerDownOfGuide:
	db D_UP, 1
	db D_LEFT, 1
	db -1

ViridianGymScriptWaitForAndTurnPlayer:
; wait for player to finish moving
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
; player finished moving
; load next script
	ld a, 7
	ld [wCurMapScript], a
	ret

ViridianGymScriptMovePikachu:
; turn player and guide
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	lb bc, STAY, DOWN
	ld a, 11
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes
; do we need to move Pikachu?
	callfar ViridianGymPikachuMovementScript
; load next script
	ld a, 8
	ld [wCurMapScript], a
	ret

ViridianGymScriptMoveChallenger:
	ld a, HS_VIRIDIAN_GYM_CHALLENGER
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; challenger moves
	ld de, ViridianGymChallengerMovementsIn
	ld a, 12
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 9
	ld [wCurMapScript], a
	ret

ViridianGymChallengerMovementsIn:
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db -1 ; end

ViridianGymScriptStartBattleVsChallenger:
; wait for challenger to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; dialogue and battle
	xor a
	ld [wJoyIgnore], a
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; challenger battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_CHALLENGER
	ld [wCurOpponent], a
	ld a, [wViridianGymChallengerAttempt]
	inc a
	ld [wTrainerNo], a
; should we set (bad) luck?
	cp 6
	jr nz, .noBadLuck
	ld a, [wLuckAccuracy]
	ld [wArrayForTemporaryStorage], a
	ld a, [wLuckRoll]
	ld [wArrayForTemporaryStorage+1], a
	ld a, [wLuckCrit]
	ld [wArrayForTemporaryStorage+2], a
	ld a, [wLuckSecondaryEffects]
	ld [wArrayForTemporaryStorage+3], a
	ld a, [wLuckStatusesAffliction]
	ld [wArrayForTemporaryStorage+4], a
	ld a, 3
	ld [wLuckAccuracy], a
	ld [wLuckRoll], a
	ld [wLuckCrit], a
	ld [wLuckSecondaryEffects], a
	ld [wLuckStatusesAffliction], a
.noBadLuck
; normal stuff
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, ViridianGymChallengerDefeatedText ; TBE?
	ld de, ViridianGymChallengerDefeatedText ; TBE?
	call SaveEndBattleTextPointers
; fix challenger facing
	lb bc, STAY, UP
	ld a, 12
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes ; Engeze approach
	lb de, 12, SPRITE_FACING_UP
	callfar ChangeSpriteFacing ; Pigeon approach
; load next script
	ld a, 10
	ld [wCurMapScript], a
	ret

ViridianGymScriptPostBattleVsChallenger:
; should we reset luck? if we need to do, it's regardless of win/lose
	ld a, [wViridianGymChallengerAttempt]
	cp 5
	jr nz, .noResetLuck
	ld a, [wArrayForTemporaryStorage]
	ld [wLuckAccuracy], a
	ld a, [wArrayForTemporaryStorage+1]
	ld [wLuckRoll], a
	ld a, [wArrayForTemporaryStorage+2]
	ld [wLuckCrit], a
	ld a, [wArrayForTemporaryStorage+3]
	ld [wLuckSecondaryEffects], a
	ld a, [wArrayForTemporaryStorage+4]
	ld [wLuckStatusesAffliction], a
.noResetLuck
; did we lose?
	ld a, [wIsInBattle]
	cp $ff
	jp z, ViridianGymResetScriptsAfterLosingAsInterimLeaders
; we won
; fix challenger facing
	lb bc, STAY, UP
	ld a, 12
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes ; Engeze approach
	lb de, 12, SPRITE_FACING_UP
	callfar ChangeSpriteFacing ; Pigeon approach
; handle attempt counter
	ld a, [wViridianGymChallengerAttempt]
	cp 5
	jr nc, .doNotIncreaseChallengerAttempt
	inc a
	ld [wViridianGymChallengerAttempt], a
.doNotIncreaseChallengerAttempt
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; challenger moves away
	ld de, ViridianGymChallengerMovementsOut
	ld a, 12
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 11
	ld [wCurMapScript], a
	ret

ViridianGymChallengerMovementsOut:
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_DOWN
	db -1 ; end

ViridianGymScriptWaitForChallengerToGoAway:
; wait for challenger to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; hide challenger
	ld a, HS_VIRIDIAN_GYM_CHALLENGER
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
; reset scripts
	jp ViridianGymResetScripts

; texts ==================================================

ViridianGym_TextPointers:
	dw GiovanniText
	; trainers
	dw ViridianGymTrainerText2
	dw ViridianGymTrainerText3
	dw ViridianGymTrainerText4
	dw ViridianGymTrainerText5
	dw ViridianGymTrainerText6
	dw ViridianGymTrainerText7
	dw ViridianGymTrainerText8
	dw ViridianGymTrainerText9 ; 9
	; guides
	dw ViridianGymGuideText_PreLeague ; $a=10
	dw ViridianGymGuideText_PostLeague ; $b=11
	dw ViridianGymChallengerText ; $c=12
	dw PickUpItemText ; $d=13
	dw PickUpItemText ; new, $e=14
	; scripts
	dw ViridianGymGiovanniPostBattleText ; $d=15
	dw ViridianGymChallengerPreBattleText ; 16
	dw ViridianGymChallengerPostBattleText ; 17

ViridianGymTrainerHeaders:
	def_trainers 2
;ViridianGymTrainerHeader0:
;	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_0, 4, ViridianGymBattleText1, ViridianGymEndBattleText1, ViridianGymAfterBattleText1
ViridianGymTrainerHeader1:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_1, 4, ViridianGymBattleText2, ViridianGymEndBattleText2, ViridianGymAfterBattleText2
ViridianGymTrainerHeader2:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_2, 1, ViridianGymBattleText3, ViridianGymEndBattleText3, ViridianGymAfterBattleText3
ViridianGymTrainerHeader3:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_3, 2, ViridianGymBattleText4, ViridianGymEndBattleText4, ViridianGymAfterBattleText4
ViridianGymTrainerHeader4:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_4, 3, ViridianGymBattleText5, ViridianGymEndBattleText5, ViridianGymAfterBattleText5
ViridianGymTrainerHeader5:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_5, 4, ViridianGymBattleText6, ViridianGymEndBattleText6, ViridianGymAfterBattleText6
ViridianGymTrainerHeader6:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_6, 3, ViridianGymBattleText7, ViridianGymEndBattleText7, ViridianGymAfterBattleText7
ViridianGymTrainerHeader7:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_7, 4, ViridianGymBattleText8, ViridianGymEndBattleText8, ViridianGymAfterBattleText8
ViridianGymTrainerHeader8:
	trainer EVENT_BEAT_VIRIDIAN_GYM_TRAINER_8, 3, ViridianGymBattleText9, ViridianGymEndBattleText9, ViridianGymAfterBattleText9
	db -1 ; end

GiovanniText: ; edited
	text_asm
	ld hl, GiovanniPreBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, GiovanniPostDefeatText
	ld de, GiovanniPostDefeatText
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $8
	ld [wGymLeaderNo], a
	ld a, $3
	ld [wCurMapScript], a ; edited
	jp TextScriptEnd

GiovanniPreBattleText:
	text_far _GiovanniPreBattleText
	text_end

GiovanniPostDefeatText:
	text_far _GiovanniPostDefeatText
	text_end

ViridianGymGiovanniPostBattleText:
	text_far _ViridianGymGiovanniPostBattleText
	text_end

ViridianGymTrainerText2:
	text_asm
	ld hl, ViridianGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText2:
	text_far _ViridianGymBattleText2
	text_end

ViridianGymEndBattleText2:
	text_far _ViridianGymEndBattleText2
	text_end

ViridianGymAfterBattleText2:
	text_far _ViridianGymAfterBattleText2
	text_end

ViridianGymTrainerText3:
	text_asm
	ld hl, ViridianGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText3:
	text_far _ViridianGymBattleText3
	text_end

ViridianGymEndBattleText3:
	text_far _ViridianGymEndBattleText3
	text_end

ViridianGymAfterBattleText3:
	text_far _ViridianGymAfterBattleText3
	text_end

ViridianGymTrainerText4:
	text_asm
	ld hl, ViridianGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText4:
	text_far _ViridianGymBattleText4
	text_end

ViridianGymEndBattleText4:
	text_far _ViridianGymEndBattleText4
	text_end

ViridianGymAfterBattleText4:
	text_far _ViridianGymAfterBattleText4
	text_end

ViridianGymTrainerText5:
	text_asm
	ld hl, ViridianGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText5:
	text_far _ViridianGymBattleText5
	text_end

ViridianGymEndBattleText5:
	text_far _ViridianGymEndBattleText5
	text_end

ViridianGymAfterBattleText5:
	text_far _ViridianGymAfterBattleText5
	text_end

ViridianGymTrainerText6:
	text_asm
	ld hl, ViridianGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText6:
	text_far _ViridianGymBattleText6
	text_end

ViridianGymEndBattleText6:
	text_far _ViridianGymEndBattleText6
	text_end

ViridianGymAfterBattleText6:
	text_far _ViridianGymAfterBattleText6
	text_end

ViridianGymTrainerText7:
	text_asm
	ld hl, ViridianGymTrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText7:
	text_far _ViridianGymBattleText7
	text_end

ViridianGymEndBattleText7:
	text_far _ViridianGymEndBattleText7
	text_end

ViridianGymAfterBattleText7:
	text_far _ViridianGymAfterBattleText7
	text_end

ViridianGymTrainerText8:
	text_asm
	ld hl, ViridianGymTrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText8:
	text_far _ViridianGymBattleText8
	text_end

ViridianGymEndBattleText8:
	text_far _ViridianGymEndBattleText8
	text_end

ViridianGymAfterBattleText8:
	text_far _ViridianGymAfterBattleText8
	text_end

ViridianGymTrainerText9:
	text_asm
	ld hl, ViridianGymTrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

ViridianGymBattleText9:
	text_far _ViridianGymBattleText9
	text_end

ViridianGymEndBattleText9:
	text_far _ViridianGymEndBattleText9
	text_end

ViridianGymAfterBattleText9:
	text_far _ViridianGymAfterBattleText9
	text_end

ViridianGymGuideText_PreLeague:
	text_asm
	CheckEvent EVENT_BEAT_VIRIDIAN_GYM_GIOVANNI
	jr nz, .afterBeat
	ld hl, ViridianGymGuidePreBattleText
	call PrintText
	jr .done
.afterBeat
	ld hl, ViridianGymGuidePostBattleText
	call PrintText
.done
	jp TextScriptEnd

ViridianGymGuidePreBattleText:
	text_far _ViridianGymGuidePreBattleText
	text_end

ViridianGymGuidePostBattleText:
	text_far _ViridianGymGuidePostBattleText
	text_end

; new ====================================================

ViridianGymChallengerText:
	text_far _ViridianGymChallengerText
	text_end

ViridianGymGuideText_PostLeague:
	text_asm
	ld hl, ViridianGymGuideText_PostLeague_Intro
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
	ld hl, ViridianGymGuideText_PostLeague_WhenReady
	jr .printAndEnd
.yesBattle
	ld hl, ViridianGymGuideText_PostLeague_AmazingLetsGo
	ld a, 5
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianGymGuideText_PostLeague_Intro:
	text_far _ViridianGymGuideText_PostLeague_Intro
	text_end

ViridianGymGuideText_PostLeague_WhenReady:
	text_far _ViridianGymGuideText_PostLeague_WhenReady
	text_end

ViridianGymGuideText_PostLeague_AmazingLetsGo:
	text_far _ViridianGymGuideText_PostLeague_AmazingLetsGo
	text_end

; -------------------

ViridianGymChallengerPreBattleText:
	text_asm
	ld a, [wViridianGymChallengerAttempt]
	and a ; =0?
	ld hl, ViridianGymChallengerPreBattleText_0
	jr z, .printAndEnd
	dec a ; =1?
	ld hl, ViridianGymChallengerPreBattleText_1
	jr z, .printAndEnd
	dec a ; =2?
	ld hl, ViridianGymChallengerPreBattleText_2
	jr z, .printAndEnd
	dec a ; =3?
	ld hl, ViridianGymChallengerPreBattleText_3
	jr z, .printAndEnd
	dec a ; =4?
	ld hl, ViridianGymChallengerPreBattleText_4
	jr z, .printAndEnd
	ld hl, ViridianGymChallengerPreBattleText_5
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianGymChallengerPreBattleText_0:
	text_far _ViridianGymChallengerPreBattleText_0
	text_end

ViridianGymChallengerPreBattleText_1:
	text_far _ViridianGymChallengerPreBattleText_1
	text_end

ViridianGymChallengerPreBattleText_2:
	text_far _ViridianGymChallengerPreBattleText_2
	text_end

ViridianGymChallengerPreBattleText_3:
	text_far _ViridianGymChallengerPreBattleText_3
	text_end

ViridianGymChallengerPreBattleText_4:
	text_far _ViridianGymChallengerPreBattleText_4
	text_end

ViridianGymChallengerPreBattleText_5:
	text_far _ViridianGymChallengerPreBattleText_5
	text_end

ViridianGymChallengerPostBattleText:
	text_asm
	ld a, [wViridianGymChallengerAttempt]
	and a ; =0?
	ld hl, ViridianGymChallengerPostBattleText_0
	jr z, .printAndEnd
	dec a ; =1?
	ld hl, ViridianGymChallengerPostBattleText_1
	jr z, .printAndEnd
	dec a ; =2?
	ld hl, ViridianGymChallengerPostBattleText_2
	jr z, .printAndEnd
	dec a ; =3?
	ld hl, ViridianGymChallengerPostBattleText_3
	jr z, .printAndEnd
	dec a ; =4?
	ld hl, ViridianGymChallengerPostBattleText_4
	jr z, .printAndEnd
	ld hl, ViridianGymChallengerPostBattleText_5
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianGymChallengerPostBattleText_0:
	text_far _ViridianGymChallengerPostBattleText_0
	text_end

ViridianGymChallengerPostBattleText_1:
	text_far _ViridianGymChallengerPostBattleText_1
	text_end

ViridianGymChallengerPostBattleText_2:
	text_far _ViridianGymChallengerPostBattleText_2
	text_end

ViridianGymChallengerPostBattleText_3:
	text_far _ViridianGymChallengerPostBattleText_3
	text_end

ViridianGymChallengerPostBattleText_4:
	text_far _ViridianGymChallengerPostBattleText_4
	text_end

ViridianGymChallengerPostBattleText_5:
	text_far _ViridianGymChallengerPostBattleText_5
	text_end

ViridianGymChallengerDefeatedText:
	text_far _ViridianGymChallengerDefeatedText
	text_end
