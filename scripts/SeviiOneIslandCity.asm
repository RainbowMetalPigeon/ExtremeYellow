SeviiOneIslandCity_Script:
	RPTextChooser SeviiOneIslandCity_TextPointers, SeviiOneIslandCity_TextPointers_Rocket
	call CheckForCeliosHouseHideShow
	call EnableAutoTextBoxDrawing
	ld de, SeviiOneIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

CheckForCeliosHouseHideShow:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_ROCKET_PATH
	ret nz
	CheckEvent EVENT_GOT_POKE_FLUTE
	ret z
	CheckEvent EVENT_SEVII_FINALIZED_HS_CELIO_HOUSE
	ret nz
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_MAYOI_RIGHT_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_RIGHT_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_MAYOI_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_CELIO_AFTER_RESCUE
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	SetEvent EVENT_SEVII_FINALIZED_HS_CELIO_HOUSE
	ret

SeviiOneIslandCity_ScriptPointers:
	dw SeviiOneIslandCityScript0
	dw SeviiOneIslandCityScript1
	dw SeviiOneIslandCityScript2
	dw SeviiOneIslandCityScript3
	; for RP
	dw SeviiOneIslandCityScript4
	dw SeviiOneIslandCityScript5
	dw SeviiOneIslandCityScript6
	dw SeviiOneIslandCityScript7
	dw SeviiOneIslandCityScript8
	dw SeviiOneIslandCityScript9
	dw SeviiOneIslandCityScript10

SeviiOneIslandCity_TextPointers:
	dw SeviiOneIslandCityText1 ; Celio
	dw SeviiOneIslandCityText2 ; Officer
	dw SeviiOneIslandCityText3
	dw SeviiOneIslandCityText4
	dw SeviiOneIslandCityText5
	dw SeviiOneIslandCityText6
	dw SeviiOneIslandCityText7
	dw SeviiOneIslandCityText8
	dw PickUpItemText ;  9
	dw PickUpItemText ; 10
	; signs
	dw SeviiOneIslandCitySignText1 ; 11
	dw SeviiOneIslandCitySignText2 ; 12
	dw SeviiOneIslandCitySignText3 ; 13
	dw SeviiOneIslandCitySignText4 ; 14
	dw SeviiOneIslandCitySignText5 ; 15
	dw PokeCenterSignText ; 16
	dw MartSignText ; 17
	; scripts
	dw SeviiOneIslandCityScriptText1 ; 18 ; Celio and Jenny
	dw SeviiOneIslandCityScriptText2 ; 19 ; Celio 1
	dw SeviiOneIslandCityScriptText3 ; 20 ; Celio 2

SeviiOneIslandCity_TextPointers_Rocket:
	dw SeviiOneIslandCityText1 ; Celio
	dw SeviiOneIslandCityText2 ; Officer
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw PickUpItemText ;  9
	dw PickUpItemText ; 10
	; signs
	dw SeviiOneIslandCitySignText1 ; 11
	dw SeviiOneIslandCitySignText2 ; 12
	dw SeviiOneIslandCitySignText3 ; 13
	dw SeviiOneIslandCitySignText4 ; 14
	dw SeviiOneIslandCitySignText5 ; 15
	dw PokeCenterSignText ; 16
	dw MartSignText ; 17
	; scripts
	dw SeviiOneIslandCityScriptText1_RP ; 18 ; Celio and Jenny
	dw SeviiOneIslandCityScriptText2_RP ; 19 ; Jenny sees you
	dw SeviiOneIslandCityScriptText3_RP ; 20 ; Jenny challenges you
	dw SeviiOneIslandCityScriptText4_RP ; 21 ; Jenny defeated
	dw SeviiOneIslandCityScriptText5_RP ; 22 ; Celio scared
	dw SeviiOneIslandCityScriptText6_RP ; 23 ; Celio mega scared

; scripts =========================================

SeviiOneIslandCityScript0:
	CheckEvent EVENT_SEVII_ONE_ISLAND_CELIO_JENNY_DIALOGUE
	ret nz
	ld hl, SeviiOneIslandCity_Coordinates_CelioJennyDialogue
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; RP?
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
; RP
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 4
	jr .changeScript
.notRP
; we are at the beginning of the pier
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_ONE_ISLAND_CELIO_JENNY_DIALOGUE
; prepare for and apply movement for Jenny
	ld a, 2
	ldh [hSpriteIndex], a
; determine which movement to apply depending on player's position
	ld a, [wXCoord]
	cp 26 ; left side
	ld de, JennyLeavesIfPlayerOnLeftMovements
	jr z, .playerOnLeftSide
	ld de, JennyLeavesIfPlayerOnRightMovements
.playerOnLeftSide
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 1
.changeScript
	ld [wCurMapScript], a
	ret

SeviiOneIslandCity_Coordinates_CelioJennyDialogue:
	dbmapcoord 26, 25
	dbmapcoord 27, 25
	db -1 ; end

JennyLeavesIfPlayerOnLeftMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db -1 ; end

JennyLeavesIfPlayerOnRightMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db -1 ; end

; ----------------------------

SeviiOneIslandCityScript1:
; wait for Jenny to have moved
	ld a, [wd730]
	bit 0, a
	jr z, .jennyMovementsOver
; turn player accordingly to follow Jenny
	ld a, [wNPCNumScriptedSteps]
	cp 6
	jr z, .turnCelio
	cp 5
	ld a, SPRITE_FACING_DOWN
	jr c, .applyPlayerFacing
	jr z, .lookSide
	ld a, SPRITE_FACING_UP
	jr .applyPlayerFacing
.lookSide
	ld a, [wXCoord]
	cp 26 ; left side
	ld a, SPRITE_FACING_RIGHT
	jr z, .applyPlayerFacing
	ld a, SPRITE_FACING_LEFT
.applyPlayerFacing
	ld [wSpritePlayerStateData1FacingDirection], a
	ret
.turnCelio
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	call ChangeSpriteMovementBytes ; new fancy approach from Engeze
	ret
.jennyMovementsOver
; hide Jenny
	ld a, HS_SEVII_ONE_ISLAND_CITY_JENNY
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; Celio dialogue 1 and movements
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
	ld a, 1
	ldh [hSpriteIndex], a
; determine which movement to apply depending on player's position
	ld a, [wXCoord]
	cp 26 ; left side
	ld de, CelioApproacesIfPlayerOnLeftMovements
	jr z, .playerOnLeftSide
	ld de, CelioApproacesIfPlayerOnRightMovements
.playerOnLeftSide
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

CelioApproacesIfPlayerOnLeftMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

CelioApproacesIfPlayerOnRightMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

; ----------------------------

SeviiOneIslandCityScript2:
; wait for Celio to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Celio and player if needed
	ld a, [wXCoord]
	cp 26 ; left side
	jr nz, .noTurning
	ld a, 1
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_LEFT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
.noTurning
; Celio dialogue 2 and movements
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
	ld a, 1
	ldh [hSpriteIndex], a
	ld de, CelioLeavesMovements
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

CelioLeavesMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; ----------------------------

SeviiOneIslandCityScript3:
; wait for Celio to have moved
	ld a, [wd730]
	bit 0, a
	jr z, .celioMovementsOver
; turn player if needed
	ld a, [wNPCNumScriptedSteps]
	cp 4
	ret nc
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ret
.celioMovementsOver
; hide Celio
	ld a, HS_SEVII_ONE_ISLAND_CITY_CELIO
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; clean the ignore
	xor a
	ld [wJoyIgnore], a
; load next script
	xor a
	ld [wCurMapScript], a
	ret

SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore:
	ld a, $f0
	ld [wJoyIgnore], a
	call DisplayTextID
	ld a, $ff
	ld [wJoyIgnore], a
	ret

; texts =========================================

SeviiOneIslandCityText1:
	text_far _SeviiOneIslandCityText1
	text_end

SeviiOneIslandCityText2:
	text_far _SeviiOneIslandCityText2
	text_end

SeviiOneIslandCityText3:
	text_far _SeviiOneIslandCityText3
	text_end

SeviiOneIslandCityText4:
	text_far _SeviiOneIslandCityText4
	text_end

SeviiOneIslandCityText5:
	text_far _SeviiOneIslandCityText5
	text_end

SeviiOneIslandCityText6:
	text_far _SeviiOneIslandCityText6
	text_end

SeviiOneIslandCityText7:
	text_far _SeviiOneIslandCityText7
	text_end

SeviiOneIslandCityText8:
	text_far _SeviiOneIslandCityText8
	text_end

; signs ----------------------------

SeviiOneIslandCitySignText1:
	text_far _SeviiOneIslandCitySignText1
	text_end

SeviiOneIslandCitySignText2:
	text_far _SeviiOneIslandCitySignText2
	text_end

SeviiOneIslandCitySignText3:
	text_far _SeviiOneIslandCitySignText3
	text_end

SeviiOneIslandCitySignText4:
	text_far _SeviiOneIslandCitySignText4
	text_end

SeviiOneIslandCitySignText5:
	text_far _SeviiOneIslandCitySignText5
	text_end

; scripts ----------------------------

SeviiOneIslandCityScriptText1:
	text_far _SeviiOneIslandCityScriptText1
	text_end

SeviiOneIslandCityScriptText2:
	text_far _SeviiOneIslandCityScriptText2
	text_end

SeviiOneIslandCityScriptText3:
	text_far _SeviiOneIslandCityScriptText3
	text_end

; new for RP ============================

SeviiOneIslandCityScript4:
; exclamation mark
	ld a, 1
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld a, 2
	ld [wEmotionBubbleSpriteIndex], a
;	ld a, EXCLAMATION_BUBBLE
;	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; turn Celio and Jenny
	lb de, 1, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing ; new Pigeon approach
	lb de, 2, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing ; new Pigeon approach
; load next script
	ld a, 5
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityScript5:
; Music
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
; Jenny dialogue
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
; Jenny movements
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 2
	ldh [hSpriteIndex], a
; determine which movement to apply depending on player's position
	ld a, [wXCoord]
	cp 26 ; left side
	ld de, JennyApproacesIfPlayerOnLeftMovements
	jr z, .playerOnLeftSide
	ld de, JennyApproacesIfPlayerOnRightMovements
.playerOnLeftSide
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 6
	ld [wCurMapScript], a
	ret

JennyApproacesIfPlayerOnLeftMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

JennyApproacesIfPlayerOnRightMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SeviiOneIslandCityScript6:
; wait for Jenny to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Celio again
	call TurnCelioDown
; turn Jenny if needed
	ld a, [wXCoord]
	cp 26 ; left cell
	jr z, .noTurnJenny
; turn player and Jenny
	ld a, SPRITE_FACING_LEFT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb bc, STAY, RIGHT
	ld a, 2
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes ; new from Engeze
	jr .doneTurning
.noTurnJenny
	ld a, 2
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	call ChangeSpriteMovementBytes ; new from Engeze
.doneTurning
; load next script
	ld a, 7
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityScript7:
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
	ld a, $0
	ld [wJoyIgnore], a
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, SeviiOneIslandCityText_AfterFightJenny
	ld de, SeviiOneIslandCityText_AfterFightJenny
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, OPP_JENNY
	ld [wCurOpponent], a
	ld a, 3
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
; load next script
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityScript8:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiOneIslandCityResetScripts
; we won
	xor a
	ld [wIsTrainerBattle], a
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_SEVII_ONE_ISLAND_CELIO_JENNY_DIALOGUE ; abused
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
; hide Jenny
	call GBFadeOutToBlack
	ld a, HS_SEVII_ONE_ISLAND_CITY_JENNY
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
	call GBFadeInFromBlack
; turn player and Celio
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	call TurnCelioDown
; Celio dialogue
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
; move player to Celio - choose which movement to apply
	ld a, [wXCoord]
	cp 26 ; left side
	ld de, SeviiOneIslandCityApproachCelio_RLEMovement_Left
	jr z, .playerOnLeftSide
	ld de, SeviiOneIslandCityApproachCelio_RLEMovement_Right
.playerOnLeftSide
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityApproachCelio_RLEMovement_Left:
	db D_UP, 1
SeviiOneIslandCityApproachCelio_RLEMovement_Right:
	db D_UP, 1
	db D_UP, 1
	db -1 ; end

SeviiOneIslandCityScript9:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; movement finished
	call Delay3
; load next script
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityScript10:
; check if need to turn player and Celio
	ld a, [wXCoord]
	cp 27
	jr z, .doneTurning
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 1, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
.doneTurning
; dialogue
	xor a
	ld [wJoyIgnore], a
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
; hide Celio
	call GBFadeOutToBlack
	ld a, HS_SEVII_ONE_ISLAND_CITY_CELIO
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
	call GBFadeInFromBlack
	; fallthrough

SeviiOneIslandCityResetScripts: ; new
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiOneIslandCityScriptText1_RP: ; 18 ; Celio and Jenny
	text_far _SeviiOneIslandCityScriptText1_RP
	text_end

SeviiOneIslandCityScriptText2_RP: ; 19 ; Jenny sees you
	text_far _SeviiOneIslandCityScriptText2_RP
	text_end

SeviiOneIslandCityScriptText3_RP: ; 20 ; Jenny challenges you
	text_far _SeviiOneIslandCityScriptText3_RP
	text_end

SeviiOneIslandCityText_AfterFightJenny:
	text_far _SeviiOneIslandCityText_AfterFightJenny
	text_end

SeviiOneIslandCityScriptText4_RP: ; 21 ; Jenny defeated
	text_far _SeviiOneIslandCityScriptText4_RP
	text_end

SeviiOneIslandCityScriptText5_RP: ; 22 ; Celio scared
	text_far _SeviiOneIslandCityScriptText5_RP
	text_end

SeviiOneIslandCityScriptText6_RP: ; 23 ; Celio mega scared
	text_far _SeviiOneIslandCityScriptText6_RP
	text_end

TurnCelioDown:
	lb de, 1, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	jp ChangeSpriteMovementBytes ; new from Engeze
