SeviiFourIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFourIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call CallFunctionInTable
	ret

SeviiFourIslandCity_TextPointers:
	dw SeviiFourIslandCityText1 ; 1, post-Leauge Pink
	dw SeviiFourIslandCityText2 ; 2
	dw SeviiFourIslandCityText3 ; 3
	dw SeviiFourIslandCityText4 ; 4
	dw SeviiFourIslandCityText5 ; 5
	dw SeviiFourIslandCityText6 ; 6
	dw SeviiFourIslandCityText7 ; 7
	dw SeviiFourIslandCityText8 ; 8
	dw RockSmashText ; 9
	dw PickUpItemText ; 10
	dw PickUpItemText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw SeviiFourIslandCityText14 ; 14
	; signs
	dw SeviiFourIslandCitySignText1 ; 15
	dw SeviiFourIslandCitySignText2 ; 16
	dw SeviiFourIslandCitySignText3 ; 17
	dw SeviiFourIslandCitySignText4 ; 18
	dw PokeCenterSignText ; 19
	dw MartSignText ; 20
	; scripts
	dw SeviiFourIslandCityScriptText1 ; 21
	dw SeviiFourIslandCityScriptText2 ; 22
	dw SeviiFourIslandCityScriptText3 ; 23

; scripts =========================================

SeviiFourIslandCity_ScriptPointers:
	dw SeviiFourIslandCityScript0
	dw SeviiFourIslandCityScript1 ; tbe
	dw SeviiFourIslandCityScript2 ; tbe

; --------------------------------------------

SeviiFourIslandCityScript0:
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ret z
	CheckEvent EVENT_SEVII_BEAT_PINK_FOUR_ISLAND
	ret nz
; we're post-Leauge but before battle vs Pink
	ld hl, SeviiFourIslandCityNearPinkCoords
	call ArePlayerCoordsInArray ; carry flag if yes
	jr nc, .notNearPink
; we are nearby 
	ld hl, wd72d
	set 5, [hl]
	ret
.notNearPink
	ld hl, wd72d
	res 5, [hl]
	ret

SeviiFourIslandCityNearPinkCoords:
	dbmapcoord 13,  8
	dbmapcoord 15,  8
	dbmapcoord 14,  9
	db -1 ; end

; --------------------------------------------

SeviiFourIslandCityScript1:
; if lost, reset scripts
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiFourIslandCityResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; if won: turn Pink appropriately
	call TurnPinkAppropriately
; set event and dialogue
	SetEvent EVENT_SEVII_BEAT_PINK_FOUR_ISLAND
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movements
	ld a, [wYCoord]
	cp 9
	ld de, PinkLeavingSeviiFourIslandCityMovements_PlayerSouth
	jr z, .playerSouthOfPink
	ld de, PinkLeavingSeviiFourIslandCityMovements_PlayerSide
.playerSouthOfPink
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 2
	ld [wCurMapScript], a
	ret

PinkLeavingSeviiFourIslandCityMovements_PlayerSouth:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
PinkLeavingSeviiFourIslandCityMovements_PlayerSide:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

; --------------------------------------------

SeviiFourIslandCityScript2:
; wait for Pink movements
	ld a, [wd730]
	bit 0, a
	ret nz
; hide Pink
	ld a, HS_SEVII_FOUR_ISLAND_CITY_POST_LEAGUE_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; reset scripts
	; fallthrough
SeviiFourIslandCityResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiFourIslandCityText1: ; post-Leauge Pink
	text_asm
; first dialogue
	ld hl, SeviiFourIslandCityScriptText1
	call PrintText
; exclamation mark
	ld a, 1
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; turn Pink appropriately
	call TurnPinkAppropriately
; reset the no-turn flag
	ld hl, wd72d
	res 5, [hl]
; new dialogue
	ld hl, SeviiFourIslandCityScriptText2
	call PrintText
; load battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PINK
	ld [wCurOpponent], a
	ld a, 4
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiFourIslandCityPinkDefeatedText
	ld de, SeviiFourIslandCityPinkBeatYouText
	call SaveEndBattleTextPointers
; script handling
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiFourIslandCityScriptText1:
	text_far _SeviiFourIslandCityScriptText1
	text_end

SeviiFourIslandCityScriptText2:
	text_far _SeviiFourIslandCityScriptText2
	text_end

SeviiFourIslandCityPinkDefeatedText:
	text_far _SeviiFourIslandCityPinkDefeatedText
	text_end

SeviiFourIslandCityPinkBeatYouText:
	text_far _SeviiFourIslandCityPinkBeatYouText
	text_end

SeviiFourIslandCityScriptText3:
	text_far _SeviiFourIslandCityScriptText3
	text_end

TurnPinkAppropriately:
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jr z, .playerUp
	cp SPRITE_FACING_LEFT
	jr z, .playerLeft
; player right
	ld a, SPRITE_FACING_LEFT
	lb bc, STAY, LEFT
	lb de, 1, SPRITE_FACING_LEFT
	jr .directionFound
.playerUp
	ld a, SPRITE_FACING_DOWN
	lb bc, STAY, DOWN
	lb de, 1, SPRITE_FACING_DOWN
	jr .directionFound
.playerLeft
	ld a, SPRITE_FACING_RIGHT
	lb bc, STAY, RIGHT
	lb de, 1, SPRITE_FACING_RIGHT
.directionFound
	ldh [hSpriteFacingDirection], a
	ld a, 1
	ldh [hSpriteIndex], a
	call SetSpriteFacingDirectionAndDelay
	call ChangeSpriteMovementBytes ; Engeze approach
	callfar ChangeSpriteFacing ; Pigeon approach
	ret

; --------------------------------------------

SeviiFourIslandCityText2:
	text_asm
	ld hl, SeviiFourIslandCityText2_1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiFourIslandCityText2_No
	jr nz, .printAndEnd
	ld hl, SeviiFourIslandCityText2_Yes
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandCityText2_1:
	text_far _SeviiFourIslandCityText2_1
	text_end

SeviiFourIslandCityText2_Yes:
	text_far _SeviiFourIslandCityText2_Yes
	text_end

SeviiFourIslandCityText2_No:
	text_far _SeviiFourIslandCityText2_No
	text_end

SeviiFourIslandCityText3:
	text_far _SeviiFourIslandCityText3
	text_end

SeviiFourIslandCityText4:
	text_far _SeviiFourIslandCityText4
	text_end

SeviiFourIslandCityText5:
	text_far _SeviiFourIslandCityText5
	text_end

SeviiFourIslandCityText6:
	text_far _SeviiFourIslandCityText6
	text_end

SeviiFourIslandCityText7:
	text_far _SeviiFourIslandCityText7
	text_end

SeviiFourIslandCityText8:
	text_far _SeviiFourIslandCityText8
	text_end

SeviiFourIslandCityText14:
	text_far _SeviiUndergroundCaveGuardText
	text_end

SeviiFourIslandCitySignText1:
	text_far _SeviiFourIslandCitySignText1
	text_end

SeviiFourIslandCitySignText2:
	text_far _SeviiFourIslandCitySignText2
	text_end

SeviiFourIslandCitySignText3:
	text_far _SeviiFourIslandCitySignText3
	text_end

SeviiFourIslandCitySignText4:
	text_far _SeviiFourIslandCitySignText4
	text_end
