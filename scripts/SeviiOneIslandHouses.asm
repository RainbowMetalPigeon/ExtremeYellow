SeviiOneIslandHouses_Script:
	RPTextChooser SeviiOneIslandHouses_TextPointers, SeviiOneIslandHouses_TextPointers_Rocket
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
	; new for RP
	dw SeviiOneIslandHouses_PinkAppears_RP ; 7
	dw SeviiOneIslandHouses_PinkMovementsAndBattle_RP ; 8
	dw SeviiOneIslandHouses_PinkLeaves_RP ; 9
	dw SeviiOneIslandHouses_PinkLeaves2_RP ; 10
	dw SeviiOneIslandHouses_PostPinkBattle_RP ; 11
	dw SeviiOneIslandHouses_PostPinkBattle2_RP ; 12
	dw SeviiOneIslandHouses_PostBattleTutor_RP ; 13
	dw SeviiOneIslandHouses_OrmAppears_RP ; 14
	dw SeviiOneIslandHouses_OrmMovementsAndBattle_RP ; 15
	dw SeviiOneIslandHouses_OrmDies_RP ; 16

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
.notFollowingPikachu ; TBE (?)
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 5, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; Pink dialogue
	ld c, 30
	call DelayFrames
	ld a, 20
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
	ld a, 21
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
; load next script
	ld a, 4
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkLeaves2:
	ld a, 22
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
	dw SeviiOneIslandHousesText9 ; Snorlax fan?
	dw SeviiOneIslandHousesText10 ; x
	dw SeviiOneIslandHousesText11 ; x
	dw SeviiOneIslandHousesText2  ; Pink's Dad, unused in non-RP
	dw SeviiOneIslandHousesText2  ; 13, Orm, unused in non-RP
	; signs
	dw SeviiOneIslandHousesSignText1 ; 14
	dw SeviiOneIslandHousesSignText2
	dw SeviiOneIslandHousesSignText3
	dw SeviiOneIslandHousesSignText4 ; 17
	dw SeviiOneIslandHousesSignText5 ; 18
	dw SeviiOneIslandHousesSignText6 ; 19
	; scripts
	dw SeviiOneIslandHousesScriptText1 ; 20
	dw SeviiOneIslandHousesScriptText2 ; 21
	dw SeviiOneIslandHousesScriptText3 ; 22

SeviiOneIslandHouses_TextPointers_Rocket:
	dw SeviiOneIslandHousesText1_RP ; weather move tutor
	dw SeviiOneIslandHousesText2_RP ; Celio before battle vs Blue
	dw SeviiOneIslandHousesText3_RP ; Celio after battle vs Blue
	dw SeviiOneIslandHousesText4_RP ; Celio after battle vs Pink
	dw SeviiOneIslandHousesText5 ; Mayoi right after rescue (unused?)
	dw SeviiOneIslandHousesText6 ; Mayoi after rescue (unused?)
	dw SeviiOneIslandHousesText7 ; Pink
	dw SeviiOneIslandHousesText8_RP ; plushie
	dw SeviiOneIslandHousesText9_RP ; Snorlax fan
	dw GenericNPCText_RocketPath ; x
	dw GenericNPCText_RocketPath ; x
	dw SeviiOneIslandHousesText12_RP ; Pink's Dad, used only in RP
	dw SeviiOneIslandHousesText13_RP ; 13, Orm, used only in RP
	; signs
	dw SeviiOneIslandHousesSignText1 ; 14
	dw SeviiOneIslandHousesSignText2
	dw SeviiOneIslandHousesSignText3
	dw SeviiOneIslandHousesSignText4_RP ; 17
	dw SeviiOneIslandHousesSignText5 ; 18
	dw SeviiOneIslandHousesSignText6 ; 19
	; scripts
	dw SeviiOneIslandHousesScriptText1_RP ; 20 ; Pink block
	dw SeviiOneIslandHousesScriptText2_RP ; 21
	dw SeviiOneIslandHousesScriptText3_RP ; 22
	dw SeviiOneIslandHousesScriptText4_RP ; 23
	dw SeviiOneIslandHousesScriptText5_RP ; 24
	dw SeviiOneIslandHousesScriptText6_RP ; 25 ; Orm block
	dw SeviiOneIslandHousesScriptText7_RP ; 26
	dw SeviiOneIslandHousesScriptText8_RP ; 27
	dw SeviiOneIslandHousesScriptText9_RP ; 28

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

SeviiOneIslandHousesText9:
	text_asm
	CheckEvent EVENT_SEVII_TRADED_SNORLAX_FOR_ONIGIRI_BOX
	ld hl, SeviiOneIslandHousesText9_TradeDone
	jr nz, .printAndEnd
; trade not done yet
	call SaveScreenTilesToBuffer2
	ld hl, SeviiOneIslandHousesText9_Intro
	call PrintText
	xor a ; NORMAL_PARTY_MENU
	ld [wPartyMenuTypeOrMessageID], a
	dec a
	ld [wUpdateSpritesEnabled], a
	call DisplayPartyMenu
	push af
	callfar InGameTrade_RestoreScreen
	pop af
	jp c, .tradeFailed ; jump if the player didn't select a pokemon
; is it Snorlax or Munchlax?
	ld a, [wcf91]
	ld b, SNORLAX
	ld hl, SeviiOneIslandHousesText9_LetsGoSnorlax
	cp b
	jr z, .tradePossible
	ld b, MUNCHLAX
	ld hl, SeviiOneIslandHousesText9_LetsGoMunchlax
	cp b
	jp nz, .tradeFailed ; jump if the selected mon's species is not the required one(s)
.tradePossible
	call PrintText
; do we have more than 1 mon?
	ld a, [wPartyCount]
	dec a
	ld hl, SeviiOneIslandHousesText9_OnlyOneMon
	jr z, .printAndEnd
; ask confirmation
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .tradeFailed
; perform trade
	ld a, [wWhichPokemon]
	xor a
	ld [wMonDataLocation], a ; not used
	ld [wRemoveMonFromBox], a
	call RemovePokemon
	ld hl, SeviiOneIslandHousesText9_CiaoSnorlax
	call PrintText
	SetEvent EVENT_SEVII_TRADED_SNORLAX_FOR_ONIGIRI_BOX
	ld hl, SeviiOneIslandHousesText9_PlayerOnigiri
	jr .printAndEnd
.tradeFailed
	ld hl, SeviiOneIslandHousesText9_TooBad
.printAndEnd
	call PrintText
.end
	jp TextScriptEnd

SeviiOneIslandHousesText9_PlayerOnigiri:
	text_far _CeladonDinerText1_ReceivedOnigiri
	text_end

SeviiOneIslandHousesText9_OnlyOneMon:
	text_far _SeviiOneIslandHousesText9_OnlyOneMon
	text_end

SeviiOneIslandHousesText9_TooBad:
	text_far _SeviiOneIslandHousesText9_TooBad
	text_end

SeviiOneIslandHousesText9_TradeDone:
	text_far _SeviiOneIslandHousesText9_TradeDone
	text_end

SeviiOneIslandHousesText9_CiaoSnorlax:
	text_far _SeviiOneIslandHousesText9_CiaoSnorlax
	text_end

SeviiOneIslandHousesText9_LetsGoSnorlax:
	text_far _SeviiOneIslandHousesText9_LetsGoSnorlax
	text_end

SeviiOneIslandHousesText9_LetsGoMunchlax:
	text_far _SeviiOneIslandHousesText9_LetsGoMunchlax
	text_end

SeviiOneIslandHousesText9_Intro:
	text_far _SeviiOneIslandHousesText9_Intro
	text_end

SeviiOneIslandHousesText10:
	text_far _SeviiOneIslandHousesText10
	text_end

SeviiOneIslandHousesText11:
	text_far _SeviiOneIslandHousesText11
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

SeviiOneIslandHousesSignText5:
	text_far _SeviiOneIslandHousesSignText5
	text_end

SeviiOneIslandHousesSignText6:
	text_far _SeviiOneIslandHousesSignText6
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

; new for RP ===========================================

SeviiOneIslandHousesText2_RP:
	text_far _SeviiOneIslandHousesText2_RP
	text_end

SeviiOneIslandHousesText8_RP:
	text_far _SeviiOneIslandHousesText8_RP
	text_end

SeviiOneIslandHousesText9_RP:
	text_far _SeviiOneIslandHousesText9
	text_end

SeviiOneIslandHousesText3_RP:
	text_asm
	CheckEvent EVENT_SEVII_FACE_PINK_CELIOS_HOUSE
	jr z, .beforePinkBattle
; after Pink Battle ---------
	ld hl, SeviiOneIslandHousesText3_RP_AfterPink
	jr .printAndEnd
.beforePinkBattle ; --------
	ld hl, SeviiOneIslandHousesText3_RP_BeforePink
; load next script
	ld a, 7
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandHousesText3_RP_AfterPink:
	text_far _SeviiOneIslandHousesText3_RP_AfterPink
	text_end

SeviiOneIslandHousesText3_RP_BeforePink:
	text_far _SeviiOneIslandHousesText3_RP_BeforePink
	text_end

SeviiOneIslandHouses_PinkAppears_RP: ; 7
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_PINK
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	lb de, 7, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
; player and Celio turn
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 12, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; Pink dialogue
	ld c, 30
	call DelayFrames
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movement
	ld de, CeliosHousePinkEntranceMovements
	ld a, 7
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 8
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkMovementsAndBattle_RP: ; 8
; wait for Pink to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; turn Celio
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 12, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; Pink dialogue and battle
	ld a, $0
	ld [wJoyIgnore], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; battle
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
	ld hl, CeliosHousePinkDefeatedText_RP
	ld de, CeliosHousePinkBeatYouText_RP
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 9
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkLeaves_RP: ; 9
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiOneIslandHousesResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	lb de, 7, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	lb de, 12, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	SetEvent EVENT_SEVII_FACE_PINK_CELIOS_HOUSE
; load next script
	ld a, 10
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PinkLeaves2_RP: ; 10
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movement
	ld de, CeliosHousePinkLeaveMovements
	ld a, 7
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 11
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PostPinkBattle_RP: ; 11
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
	xor a
	ld [wJoyIgnore], a
; turn towards Celio
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
; load next script
	ld a, 12
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_PostPinkBattle2_RP: ; 12
	lb de, 3, SPRITE_FACING_DOWN
	callfar ChangeSpriteFacing
; dialogue
	ld a, 23
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	; fallthrough

SeviiOneIslandHousesResetScripts:
	ld a, 0
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiOneIslandHousesScriptText1_RP:
	text_far _SeviiOneIslandHousesScriptText1_RP
	text_end

SeviiOneIslandHousesScriptText2_RP:
	text_far _SeviiOneIslandHousesScriptText2_RP
	text_end

CeliosHousePinkDefeatedText_RP:
	text_far _CeliosHousePinkDefeatedText_RP
	text_end

CeliosHousePinkBeatYouText_RP:
	text_far _CeliosHousePinkBeatYouText_RP
	text_end

SeviiOneIslandHousesScriptText3_RP:
	text_far _SeviiOneIslandHousesScriptText3_RP
	text_end

SeviiOneIslandHousesScriptText4_RP:
	text_far _SeviiOneIslandHousesScriptText4_RP
	text_end

SeviiOneIslandHousesText12_RP:
	text_asm
	CheckEvent EVENT_SEVII_FACE_PINK_CELIOS_HOUSE
	jr z, .beforePinkBattle
; after Pink Battle ---------
	ld hl, SeviiOneIslandHousesText12_RP_AfterPink
	jr .printAndEnd
.beforePinkBattle ; --------
	ld hl, SeviiOneIslandHousesText12_RP_BeforePink
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandHousesText12_RP_AfterPink:
	text_far _SeviiOneIslandHousesText12_RP_AfterPink
	text_end

SeviiOneIslandHousesText12_RP_BeforePink:
	text_far _SeviiOneIslandHousesText12_RP_BeforePink
	text_end

; ----------------------------------------

SeviiOneIslandHousesText1_RP:
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR ; abused
	jr nz, .alreadyBeated
; still haven't beaten
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_FISHER
	ld [wCurOpponent], a
	ld a, 14
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	; no need for the SaveEndBattleTextPointers, as it's RP
	ld a, 13
	ld [wCurMapScript], a
	ld hl, SeviiOneIslandHousesText1_Intro_RP
	jr .printAndEnd
.alreadyBeated
	ld hl, SeviiOneIslandHousesText1_Question_RP
	call PrintText
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
	ld hl, SeviiOneIslandHousesText1_Refused_RP
	jr .printAndEnd
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
	ld hl, SeviiOneIslandHousesText1_Done_RP
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiOneIslandHouses_PostBattleTutor_RP: ; 13
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiOneIslandHousesResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR ; abused
	ld a, 24
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	jp SeviiOneIslandHousesResetScripts

SeviiOneIslandHousesScriptText5_RP:
	text_far _SeviiOneIslandHousesScriptText5_RP
	text_end

SeviiOneIslandHousesText1_Intro_RP:
	text_far _SeviiOneIslandHousesText1_Intro_RP
	text_end

SeviiOneIslandHousesText1_Question_RP:
	text_far _SeviiOneIslandHousesText1_Question_RP
	text_end

SeviiOneIslandHousesText1_Refused_RP:
	text_far _SeviiOneIslandHousesText1_Refused_RP
	text_end

SeviiOneIslandHousesText1_Done_RP:
	text_far _SeviiOneIslandHousesText1_Done_RP
	text_end

; ----------------------------------------

SeviiOneIslandHousesText4_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_ORM_CELIOS_HOUSE
	ld hl, SeviiOneIslandHousesText4_RP_PostOrm
	jr nz, .printAndEnd
	CheckEvent EVENT_RP_KILLED_GIOVANNI
	ld hl, SeviiOneIslandHousesText4_RP_PostGiovanni
	jr nz, .printAndEnd
	ld hl, SeviiOneIslandHousesText4_RP_PreGiovanni
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandHousesText4_RP_PreGiovanni:
	text_far _SeviiOneIslandHousesText4_RP_PreGiovanni
	text_end

SeviiOneIslandHousesText4_RP_PostGiovanni:
	text_far _SeviiOneIslandHousesText4_RP_PostGiovanni
	text_end

SeviiOneIslandHousesText4_RP_PostOrm:
	text_far _SeviiOneIslandHousesText4_RP_PostOrm
	text_end

SeviiOneIslandHousesText13_RP: ; just a proxy
	text_far _SeviiOneIslandHousesText13_RP
	text_end

SeviiOneIslandHousesSignText4_RP:
	text_asm
	CheckEvent EVENT_RP_KILLED_GIOVANNI
	jr nz, .postGiovanni
	ld hl, SeviiOneIslandHousesSignText4
	jr .printAndEnd
.postGiovanni
	CheckEvent EVENT_RP_BEAT_ORM_CELIOS_HOUSE
	jr z, .triggerOrmEvent
; post-Orm, give PERFECTER and LEGEND_CANDY
	ld hl, SeviiOneIslandHousesSignText4_RP_AccessPC
	call PrintText
	call WaitForTextScrollButtonPress
	lb bc, LEGEND_CANDY, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, SeviiOneIslandHousesSignText4_RP_GotCandy
	call PrintText
	lb bc, PERFECTER, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, SeviiOneIslandHousesSignText4_RP_GotPerfecters
	jr .printAndEnd
.bagFull
	ld hl, SeviiOneIslandHousesSignText4_RP_NoRoom
.printAndEnd
	call PrintText
	jp TextScriptEnd
.triggerOrmEvent
	ld hl, SeviiOneIslandHousesSignText4_RP_AccessPC
	call PrintText
	ld a, 14
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiOneIslandHousesSignText4_RP_AccessPC:
	text_far _SeviiOneIslandHousesSignText4_RP_AccessPC
	text_end

SeviiOneIslandHousesSignText4_RP_GotCandy:
	text_far _SeviiOneIslandHousesSignText4_RP_GotCandy
	sound_get_item_1
	text_end

SeviiOneIslandHousesSignText4_RP_GotPerfecters:
	text_far _SeviiOneIslandHousesSignText4_RP_GotPerfecters
	sound_get_item_1
	text_end

SeviiOneIslandHousesSignText4_RP_NoRoom:
	text_far _SeviiOneIslandHousesSignText4_RP_NoRoom
	text_end

SeviiOneIslandHouses_OrmAppears_RP: ; 14
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_ORM
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	lb de, 13, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
; player and Celio turn
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
; Orm dialogue
	ld a, 25
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; Pink movement
	ld de, CeliosHouseOrmEntranceMovements
	ld a, 13
	ldh [hSpriteIndex], a
	call MoveSprite
; load next script
	ld a, 15
	ld [wCurMapScript], a
	ret

CeliosHouseOrmEntranceMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

SeviiOneIslandHouses_OrmMovementsAndBattle_RP: ; 15
; wait for Orm to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; Orm dialogue and battle
	ld a, $0
	ld [wJoyIgnore], a
	ld a, 26
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_ORM
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, CeliosHouseOrmDefeatedText_RP
	ld de, CeliosHouseOrmDefeatedText_RP
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 16
	ld [wCurMapScript], a
	ret

SeviiOneIslandHouses_OrmDies_RP: ; 16
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiOneIslandHousesResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	lb de, 13, SPRITE_FACING_UP
	callfar ChangeSpriteFacing
	ld a, 27
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; last dialogue
    call GBFadeOutToWhite
	ld a, SFX_PUSH_BOULDER
	call PlaySound
    call GBFadeInFromWhite
	ld a, 28
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; kill Orm
	SetEvent EVENT_RP_BEAT_ORM_CELIOS_HOUSE
	call GBFadeOutToBlack
	ld a, HS_SEVII_ONE_ISLAND_HOUSES_ORM
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
    ld c, 60
    call DelayFrames
	ld a, SFX_PUSH_BOULDER
	call PlaySound
    ld c, 60
    call DelayFrames
	call GBFadeInFromBlack
	jp SeviiOneIslandHousesResetScripts

SeviiOneIslandHousesScriptText6_RP:
	text_far _SeviiOneIslandHousesScriptText6_RP
	text_end

SeviiOneIslandHousesScriptText7_RP:
	text_far _SeviiOneIslandHousesScriptText7_RP
	text_end

CeliosHouseOrmDefeatedText_RP:
	text_far _CeliosHouseOrmDefeatedText_RP
	text_end

SeviiOneIslandHousesScriptText8_RP:
	text_far _SeviiOneIslandHousesScriptText8_RP
	text_end

SeviiOneIslandHousesScriptText9_RP:
	text_far _SeviiOneIslandHousesScriptText9_RP
	text_end

