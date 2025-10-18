SeviiOneIslandHouses_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiOneIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiOneIslandHouses_ScriptPointers:
	dw SeviiOneIslandHouses_Null ; 0
	dw SeviiOneIslandHouses_PinkAppears ; 1
	dw SeviiOneIslandHouses_PinkMovementsAndBattle ; 2
	dw SeviiOneIslandHouses_PinkLeaves ; 3
	dw SeviiOneIslandHouses_PinkLeaves2 ; 4
	dw SeviiOneIslandHouses_PostPinkBattle ; 5
	dw SeviiOneIslandHouses_PostPinkBattle2 ; 6

; scripts =========================================

SeviiOneIslandHouses_Null:
	ret

SeviiOneIslandHouses_PinkAppears:
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	lb de, 7, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
; Pikachu hides and player, Mayoi, and Celio turn
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 5, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
.notFollowingPikachu
; Pink dialogue
	ld c, 30
	call DelayFrames
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movement
	ld de, CeliosHousePinkEntranceMovements
	ld a, 7
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

CeliosHousePinkEntranceMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiOneIslandHouses_PinkMovementsAndBattle:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Mayoi and Celio again
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 5, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; Pink dialogue and battle
	ld a, $0
	ld [wJoyIgnore], a
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID ; SeviiOneIslandCity_f0JoyIgnoreDisplayTextffJoyIgnore ?
; battle
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_PINK
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, CeliosHousePinkDefeatedText
	ld de, CeliosHousePinkBeatYouText
	call SaveEndBattleTextPointers
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkLeaves:
	lb de, 7, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 5, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	SetEvent EVENT_SEVII_FACE_PINK_CELIOS_HOUSE
	predef HealParty
	ld a, 7
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	call ChangeSpriteMovementBytes ; new from Engeze
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkLeaves2:
	ld a, 15
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movement
	ld de, CeliosHousePinkLeaveMovements
	ld a, 7
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 5
	ld [wCurMapScript], a
	ret

CeliosHousePinkLeaveMovements:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

SeviiOneIslandHouses_PostPinkBattle:
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; hide Pink
	ld a, SFX_GO_OUTSIDE
	call PlaySound
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_PINK
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; show Pikachu again
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	xor a
	ld [wJoyIgnore], a
; turn towards Celio and be gifted the Flute
	ld a, 3
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	call ChangeSpriteMovementBytes ; new from Engeze
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; load next script
	ld a, 6
	ld [wCurMapScript], a
	ret
	
SeviiOneIslandHouses_PostPinkBattle2:
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; dialogue
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	ld a, 0
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiOneIslandHouses_TextPointers:
	dw SeviiOneIslandHousesText1 ; weather move tutor
	dw SeviiOneIslandHousesText2 ; Celio before rescue
	dw SeviiOneIslandHousesText3 ; Celio right after rescue
	dw SeviiOneIslandHousesText4 ; Celio after rescue
	dw SeviiOneIslandHousesText5 ; Mayoi right after rescue
	dw SeviiOneIslandHousesText6 ; Mayoi after rescue
	dw SeviiOneIslandHousesText7 ; Pink
	dw SeviiOneIslandHousesText8 ; plushie
	; signs
	dw SeviiOneIslandHousesSignText1
	dw SeviiOneIslandHousesSignText2
	dw SeviiOneIslandHousesSignText3
	dw SeviiOneIslandHousesSignText4 ; 12
	; scripts
	dw SeviiOneIslandHousesScriptText1 ; 13
	dw SeviiOneIslandHousesScriptText2 ; 14
	dw SeviiOneIslandHousesScriptText3 ; 15

SeviiOneIslandHousesText1:
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR
	jr nz, .alreadyGaveDrink
; still haven't given drink
	ld hl, SeviiOneIslandHousesText1_RequestDrink
	call PrintText
; check if we have the drink
	call RemoveWeatherTutorDrink
	ldh a, [hItemToRemoveID]
	and a
	jr z, .done ; we have no drink
; we have the drink and we gave one
	SetEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR
	call WaitForTextScrollButtonPress
	ld hl, SeviiOneIslandHousesText1_ThanksForTheDrink
	call PrintText
	call WaitForTextScrollButtonPress
.alreadyGaveDrink
	ld hl, SeviiOneIslandHousesText1_Question
	call PrintText
;	call YesNoChoice
;	ld a, [wCurrentMenuItem]
;	and a
;	jr z, .learnMove
	call MoveTutorWeatherChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .sunnyDay
	dec a
	jr z, .rainDance
	dec a
	jr z, .sandstorm
	dec a
	jr z, .hail
; decline
	ld hl, SeviiOneIslandHousesText1_Refused
	call PrintText
	jr .done
.sunnyDay
	ld a, SUNNY_DAY
	jr .learnMove
.rainDance
	ld a, RAIN_DANCE
	jr .learnMove
.sandstorm
	ld a, SANDSTORM
	jr .learnMove
.hail
	ld a, HAIL
.learnMove
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiOneIslandHousesText1_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiOneIslandHousesText1_RequestDrink:
	text_far _SeviiOneIslandHousesText1_RequestDrink
	text_end

SeviiOneIslandHousesText1_ThanksForTheDrink:
	text_far _SeviiOneIslandHousesText1_ThanksForTheDrink
	text_end

SeviiOneIslandHousesText1_Question:
	text_far _SeviiOneIslandHousesText1_Question
	text_end

SeviiOneIslandHousesText1_Refused:
	text_far _SeviiOneIslandHousesText1_Refused
	text_end

SeviiOneIslandHousesText1_Done:
	text_far _SeviiOneIslandHousesText1_Done
	text_end

; displays weather choice
MoveTutorWeatherChoice:
	call SaveScreenTilesToBuffer1
	ld a, MOVE_TUTOR_WEATHER_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 8
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 4
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

RemoveWeatherTutorDrink::
	ld hl, WeatherTutorDrinkList
.drinkLoop
	ld a, [hli]
	ldh [hItemToRemoveID], a
	and a
	ret z
	push hl
	ld b, a
	call IsItemInBag
	pop hl
	jr z, .drinkLoop
	farjp RemoveItemByID

WeatherTutorDrinkList:
	db COFFEE
	db BEER
	db 0 ; end

; Celio and Mayoi ------------------------------------

SeviiOneIslandHousesText2:
	text_far _SeviiOneIslandHousesText2
	text_end

; ---

SeviiOneIslandHousesText3: ; Celio right after rescue
	text_asm
	CheckEvent EVENT_SEVII_FACE_PINK_CELIOS_HOUSE
	jr z, .beforePinkBattle
; after Pink Battle ---------
; check if already received the Flute, and if not, give it
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .gotFlute
; check if already tried to gift flute
	CheckEvent EVENT_TRIED_TO_GIFT_POKE_FLUTE
	jr nz, .alreadyTriedToGiveFlute
; first time
	ld hl, SeviiOneIslandHousesText3_RightAfterPink
	call PrintText
.alreadyTriedToGiveFlute
	ld hl, SeviiOneIslandHousesText3_TryToGiftFlute
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_POKE_FLUTE
	ld hl, SeviiOneIslandHousesText3_ReceivedFlute
	jr .printAndEnd
.bagFull
	SetEvent EVENT_TRIED_TO_GIFT_POKE_FLUTE
	ld hl, SeviiOneIslandHousesText3_NoRoom
	jr .printAndEnd
.gotFlute
	ld hl, SeviiOneIslandHousesText3_AfterFlute
	jr .printAndEnd
.beforePinkBattle ; --------
	ld hl, SeviiOneIslandHousesText3_CelioBeforePink
; load next script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandHousesText3_CelioBeforePink:
	text_far _SeviiOneIslandHousesText3_CelioBeforePink
	text_end

SeviiOneIslandHousesText3_RightAfterPink:
	text_far _SeviiOneIslandHousesText3_RightAfterPink
	text_end

SeviiOneIslandHousesText3_TryToGiftFlute:
	text_far _SeviiOneIslandHousesText3_TryToGiftFlute
	text_end

SeviiOneIslandHousesText3_NoRoom:
	text_far _SeviiOneIslandHousesText3_NoRoom
	text_end

SeviiOneIslandHousesText3_ReceivedFlute:
	text_far _ReceivedFluteText
	sound_get_key_item
	text_far _FluteExplanationText
	text_end

SeviiOneIslandHousesText3_AfterFlute:
	text_far _SeviiOneIslandHousesText3_AfterFlute
	text_end

; ---

SeviiOneIslandHousesText4: ; Celio after rescue
	text_far _SeviiOneIslandHousesText4
	text_end

SeviiOneIslandHousesText5: ; Mayoi right after rescue
	text_far _SeviiOneIslandHousesText5
	text_end

SeviiOneIslandHousesText6: ; Mayoi after rescue
	text_far _SeviiOneIslandHousesText6
	text_end

SeviiOneIslandHousesText7: ; Pink
	text_far _SeviiOneIslandHousesText7
	text_end

SeviiOneIslandHousesText8: ; plushie
	text_far _SeviiOneIslandHousesText8
	text_end

; signs ----------------------------------------------

SeviiOneIslandHousesSignText1:
	text_far _SeviiOneIslandHousesSignText1
	text_end

SeviiOneIslandHousesSignText2:
	text_far _SeviiOneIslandHousesSignText2
	text_end

SeviiOneIslandHousesSignText3:
	text_far _SeviiOneIslandHousesSignText3
	text_end

SeviiOneIslandHousesSignText4:
	text_far _SeviiOneIslandHousesSignText4
	text_end

; scripts ---------------------------------------------

SeviiOneIslandHousesScriptText1:
	text_far _SeviiOneIslandHousesScriptText1
	text_end

SeviiOneIslandHousesScriptText2:
	text_far _SeviiOneIslandHousesScriptText2
	text_end

CeliosHousePinkDefeatedText:
	text_far _CeliosHousePinkDefeatedText
	text_end

CeliosHousePinkBeatYouText:
	text_far _CeliosHousePinkBeatYouText
	text_end
	
SeviiOneIslandHousesScriptText3:
	text_far _SeviiOneIslandHousesScriptText3
	text_end
