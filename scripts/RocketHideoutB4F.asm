RocketHideoutB4F_Script:
	RPTextChooser RocketHideoutB4F_TextPointers, RocketHideoutB4F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, RocketHideout4TrainerHeaders
	ld de, RocketHideoutB4F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

RocketHideout4Script_HandleRivalAndResetScript:
	ld a, HS_ROCKET_HIDEOUT_B4F_BLUE
	call RocketHideout4Script_HideObject
	jr RocketHideout4Script_ResetScripts
RocketHideout4Script_HandleJessieJamesAndResetScript:
	CheckAndResetEvent EVENT_ENGAGED_JESSIE_JAMES_GAME_CORNER
	call nz, RocketHideout4Script_HideJessieAndJames
RocketHideout4Script_ResetScripts:
	xor a
	ld [wJoyIgnore], a
RocketHideout4Script_ChangeScript:
	ld [wCurMapScript], a
	ret

RocketHideout4Script_HideJessieAndJames:
	ld a, HS_ROCKET_HIDEOUT_B4F_JAMES
	call RocketHideout4Script_HideObject
	ld a, HS_ROCKET_HIDEOUT_B4F_JESSIE
	call RocketHideout4Script_HideObject
	ret

RocketHideoutB4F_ScriptPointers:
	dw RocketHideout4Script0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw RocketHideout4Script3
	dw RocketHideout4Script4
	dw RocketHideout4Script5
	dw RocketHideout4Script6
	dw RocketHideout4Script7
	dw RocketHideout4Script8
	dw RocketHideout4Script9
	dw RocketHideout4Script10
	dw RocketHideout4Script11
	dw RocketHideout4Script12
	dw RocketHideout4Script13
	; new for RP
	dw RocketHideout4Script14
	dw RocketHideout4Script15
	dw RocketHideout4Script16

RocketHideout4Script3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, RocketHideout4Script_HandleJessieJamesAndResetScript
	; no need of any shenanigans to go beyond 200, right?
	ld a, $fc
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROCKET_HIDEOUT_GIOVANNI
	ld a, 10 ; post-battle Giovanni
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
	ld a, HS_ROCKET_HIDEOUT_B4F_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObject
	call RocketHidoutHideRockets ; new, function to loop-y hide all Rocket grunts in the hideout
	ld a, HS_ROCKET_HIDEOUT_B4F_ITEM_3 ; Scope
	ld [wMissableObjectIndex], a
	predef ShowObject
	call UpdateSprites
	call GBFadeInFromBlack
	xor a
	ld [wJoyIgnore], a
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ld a, $0
	ld [wCurMapScript], a
	ret

RocketHideout4Script0:
IF DEF(_DEBUG)
	call DebugPressedOrHeldB
	ret nz
ENDC
	CheckEvent EVENT_RP_BEAT_ROCKET_HIDEOUT_4_RIVAL ; new
	call z, RocketHideout4Script_CheckForRival ; new
	CheckEvent EVENT_BEAT_ROCKET_HIDEOUT_4_JESSIE_JAMES
	call z, RocketHideout4Script_CheckForJessieAndJames
	CheckEvent EVENT_BEAT_ROCKET_HIDEOUT_4_TRAINER_2
	call z, CheckFightingMapTrainers
	ret

RocketHideout4Script_CheckForJessieAndJames:
	ld a, [wYCoord]
	cp 14
	ret nz
	ResetEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
	ld a, [wXCoord]
	cp 24
	jr z, .rightCoordinates
	ld a, [wXCoord]
	cp 25
	ret nz
	SetEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
.rightCoordinates
	xor a
	ldh [hJoyHeld], a
	ld a, $fc
	ld [wJoyIgnore], a
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	call UpdateSprites
	call Delay3
	call UpdateSprites
	call Delay3
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, 11 ; not another step
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, HS_ROCKET_HIDEOUT_B4F_JAMES
	call RocketHideout4Script_ShowObject
	ld a, HS_ROCKET_HIDEOUT_B4F_JESSIE
	call RocketHideout4Script_ShowObject
	ld a, 4
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4JessieJamesMovementData_45605:
	db $4
RocketHideout4JessieJamesMovementData_45606:
	db $4
	db $4
	db $4
	db $ff

RocketHideout4Script4:
	ld de, RocketHideout4JessieJamesMovementData_45605
	CheckEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
	jr z, .asm_45617
	ld de, RocketHideout4JessieJamesMovementData_45606
.asm_45617
	ld a, $2
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, $5
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script5:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
RocketHideout4Script6:
	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite02StateData1FacingDirection], a
	CheckEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
	jr z, .asm_4564a
	ld a, SPRITE_FACING_DOWN
	ld [wSprite02StateData1FacingDirection], a
.asm_4564a
	call Delay3
	ld a, $fc
	ld [wJoyIgnore], a
RocketHideout4Script7:
	ld de, RocketHideout4JessieJamesMovementData_45606
	CheckEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
	jr z, .asm_4565f
	ld de, RocketHideout4JessieJamesMovementData_45605
.asm_4565f
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, 8
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script8:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, $fc
	ld [wJoyIgnore], a
RocketHideout4Script9:
	ld a, $2
	ld [wSprite03StateData1MovementStatus], a
	ld a, SPRITE_FACING_DOWN
	ld [wSprite03StateData1FacingDirection], a
	CheckEvent EVENT_ROCKET_HIDEOUT_4_JESSIE_JAMES_ON_LEFT
	jr z, .asm_45697
	ld a, SPRITE_FACING_RIGHT
	ld [wSprite03StateData1FacingDirection], a
.asm_45697
	call Delay3
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
RocketHideout4Script10:
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, RocketHideout4JessieJamesEndBattleText
	ld de, RocketHideout4JessieJamesEndBattleText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, OPP_JESSIEJAMES ; edited
	ld [wCurOpponent], a
	ld a, 2 ; edited
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	SetEvent EVENT_ENGAGED_JESSIE_JAMES_GAME_CORNER
	ld a, 11
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script11:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wIsInBattle]
	cp $ff
	jp z, RocketHideout4Script_HandleJessieJamesAndResetScript
; we won
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld [wSprite03StateData1MovementStatus], a
	xor a
	ld [wSprite02StateData1FacingDirection], a
	ld [wSprite03StateData1FacingDirection], a
	ld a, $fc
	ld [wJoyIgnore], a
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call StopAllMusic
	ld c, BANK(Music_MeetJessieJames)
	ld a, MUSIC_MEET_JESSIE_JAMES
	call PlayMusic
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, 12
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script12:
	ld a, $ff
	ld [wJoyIgnore], a
	call GBFadeOutToBlack
	ld a, HS_ROCKET_HIDEOUT_B4F_JAMES
	call RocketHideout4Script_HideObject
	ld a, HS_ROCKET_HIDEOUT_B4F_JESSIE
	call RocketHideout4Script_HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ld a, 13
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script13:
	call PlayDefaultMusic
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_ROCKET_HIDEOUT_4_JESSIE_JAMES
	ld a, 0
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script_ShowObject:
	ld [wMissableObjectIndex], a
	predef ShowObject
	call UpdateSprites
	call Delay3
	ret

RocketHideout4Script_HideObject:
	ld [wMissableObjectIndex], a
	predef HideObject
	ret

; texts ======================================================

RocketHideoutB4F_TextPointers:
	dw RocketHideout4Text0
	dw RocketHideout4Text1
	dw RocketHideout4Text2
	dw RocketHideout4Text3
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText ; 8
	dw RocketHideout4TextBlue ; 9 useless in non-RP
	; scripts
	dw RocketHideout4Text10 ; 10
	dw RocketHideout4Text11 ; 11
	dw RocketHideout4Text12 ; 12
	dw RocketHideout4Text13 ; 13

RocketHideoutB4F_TextPointers_Rocket:
	dw RocketHideout4Text0_RP ; Giovanni
	dw RocketHideout4Text1 ; James
	dw RocketHideout4Text2 ; Jessie
	dw RocketHideout4Text3
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText ; 8
	dw RocketHideout4TextBlue ; 9
	; scripts
	dw RocketHideout4Text10 ; 10 ; useless for RP
	dw RocketHideout4Text11 ; 11
	dw RocketHideout4Text12 ; 12
	dw RocketHideout4Text13 ; 13
	; RP-only
	dw RocketHideout4Text14 ; 14
	dw RocketHideout4Text15 ; 15
	dw RocketHideout4Text16 ; 16

RocketHideout4TrainerHeaders:
	def_trainers 4
RocketHideout4TrainerHeader0:
	trainer EVENT_BEAT_ROCKET_HIDEOUT_4_TRAINER_2, 1, RocketHideout4Trainer0BeforeText, RocketHideout4Trainer0EndBattleText, RocketHideout4Trainer0AfterText
	db -1 ; end

RocketHideout4Text1:
RocketHideout4Text2:
RocketHideout4TextBlue: ; useless per se
	text_end

RocketHideout4Text11:
	text_far _RocketHideoutJessieJamesText1
	text_asm
	ld c, 10
	call DelayFrames
	ld a, $8
	ld [wPlayerMovingDirection], a
	ld a, $0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	jp TextScriptEnd

RocketHideout4Text12:
	text_far _RocketHideoutJessieJamesText2
	text_end

RocketHideout4JessieJamesEndBattleText:
	text_far _RocketHideoutJessieJamesText3
	text_end

RocketHideout4Text13: ; edited
	text_asm
	CheckEvent EVENT_ROCKET_PATH
	ld hl, RocketHideoutJessieJamesText4
	jr z, .printText
	ld hl, RocketHideoutJessieJamesText4_RP
.printText
	call PrintText
	ld c, 64
	call DelayFrames
	jp TextScriptEnd

RocketHideoutJessieJamesText4: ; edited
	text_far _RocketHideoutJessieJamesText4
	text_end

RocketHideoutJessieJamesText4_RP: ; new
	text_far _RocketHideoutJessieJamesText4_RP
	text_end

RocketHideout4Text0:
	text_asm
	CheckEvent EVENT_BEAT_ROCKET_HIDEOUT_GIOVANNI
	jp nz, .asm_457fb
	ld hl, RocketHideout4Text_45804
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, RocketHideout4Text_45809
	ld de, RocketHideout4Text_45809
	call SaveEndBattleTextPointers
	ldh a, [hSpriteIndex]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	xor a
	ldh [hJoyHeld], a
	ld a, $3
	ld [wCurMapScript], a
	jr .asm_45801
.asm_457fb
	ld hl, RocketHideout4Text10
	call PrintText
.asm_45801
	jp TextScriptEnd

RocketHideout4Text_45804:
	text_far _RocketHideout4Text_4557a
	text_end

RocketHideout4Text_45809:
	text_far _RocketHideout4Text_4557f
	text_end

RocketHideout4Text10:
	text_far _RocketHideout4Text_GiovanniPostBattle
	text_end

RocketHideout4Text3:
	text_asm
	ld hl, RocketHideout4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

RocketHideout4Trainer0BeforeText:
	text_far _RocketHideout4BattleText4
	text_end

RocketHideout4Trainer0EndBattleText:
	text_far _RocketHideout4EndBattleText4
	text_promptbutton
	text_asm
	SetEvent EVENT_ROCKET_DROPPED_LIFT_KEY
	ld a, HS_ROCKET_HIDEOUT_B4F_ITEM_4
	ld [wMissableObjectIndex], a
	predef ShowObject
	jp TextScriptEnd

RocketHideout4Trainer0AfterText:
	text_asm
	ld hl, RocketHideout4Text_45844
	call PrintText
	jp TextScriptEnd

RocketHideout4Text_45844:
	text_far _RocketHideout4Text_455ec
	text_end

; new

RocketHidoutHideRockets:
	ld hl, RocketHideoutRockets
.hideLoop
	ld a, [hli]
	cp $ff ; have we run out of rockets to hide?
	ret z ; if so, we're done
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .hideLoop

RocketHideoutRockets:
	db HS_ROCKET_HIDEOUT_B1F_TRAINER_1
	db HS_ROCKET_HIDEOUT_B1F_TRAINER_2
	db HS_ROCKET_HIDEOUT_B1F_TRAINER_3
	db HS_ROCKET_HIDEOUT_B1F_TRAINER_4
	db HS_ROCKET_HIDEOUT_B1F_TRAINER_5
	db HS_ROCKET_HIDEOUT_B2F_TRAINER_1
	db HS_ROCKET_HIDEOUT_B3F_TRAINER_1
	db HS_ROCKET_HIDEOUT_B3F_TRAINER_2
	db HS_ROCKET_HIDEOUT_B4F_TRAINER_4
	db HS_CELADON_ROCKET_1
	db HS_CELADON_ROCKET_2
	db $ff

; new for RP ===================================================

RocketHideout4Text0_RP:
	text_asm
	CheckEvent EVENT_RP_RECEIVED_SILPH_SCOPE
	ld hl, RocketHideout4Text0_RP_GoToTowerSummary
	jr nz, .printAndEnd
; first time we speak with Giovanni?
	CheckEvent EVENT_RP_SPOKEN_WITH_GAME_CORNER_GIOVANNI
	jr nz, .giveScope ; not first time, it means the bag was full, just try to give again the Scope
; actual first time we speak
	SetEvent EVENT_RP_SPOKEN_WITH_GAME_CORNER_GIOVANNI
	ld hl, RocketHideout4Text0_RP_WelcomeNewbie
	call PrintText
.giveScope
	ld hl, RocketHideout4Text0_RP_TakeScope
	call PrintText
	lb bc, SILPH_SCOPE, 1
	call GiveItem
	jr nc, .bagFull
; actually getting the Scope
	SetEvent EVENT_RP_RECEIVED_SILPH_SCOPE
	ld hl, RocketHideout4Text0_RP_GotScope
	call PrintText
	ld hl, RocketHideout4Text0_RP_GoToTower
	call PrintText
	jp TextScriptEnd
.bagFull
	ld hl, RocketHideout4Text0_RP_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

RocketHideout4Text0_RP_GoToTowerSummary:
	text_far _RocketHideout4Text0_RP_GoToTowerSummary
	text_end

RocketHideout4Text0_RP_WelcomeNewbie:
	text_far _RocketHideout4Text0_RP_WelcomeNewbie
	text_end

RocketHideout4Text0_RP_TakeScope:
	text_far _RocketHideout4Text0_RP_TakeScope
	text_end

RocketHideout4Text0_RP_BagFull:
	text_far _RocketHideout4Text0_RP_BagFull
	text_end

RocketHideout4Text0_RP_GotScope:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

RocketHideout4Text0_RP_GoToTower:
	text_far _RocketHideout4Text0_RP_GoToTower
	text_end

RocketHideout4Script_CheckForRival:
	CheckEvent EVENT_ROCKET_PATH
	ret z
	ld a, [wYCoord]
	cp 5
	ret nz
	ld a, [wXCoord]
	cp 23
	ret nz
; dialogue and show Blue
	xor a
	ldh [hJoyHeld], a
	ld a, $fc
	ld [wJoyIgnore], a
; music
	call StopAllMusic
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	call UpdateSprites
	call Delay3
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, HS_ROCKET_HIDEOUT_B4F_BLUE
	call RocketHideout4Script_ShowObject
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 14
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4Script14:
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld de, RocketHideout4BlueMovementData
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, 15
	call RocketHideout4Script_ChangeScript
	ret

RocketHideout4BlueMovementData:
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db $ff

RocketHideout4Script15:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, [wd730]
	bit 0, a
	ret nz
; facing
	ld a, 9
	ld [wSprite03StateData1MovementStatus], a
	ld a, SPRITE_FACING_UP
	ld [wSprite03StateData1FacingDirection], a
	call Delay3
	ld a, $fc
	ld [wJoyIgnore], a
; dialogue
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; prepare battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, RocketHideout4RivalEndBattleText_Victory ; text if player wins
	ld de, RocketHideout4RivalEndBattleText_Defeat ; text if player loses
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld [wJoyIgnore], a
	ld a, 16
	jp RocketHideout4Script_ChangeScript

RocketHideout4Script16:
	ld a, [wIsInBattle]
	cp $ff
	jp z, RocketHideout4Script_HandleRivalAndResetScript
; we won
	ld a, SPRITE_FACING_UP
	ld [wSprite09StateData1FacingDirection], a
	xor a
	ld [wIsTrainerBattle], a
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_RP_BEAT_ROCKET_HIDEOUT_4_RIVAL
; dialogue
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; disappear
	call GBFadeOutToBlack
	ld a, HS_ROCKET_HIDEOUT_B4F_BLUE
	call RocketHideout4Script_HideObject
	call UpdateSprites
	call GBFadeInFromBlack
	jp RocketHideout4Script_HandleRivalAndResetScript

RocketHideout4Text14:
	text_far _RocketHideout4Text14
	text_end

RocketHideout4Text15:
	text_far _RocketHideout4Text15
	text_end

RocketHideout4RivalEndBattleText_Victory:
	text_far _RocketHideout4RivalEndBattleText_Victory
	text_end

RocketHideout4RivalEndBattleText_Defeat:
	text_far _RocketHideout4RivalEndBattleText_Defeat
	text_end

RocketHideout4Text16:
	text_far _RocketHideout4Text16
	text_end
