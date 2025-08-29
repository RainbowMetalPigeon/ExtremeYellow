SeviiOneIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiOneIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiOneIslandCity_ScriptPointers:
	dw SeviiOneIslandCityScript0
	dw SeviiOneIslandCityScript1
	dw SeviiOneIslandCityScript2
	dw SeviiOneIslandCityScript3

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
	; scripts
	dw SeviiOneIslandCityScriptText1 ; 16 ; Celio and Jenny
	dw SeviiOneIslandCityScriptText2 ; 17 ; Celio 1
	dw SeviiOneIslandCityScriptText3 ; 18 ; Celio 2

; scripts =========================================

SeviiOneIslandCityScript0:
	CheckEvent EVENT_SEVII_ONE_ISLAND_CELIO_JENNY_DIALOGUE
	ret nz
	ld hl, SeviiOneIslandCity_Coordinates_CelioJennyDialogue
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
	ld a, 16
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_ONE_ISLAND_CELIO_JENNY_DIALOGUE
; prepare for and apply movement for Jenny
	ld a, 2
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
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
	ld [wCurMapScript], a
	ret

SeviiOneIslandCity_Coordinates_CelioJennyDialogue:
	dbmapcoord 26, 25
	dbmapcoord 27, 25
	db -1 ; end

JennyLeavesIfPlayerOnLeftMovements:
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db -1 ; end

JennyLeavesIfPlayerOnRightMovements:
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
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
	cp 7
	jr z, .turnCelio
	cp 5
	ld a, SPRITE_FACING_DOWN
	jr c, .applyPlayerFacing
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
	ld a, SPRITE_FACING_DOWN
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirection
	call SetSpriteMovementBytesToFF
	ret
.jennyMovementsOver
; hide Jenny
	ld a, HS_SEVII_ONE_ISLAND_CITY_JENNY
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; Celio dialogue 1 and movements
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
	ld a, 1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
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
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ; call DisplayTextID
	ld a, 1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
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
