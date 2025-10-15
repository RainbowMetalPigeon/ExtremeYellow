SeviiTwoIslandCity_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandCity_ScriptPointers:
	dw SeviiTwoIslandCity_NullScript
	dw SeviiTwoIslandCity_PostVictoryVsBikerBoss

SeviiTwoIslandCity_TextPointers:
	dw SeviiTwoIslandCityText1
	dw SeviiTwoIslandCityText2
	dw SeviiTwoIslandCityText3
	dw SeviiTwoIslandCityText4
	dw SeviiTwoIslandCityText5
	dw SeviiTwoIslandCityText6
	dw SeviiTwoIslandCityText7
	dw SeviiTwoIslandCityText8
	dw SeviiTwoIslandCityText9  ; Tauros
	dw SeviiTwoIslandCityText10 ; Tauros
	dw RockSmashText
	dw PickUpItemText
	dw PickUpItemText
	; signs
	dw SeviiTwoIslandCitySignText1
	dw SeviiTwoIslandCitySignText2
	dw SeviiTwoIslandCitySignText3
	dw SeviiTwoIslandCitySignText4
	dw PokeCenterSignText ; 18
	; scripts
	dw SeviiTwoIslandCityScriptText1 ; 19 ; Boss post defeat

; scripts =========================================

SeviiTwoIslandCity_NullScript:
	ret

SeviiTwoIslandCity_PostVictoryVsBikerBoss:
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTwoIslandCityResetScripts
	ld a, $f0
	ld [wJoyIgnore], a
; we won
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide all the bikers
	call GBFadeOutToBlack
	ld a, HS_SEVII_ROUTE_33_BIKER_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ROUTE_33_BIKER_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ROUTE_33_BIKER_3
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ROUTE_33_BIKER_4
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_TWO_ISLAND_CITY_BIKER
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp SeviiTwoIslandCityResetScripts

SeviiTwoIslandCityResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiTwoIslandCityText1:
	text_far _SeviiTwoIslandCityText1
	text_end

SeviiTwoIslandCityText2:
	text_far _SeviiTwoIslandCityText2
	text_end

SeviiTwoIslandCityText3:
	text_far _SeviiTwoIslandCityText3
	text_end

SeviiTwoIslandCityText4:
	text_far _SeviiTwoIslandCityText4
	text_end

SeviiTwoIslandCityText5:
	text_far _SeviiTwoIslandCityText5
	text_end

SeviiTwoIslandCityText6:
	text_far _SeviiTwoIslandCityText6
	text_end

SeviiTwoIslandCityText7:
	text_far _SeviiTwoIslandCityText7
	text_end

SeviiTwoIslandCityText8:
	text_asm
	CheckEvent EVENT_SEVII_SPOKEN_WITH_RIDERS
	jr nz, .spokenWithGoons
	ld hl, SeviiTwoIslandCityText8_BeforeRiders
	call PrintText
	jr .done
.spokenWithGoons
	ld c, BANK(Music_MeetEvilTrainer)
	ld a, MUSIC_MEET_EVIL_TRAINER
	call PlayMusic
	ld hl, SeviiTwoIslandCityText8_AfterRiders
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_CUE_BALL
	ld [wCurOpponent], a
	ld a, 10
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, SeviiTwoIslandBikersBoosDefeatedText
	ld de, SeviiTwoIslandBikersBoosDefeatedText
	call SaveEndBattleTextPointers
	ld a, 1
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

SeviiTwoIslandCityText8_BeforeRiders:
	text_far _SeviiTwoIslandCityText8_BeforeRiders
	text_end

SeviiTwoIslandCityText8_AfterRiders:
	text_far _SeviiTwoIslandCityText8_AfterRiders
	text_end

SeviiTwoIslandBikersBoosDefeatedText:
	text_far _SeviiTwoIslandBikersBoosDefeatedText
	text_end

SeviiTwoIslandCityText9:
SeviiTwoIslandCityText10:
	text_far _SeviiTwoIslandCityText10
	text_end

SeviiTwoIslandCitySignText1:
	text_far _SeviiTwoIslandCitySignText1
	text_end

SeviiTwoIslandCitySignText2:
	text_far _SeviiTwoIslandCitySignText2
	text_end

SeviiTwoIslandCitySignText3:
	text_far _SeviiTwoIslandCitySignText3
	text_end

SeviiTwoIslandCitySignText4:
	text_far _SeviiTwoIslandCitySignText4
	text_end

SeviiTwoIslandCityScriptText1:
	text_far _SeviiTwoIslandCityScriptText1
	text_end
