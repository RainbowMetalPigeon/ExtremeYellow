SeviiBerryForest_Script:
	RPTextChooser SeviiBerryForest_TextPointers, SeviiBerryForest_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SeviiBerryForest_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SeviiBerryForest_ScriptPointers:
	dw SeviiBerryForest_Script0
	dw SeviiBerryForest_Script1
	dw SeviiBerryForest_Script2
	dw SeviiBerryForest_Script3
	dw SeviiBerryForest_Script4
	; new for RP
	dw SeviiBerryForest_Script5
	dw SeviiBerryForest_Script6
	dw SeviiBerryForest_Script7
	dw SeviiBerryForest_Script8
	dw SeviiBerryForest_Script9
	dw SeviiBerryForest_Script10

SeviiBerryForest_Script0:
	CheckEvent EVENT_SEVII_RESCUED_MAYOI
	ret nz
	ld hl, SeviiBerryForest_Coordinates_OrmMayoiScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; Rocket Path?
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
; Rocket Path indeed
	ld a, 6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 5
	ld [wCurMapScript], a
	ret
.notRP
	ld a, 6
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; exclamation bubble, turn Orm, change music, second dialogue
	ld a, 1
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
; load next script
	ld a, 1
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Coordinates_OrmMayoiScene:
	dbmapcoord  9,  6
	dbmapcoord  9,  7
	db -1 ; end

SeviiBerryForest_Script1:
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; determine which movement to apply depending on player's position
	ld a, [wYCoord]
	cp 6 ; upper cell
	ld de, OrmIfPlayerUpMovements
	jr z, .playerOnLeftSide
	ld de, OrmIfPlayerDownMovements
.playerOnLeftSide
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

OrmIfPlayerDownMovements:
	db NPC_MOVEMENT_RIGHT
OrmIfPlayerUpMovements:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

SeviiBerryForest_Script2:
; wait for Orm to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Orm if needed
	ld a, [wYCoord]
	cp 7 ; lower tile
	lb bc, STAY, RIGHT
	ld a, 1
	ldh [hSpriteIndex], a
	jr nz, .noTurnOrm
; turn player and Orm
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	lb bc, STAY, DOWN
.noTurnOrm
	call ChangeSpriteMovementBytes ; new from Engeze
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Script3:
	ld a, $0
	ld [wJoyIgnore], a
; Orm last pre-battle dialogue and start battle
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID ; SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ORM
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiBerryForestOrmDefeatText
	ld de, SeviiBerryForestOrmDefeatText
	call SaveEndBattleTextPointers
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Script4:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiBerryForestResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; warp player back to Celio's house
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_ONE_ISLAND_HOUSES ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, SEVII_ONE_ISLAND_CITY
	ld [wLastMap], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
; hide/show sprites
	ld a, HS_SEVII_BERRY_FOREST_ORM
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_BERRY_FOREST_MAYOI
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_BEFORE_RESCUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ONE_ISLAND_HOUSES_MAYOI_RIGHT_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii

	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_RIGHT_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii

	SetEvent EVENT_SEVII_RESCUED_MAYOI
	call SeviiBerryForestResetScripts
	ret

SeviiBerryForestResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiBerryForest_TextPointers:
	dw SeviiBerryForestText1 ; 1 Carr
	dw SeviiBerryForestText2 ; 2 Mayoi
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	; scripts
	dw SeviiBerryForestScriptText1 ; 6 ; pre-battle dialogue 1
	dw SeviiBerryForestScriptText2 ; 7 ; pre-battle dialogue 2
	dw SeviiBerryForestScriptText3 ; 8 ; pre-battle dialogue 3
	dw SeviiBerryForestScriptText4 ; 9 ; post-battle dialogue

SeviiBerryForest_TextPointers_Rocket:
	dw SeviiBerryForestText1_RP ; 1 Carr
	dw SeviiBerryForestText2_RP ; 2 Mayoi
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	; scripts
	dw SeviiBerryForestScriptText1_RP ; 6
	dw SeviiBerryForestScriptText2_RP ; 7
	dw SeviiBerryForestScriptText3_RP ; 8
	dw SeviiBerryForestScriptText4_RP ; 9
	dw SeviiBerryForestScriptText5_RP ; 10
	dw SeviiBerryForestScriptText6_RP ; 11

SeviiBerryForestText1:
SeviiBerryForestText2:
	text_far _SeviiBerryForestText1
	text_end

SeviiBerryForestScriptText1:
	text_far _SeviiBerryForestScriptText1
	text_end

SeviiBerryForestScriptText2:
	text_far _SeviiBerryForestScriptText2
	text_end

SeviiBerryForestScriptText3:
	text_far _SeviiBerryForestScriptText3
	text_end

SeviiBerryForestScriptText4:
	text_far _SeviiBerryForestScriptText4
	text_end

SeviiBerryForestOrmDefeatText:
	text_far _SeviiBerryForestOrmDefeatText
	text_end

; new for RP ============================================

SeviiBerryForest_Script5:
; move player to Orm - choose which movement to apply
	ld a, [wYCoord]
	cp 6 ; upper cell
	ld de, SeviiBerryForestApproach_RLEMovement_Up
	jr z, .playerOnLeftSide
	ld de, SeviiBerryForestApproach_RLEMovement_Down
.playerOnLeftSide
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

SeviiBerryForestApproach_RLEMovement_Up:
	db D_LEFT, 1
	db D_LEFT, 1
	db -1 ; end

SeviiBerryForestApproach_RLEMovement_Down:
	db D_LEFT, 1
	db D_LEFT, 1
	db D_UP, 1
	db -1 ; end

SeviiBerryForest_Script6:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; movement finished
	call Delay3
	xor a
	ld [wJoyIgnore], a
; turn Orm and Mayoi
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, 2
	lb de, 2, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
; dialogue Orm
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; dialogue Blue
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	ld a, 7
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Script7:
; turn Player, Orm, and Mayoi
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
	lb de, 2, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
; exclamation mark
	ld a, 0
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; show Blue
	ld a, HS_SEVII_BERRY_FOREST_BLUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; start music
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
; move Blue
	ld a, 5
	ldh [hSpriteIndex], a
	ld de, SeviiBerryForestBlueMovements
	call MoveSprite
; load next script
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiBerryForestBlueMovements:
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db -1 ; end

SeviiBerryForest_Script8:
; wait for Blue to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; dialogue Blue, Mayoi, Orm, Blue
	xor a
	ld [wJoyIgnore], a
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld a, 5
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiBerryForestBlueDefeatText
	ld de, SeviiBerryForestBlueWonText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	lb de, 5, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
; load next script
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Script9:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiBerryForestResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	lb de, 5, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
	SetEvent EVENT_SEVII_RESCUED_MAYOI ; abused (very much so lol)
; Blue dialogue
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Blue and swap the Celios
	call GBFadeOutToBlack
	ld a, HS_SEVII_BERRY_FOREST_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_BEFORE_RESCUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_RIGHT_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_PINKS_DAD
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
; load next script
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiBerryForest_Script10:
; turn player and Orm
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 1, SPRITE_FACING_RIGHT
	callfar ChangeSpriteFacing ; new Pigeon approach
; Orm dialogue
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jp SeviiBerryForestResetScripts

SeviiBerryForestScriptText1_RP:
	text_far _SeviiBerryForestScriptText1_RP
	text_end

SeviiBerryForestScriptText2_RP:
	text_far _SeviiBerryForestScriptText2_RP
	text_end

SeviiBerryForestScriptText3_RP:
	text_far _SeviiBerryForestScriptText3_RP
	text_end

SeviiBerryForestScriptText4_RP:
	text_far _SeviiBerryForestScriptText4_RP
	text_end

SeviiBerryForestBlueDefeatText:
	text_far _SeviiBerryForestBlueDefeatText
	text_end

SeviiBerryForestBlueWonText:
	text_far _SeviiBerryForestBlueWonText
	text_end

SeviiBerryForestScriptText5_RP:
	text_far _SeviiBerryForestScriptText5_RP
	text_end

SeviiBerryForestScriptText6_RP:
	text_far _SeviiBerryForestScriptText6_RP
	text_end

SeviiBerryForestText1_RP:
	text_far _SeviiBerryForestText1_RP
	text_end

SeviiBerryForestText2_RP:
	text_far _SeviiBerryForestText2_RP
	text_end
