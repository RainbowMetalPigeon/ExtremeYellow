MtMoon1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MtMoon1TrainerHeaders
	ld de, MtMoon1F_ScriptPointers
	ld a, [wMtMoon1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMtMoon1FCurScript], a
	ret

MtMoon1F_ScriptPointers:
	dw MtMoon1Script0 ; new
;	dw CheckFightingMapTrainers ; edited, commented out
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw MtMoon1Script3 ; new
	dw MtMoon1Script4 ; new
	dw MtMoon1Script5 ; new

; -------------------------------

MtMoon1Script0: ; new
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	ret nz
ENDC
	CheckEvent EVENT_BEAT_MT_MOON_1_RIVAL
	jp nz, CheckFightingMapTrainers
	ld hl, MtMoon1FCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	call StopAllMusic
.walking
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a

	ld a, HS_MT_MOON_1F_RIVAL
	ld [wMissableObjectIndex], a
	predef ShowObject

	ld a, [wXCoord]
	cp 36 ; is the player standing on the left of the post-water corridor?
	jr z, .playerOnLeftSideOfCorridor
	ld de, MtMoon1FMovements1_Right
	jr .continue
.playerOnLeftSideOfCorridor
	ld de, MtMoon1FMovements1
.continue
	ld a, 14 ; index of Rival's sprite
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $3 ; testing
	ld [wMtMoon1FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoon1FCoords:
	dbmapcoord 36, 28
	dbmapcoord 37, 28
	db -1 ; end

MtMoon1FMovements1_Right:
	db NPC_MOVEMENT_RIGHT
MtMoon1FMovements1:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

; -------------------------------

MtMoon1Script3: ; new
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, 14 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, MtMoon1FRivalText_Win ; text if player wins
	ld de, MtMoon1FRivalText_Lose ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, 6
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	call MtMoon1FScript_RivalFacingDown
	ld a, 4
	ld [wMtMoon1FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoon1FRivalText_Win:
	text_far _MtMoon1FRivalText_Win
	text_end

MtMoon1FRivalText_Lose:
	text_far _MtMoon1FRivalText_Lose
	text_end

MtMoon1FScript_RivalFacingDown:
	ld a, 14
	ldh [hSpriteIndex], a
	xor a ; SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay ; face object

; -------------------------------

MtMoon1Script4: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, MtMoon1FScript_ResetIfLoseVsRival
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	call MtMoon1FScript_RivalFacingDown
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_MT_MOON_1_RIVAL
	ld a, 14 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 14 ; Rival's text (and sprite) index
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld de, MtMoon1FMovements2
	ld a, 14 ; Rival's text (and sprite) index
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $5
	ld [wMtMoon1FCurScript], a
	ld [wCurMapScript], a
	ret

MtMoon1FScript_ResetIfLoseVsRival:
	xor a
	ld [wJoyIgnore], a
	ld [wMtMoon1FCurScript], a
	ld [wCurMapScript], a
	ld a, HS_MT_MOON_1F_RIVAL
	ld [wMissableObjectIndex], a
	predef_jump HideObject

MtMoon1FMovements2:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; -------------------------------

MtMoon1Script5: ; new
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_MT_MOON_1F_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	ld a, $0
	ld [wMtMoon1FCurScript], a
	ld [wCurMapScript], a
	ret

; ===============================

MtMoon1F_TextPointers:
	dw MtMoon1Text1
	dw MtMoon1Text2
	dw MtMoon1Text3
	dw MtMoon1Text4
	dw MtMoon1Text5
	dw MtMoon1Text6
	dw MtMoon1Text7
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw MtMoon1TextRival ; new, 14
	dw MtMoon1Text14 ; 15

MtMoon1TrainerHeaders:
	def_trainers
MtMoon1TrainerHeader0:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_0, 4, MtMoon1BattleText2, MtMoon1EndBattleText2, MtMoon1AfterBattleText2
MtMoon1TrainerHeader1:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_1, 3, MtMoon1BattleText3, MtMoon1EndBattleText3, MtMoon1AfterBattleText3
MtMoon1TrainerHeader2:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_2, 3, MtMoon1BattleText4, MtMoon1EndBattleText4, MtMoon1AfterBattleText4
MtMoon1TrainerHeader3:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_3, 3, MtMoon1BattleText5, MtMoon1EndBattleText5, MtMoon1AfterBattleText5
MtMoon1TrainerHeader4:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_4, 3, MtMoon1BattleText6, MtMoon1EndBattleText6, MtMoon1AfterBattleText6
MtMoon1TrainerHeader5:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_5, 3, MtMoon1BattleText7, MtMoon1EndBattleText7, MtMoon1AfterBattleText7
MtMoon1TrainerHeader6:
	trainer EVENT_BEAT_MT_MOON_1_TRAINER_6, 3, MtMoon1BattleText8, MtMoon1EndBattleText8, MtMoon1AfterBattleText8
	db -1 ; end

; -------------------------------

MtMoon1TextRival: ; new
	text_asm
	CheckEvent EVENT_BEAT_MT_MOON_1_RIVAL
	jr z, .PreBattleText
	ld hl, MtMoon1FRivalText_PostBattle
	call PrintText
	jr .end
.PreBattleText
	ld hl, MtMoon1FRivalText_PreBattle
	call PrintText
.end
	jp TextScriptEnd

MtMoon1FRivalText_PreBattle:
	text_far _MtMoon1FRivalText_PreBattle
	text_end

MtMoon1FRivalText_PostBattle:
	text_far _MtMoon1FRivalText_PostBattle
	text_end

; -------------------------------

MtMoon1Text1:
	text_asm
	ld hl, MtMoon1TrainerHeader0
	jr MtMoon1TalkToTrainer

MtMoon1Text2:
	text_asm
	ld hl, MtMoon1TrainerHeader1
	jr MtMoon1TalkToTrainer

MtMoon1Text3:
	text_asm
	ld hl, MtMoon1TrainerHeader2
	jr MtMoon1TalkToTrainer

MtMoon1Text4:
	text_asm
	ld hl, MtMoon1TrainerHeader3
	jr MtMoon1TalkToTrainer

MtMoon1Text5:
	text_asm
	ld hl, MtMoon1TrainerHeader4
	jr MtMoon1TalkToTrainer

MtMoon1Text6:
	text_asm
	ld hl, MtMoon1TrainerHeader5
	jr MtMoon1TalkToTrainer

MtMoon1Text7:
	text_asm
	ld hl, MtMoon1TrainerHeader6
MtMoon1TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

MtMoon1BattleText2:
	text_far _MtMoon1BattleText2
	text_end

MtMoon1EndBattleText2:
	text_far _MtMoon1EndBattleText2
	text_end

MtMoon1AfterBattleText2: ; edited
	text_asm
	ld hl, MtMoon1AfterBattleText2_BeforeYesNo
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, MtMoon1AfterBattleText2_NoAdvice
	jr nz, .printAndEnd
	ld hl, MtMoon1AfterBattleText2_YesAdvice
.printAndEnd
	call PrintText
	jp TextScriptEnd

MtMoon1AfterBattleText2_BeforeYesNo: ; new
	text_far _MtMoon1AfterBattleText2_BeforeYesNo
	text_end

MtMoon1AfterBattleText2_NoAdvice: ; new
	text_far _MtMoon1AfterBattleText2_NoAdvice
	text_end

MtMoon1AfterBattleText2_YesAdvice: ; new
	text_far _MtMoon1AfterBattleText2_YesAdvice
	text_end

MtMoon1BattleText3:
	text_far _MtMoon1BattleText3
	text_end

MtMoon1EndBattleText3:
	text_far _MtMoon1EndBattleText3
	text_end

MtMoon1AfterBattleText3:
	text_far _MtMoon1AfterBattleText3
	text_end

MtMoon1BattleText4:
	text_far _MtMoon1BattleText4
	text_end

MtMoon1EndBattleText4:
	text_far _MtMoon1EndBattleText4
	text_end

MtMoon1AfterBattleText4:
	text_far _MtMoon1AfterBattleText4
	text_end

MtMoon1BattleText5:
	text_far _MtMoon1BattleText5
	text_end

MtMoon1EndBattleText5:
	text_far _MtMoon1EndBattleText5
	text_end

MtMoon1AfterBattleText5:
	text_far _MtMoon1AfterBattleText5
	text_end

MtMoon1BattleText6:
	text_far _MtMoon1BattleText6
	text_end

MtMoon1EndBattleText6:
	text_far _MtMoon1EndBattleText6
	text_end

MtMoon1AfterBattleText6:
	text_far _MtMoon1AfterBattleText6
	text_end

MtMoon1BattleText7:
	text_far _MtMoon1BattleText7
	text_end

MtMoon1EndBattleText7:
	text_far _MtMoon1EndBattleText7
	text_end

MtMoon1AfterBattleText7:
	text_far _MtMoon1AfterBattleText7
	text_end

MtMoon1BattleText8:
	text_far _MtMoon1BattleText8
	text_end

MtMoon1EndBattleText8:
	text_far _MtMoon1EndBattleText8
	text_end

MtMoon1AfterBattleText8:
	text_far _MtMoon1AfterBattleText8
	text_end

MtMoon1Text14:
	text_far _MtMoon1Text14
	text_end
