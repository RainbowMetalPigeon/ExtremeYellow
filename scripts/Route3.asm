Route3_Script:
	RPTextChooser Route3_TextPointers, Route3_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, Route3TrainerHeaders
	ld de, Route3_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Route3_ScriptPointers:
	dw Route3_Script0 ; new/edited for RP
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route3_Script3 ; new for RP
	dw Route3_Script4 ; new for RP
	dw Route3_Script5 ; new for RP

Route3_TextPointers:
	dw Route3Text1
	dw Route3Text2
	dw Route3Text3
	dw Route3Text4
	dw Route3Text5
	dw Route3Text6
	dw Route3Text7
	dw Route3Text8
	dw Route3Text9
	dw Route3TextJenny ; new
	; signs
	dw Route3Text10

Route3_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw Route3Text2
	dw Route3Text3
	dw Route3Text4
	dw Route3Text5
	dw Route3Text6
	dw Route3Text7
	dw Route3Text8
	dw Route3Text9
	dw Route3TextJenny_RP ; 10
	; signs
	dw Route3Text10 ; 11
	; scripts
	dw Route3TextScript1 ; 12
	dw Route3TextScript2 ; 13

Route3TrainerHeaders:
	def_trainers 2
Route3TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_0, 2, Route3BattleText1, Route3EndBattleText1, Route3AfterBattleText1
Route3TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_1, 3, Route3BattleText2, Route3EndBattleText2, Route3AfterBattleText2
Route3TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_2, 5, Route3BattleText3, Route3EndBattleText3, Route3AfterBattleText3 ; edited sight range
Route3TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_3, 1, Route3BattleText4, Route3EndBattleText4, Route3AfterBattleText4
Route3TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_4, 4, Route3BattleText5, Route3EndBattleText5, Route3AfterBattleText5
Route3TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_5, 4, Route3BattleText6, Route3EndBattleText6, Route3AfterBattleText6
Route3TrainerHeader6:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_6, 3, Route3BattleText7, Route3EndBattleText7, Route3AfterBattleText7
Route3TrainerHeader7:
	trainer EVENT_BEAT_ROUTE_3_TRAINER_7, 3, Route3BattleText8, Route3EndBattleText8, Route3AfterBattleText8
	db -1 ; end

Route3Text1:
	text_far _Route3Text1
	text_end

Route3Text2:
	text_asm
	ld hl, Route3TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText1:
	text_far _Route3BattleText1
	text_end

Route3EndBattleText1:
	text_far _Route3EndBattleText1
	text_end

Route3AfterBattleText1:
	text_far _Route3AfterBattleText1
	text_end

Route3Text3:
	text_asm
	ld hl, Route3TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText2:
	text_far _Route3BattleText2
	text_end

Route3EndBattleText2:
	text_far _Route3EndBattleText2
	text_end

Route3AfterBattleText2:
	text_far _Route3AfterBattleText2
	text_end

Route3Text4:
	text_asm
	ld hl, Route3TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText3:
	text_far _Route3BattleText3
	text_end

Route3EndBattleText3:
	text_far _Route3EndBattleText3
	text_end

Route3AfterBattleText3:
	text_far _Route3AfterBattleText3
	text_end

Route3Text5:
	text_asm
	ld hl, Route3TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText4:
	text_far _Route3BattleText4
	text_end

Route3EndBattleText4:
	text_far _Route3EndBattleText4
	text_end

Route3AfterBattleText4:
	text_far _Route3AfterBattleText4
	text_end

Route3Text6:
	text_asm
	ld hl, Route3TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText5:
	text_far _Route3BattleText5
	text_end

Route3EndBattleText5:
	text_far _Route3EndBattleText5
	text_end

Route3AfterBattleText5:
	text_far _Route3AfterBattleText5
	text_end

Route3Text7:
	text_asm
	ld hl, Route3TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText6:
	text_far _Route3BattleText6
	text_end

Route3EndBattleText6:
	text_far _Route3EndBattleText6
	text_end

Route3AfterBattleText6:
	text_far _Route3AfterBattleText6
	text_end

Route3Text8:
	text_asm
	ld hl, Route3TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText7:
	text_far _Route3BattleText7
	text_end

Route3EndBattleText7:
	text_far _Route3EndBattleText7
	text_end

Route3AfterBattleText7:
	text_far _Route3AfterBattleText7
	text_end

Route3Text9:
	text_asm
	ld hl, Route3TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route3BattleText8:
	text_far _Route3BattleText8
	text_end

Route3EndBattleText8:
	text_far _Route3EndBattleText8
	text_end

Route3AfterBattleText8:
	text_far _Route3AfterBattleText8
	text_end

Route3Text10:
	text_far _Route3Text10
	text_end

Route3TextJenny:
	text_far _Route3TextJenny
	text_end

; new for RP =======================

Route3_Script0:
	CheckEvent EVENT_ROCKET_PATH
	jp z, CheckFightingMapTrainers
; rocket path; did we defeat Route 3 Jenny?
	CheckEvent EVENT_RP_BEAT_ROUTE_3_JENNY
	jp nz, CheckFightingMapTrainers
; Jenny not defeated yet; are we at the right coordinates?
	ld hl, CoordsData_Route3NearJenny
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
; in sight; change music, bubble, dialogue, and choose Jenny movements
; start music
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
; bubble
	ld a, 10
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; change Jenny facing
	call TurnJenny_Conditional
; Jenny dialogue
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; choose movement
	ld a, [wYCoord]
	cp 12
	jr z, .jennyOneStepUp
	cp 17
	jr z, .jennyThreeStepsDown
; Jenny just turns up, we're done here
	ld a, 4
	jr .loadNextScript
.jennyOneStepUp
	ld de, Route3JennyMovementsUp
	jr .moveJenny
.jennyThreeStepsDown
	ld de, Route3JennyMovementsDown
.moveJenny
	ld a, 10
	ldh [hSpriteIndex], a
	call MoveSprite ; hSpriteIndex already set
	ld a, 3
.loadNextScript
	ld [wCurMapScript], a
	ret

Route3JennyMovementsUp:
	db NPC_MOVEMENT_UP
	db -1 ; end

Route3JennyMovementsDown:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

TurnJenny_Conditional:
	ld a, [wYCoord]
	cp 17
	jr nz, TurnJennyUp
	; fallthrough
TurnJennyDown:
	ld a, 10
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
;
	lb de, 10, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing ; new Pigeon approach
;
	ld a, 10
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	call ChangeSpriteMovementBytes ; new from Engeze
;
	ret

TurnJennyUp: ; TBE?
	ld a, 10
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_UP
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
;
	lb de, 10, SPRITE_FACING_UP
	callfar ChangeSpriteFacing ; new Pigeon approach
;
	ld a, 10
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
;
	ret

CoordsData_Route3NearJenny:
	dbmapcoord 31, 12
	dbmapcoord 31, 13
	dbmapcoord 31, 17
	db -1 ; end

Route3_Script3:
; wait for Jenny to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
	call TurnJenny_Conditional
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

Route3_Script4:
	call TurnJenny_Conditional
; dialogue Jenny
	xor a
	ld [wJoyIgnore], a
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_JENNY
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, Route3JennyDefeatedText
	ld de, Route3JennyDefeatedText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 5
	ld [wCurMapScript], a
	ret

Route3_Script5:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Route3ResetScripts
; we won
	SetEvent EVENT_RP_BEAT_ROUTE_3_JENNY
	ld a, $f0
	ld [wJoyIgnore], a
	call TurnJenny_Conditional
; Jenny dialogue
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Jenny
	call GBFadeOutToBlack
	ld a, HS_ROUTE_3_JENNY
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; fallthrough

Route3ResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

Route3TextJenny_RP:
	text_far _Route3TextJenny_RP
	text_end

Route3JennyDefeatedText:
	text_far _Route3JennyDefeatedText
	text_end

Route3TextScript1:
	text_far _Route3TextScript1
	text_end

Route3TextScript2:
	text_far _Route3TextScript2
	text_end
