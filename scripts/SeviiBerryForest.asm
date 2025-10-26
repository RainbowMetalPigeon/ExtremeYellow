SeviiBerryForest_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiBerryForest_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SeviiBerryForest_ScriptPointers:
	dw SeviiBerryForest_0 ; 0
	dw SeviiBerryForest_1 ; 1
	dw SeviiBerryForest_2 ; 2
	dw SeviiBerryForest_3 ; 3
	dw SeviiBerryForest_4 ; 4

SeviiBerryForest_0:
	CheckEvent EVENT_SEVII_RESCUED_MAYOI
	ret nz
	ld hl, SeviiBerryForest_Coordinates_OrmMayoiScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
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

SeviiBerryForest_1:
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
	cp 6 ; upper tile
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

SeviiBerryForest_2:
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

SeviiBerryForest_3:
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

SeviiBerryForest_4:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiBerryForestResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
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

SeviiBerryForestText1:
	text_far _SeviiBerryForestText1
	text_end

SeviiBerryForestText2:
	text_far _SeviiBerryForestText2
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
