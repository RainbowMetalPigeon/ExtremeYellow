SeviiSixIslandCity_Script:
	RPTextChooser SeviiSixIslandCity_TextPointers, SeviiSixIslandCity_TextPointers_Rocket
	call ResetAnomaliesWarning_SixIsland
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSixIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ResetAnomaliesWarning_SixIsland:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	ResetEvent EVENT_SEVII_ALREADY_WARNED_ABOUT_ANOMALIES
	ret

; texts =========================================

SeviiSixIslandCity_TextPointers:
	dw SeviiSixIslandCityText1 ; 1
	dw SeviiSixIslandCityText2 ; 2
	dw SeviiSixIslandCityText3 ; 3
	dw SeviiSixIslandCityText4 ; 4 Pink, only for RP
	; signs
	dw SeviiSixIslandCitySignText1 ; 5
	dw SeviiSixIslandCitySignText2 ; 6
	dw SeviiSixIslandCitySignText3 ; 7
	dw PokeCenterSignText ; 8
	dw MartSignText ; 9

SeviiSixIslandCity_TextPointers_Rocket:
	dw GenericNPCText_RocketPath ; 1
	dw GenericNPCText_RocketPath ; 2
	dw GenericNPCText_RocketPath ; 3
	dw SeviiSixIslandCityText4 ; 4 Pink, only for RP
	; signs
	dw SeviiSixIslandCitySignText1 ; 5
	dw SeviiSixIslandCitySignText2 ; 6
	dw SeviiSixIslandCitySignText3 ; 7
	dw PokeCenterSignText ; 8
	dw MartSignText ; 9
	; scripts
	dw SeviiSixIslandCityScriptText1 ; 10
	dw SeviiSixIslandCityScriptText2 ; 11

SeviiSixIslandCityText1:
	text_far _SeviiSixIslandCityText1
	text_end

SeviiSixIslandCityText2:
	text_far _SeviiSixIslandCityText2
	text_end

SeviiSixIslandCityText3:
	text_far _SeviiSixIslandCityText3
	text_end

SeviiSixIslandCitySignText1:
	text_far _SeviiSixIslandCitySignText1
	text_end

SeviiSixIslandCitySignText2:
	text_far _SeviiSixIslandCitySignText2
	text_end

SeviiSixIslandCitySignText3:
	text_far _SeviiSixIslandCitySignText3
	text_end

; new for RP ========================================

SeviiSixIslandCity_ScriptPointers:
	dw SeviiSixIslandCity_Script0
	dw SeviiSixIslandCity_Script1
	dw SeviiSixIslandCity_Script2

SeviiSixIslandCity_Script0:
	CheckEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	ret nz
	CheckEvent EVENT_ROCKET_PATH
	ret z
	ld hl, SeviiSixIslandCity_Coordinates_PinkScene
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; trigger event
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
; exclamation bubble
	ld a, 4
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; dialogue
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; show Pink
	ld a, HS_SEVII_SIX_ISLAND_CITY_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
; start moving PINK
	ld de, SeviiSixCityPinkMovements
	ld a, 4
	ldh [hSpriteIndex], a
	call MoveSprite ; hSpriteIndex already set
; load next script
	ld a, 1
	ld [wCurMapScript], a
	ret

SeviiSixIslandCity_Coordinates_PinkScene:
	dbmapcoord 14,  6
	db -1 ; end

SeviiSixCityPinkMovements:
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db -1 ; end

SeviiSixIslandCity_Script1:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; fix Pink's facing
	lb de, 4, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
; dialogue
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
	ld a, OPP_PINK
	ld [wCurOpponent], a
	ld a, 4
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiSixIslandCityPinkDefeatedText
	ld de, SeviiSixIslandCityPinkWonText
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiSixIslandCity_Script2:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiSixIslandCityResetScripts
; we won
	lb de, 4, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
	SetEvent EVENT_RP_BEAT_PINK_SIX_ISLAND
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Pink and League guard, show champion Pink
	call GBFadeOutToBlack
	ld a, HS_SEVII_SIX_ISLAND_CITY_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_INDIGO_PLATEAU_LOBBY_GUARD
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_CHAMPIONS_ROOM_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call UpdateSprites
	call GBFadeInFromBlack
	; fallthrough

SeviiSixIslandCityResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiSixIslandCityText4:
	text_far _SeviiSixIslandCityText4
	text_end

SeviiSixIslandCityScriptText1:
	text_far _SeviiSixIslandCityScriptText1
	text_end

SeviiSixIslandCityPinkDefeatedText:
	text_far _SeviiSixIslandCityPinkDefeatedText
	text_end

SeviiSixIslandCityPinkWonText:
	text_far _SeviiSixIslandCityPinkWonText
	text_end

SeviiSixIslandCityScriptText2:
	text_far _SeviiSixIslandCityScriptText2
	text_end
