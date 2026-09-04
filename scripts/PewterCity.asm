PewterCity_Script:
	RPTextChooser PewterCity_TextPointers, PewterCity_TextPointers_Rocket
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, wd492
	res 7, [hl]
	ld hl, PewterCity_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call CallFunctionInTable
	ret

PewterCity_ScriptPointers:
	dw PewterCityScript0
	dw PewterScript_Traveler ; new, for traveler

PewterCityScript0: ; edited for RP
	CheckEvent EVENT_ROCKET_PATH
	ret nz
	xor a
	ld [wMuseum1FCurScript], a
	ResetEvent EVENT_BOUGHT_MUSEUM_TICKET
	ret

PewterCity_TextPointers:
	dw PewterCityText1
	dw PewterCityText2
	dw PewterCityText3
	dw PewterCityText4
	dw PewterCityText5
	dw PewterCityTextNewRoute ; new
	dw TextPreBattle_PewterTraveler ; new, for traveler
	dw PewterCityCoinCaseMeowthText ; new, Meowth
	; signs
	dw PewterCityText6
	dw PewterCityText7
	dw MartSignText
	dw PokeCenterSignText
	dw PewterCityText10
	dw PewterCityText11
	dw PewterCityText12
	; scripts
	dw TextPostBattle_PewterTraveler ; 16, new, for traveler

PewterCity_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw TextPreBattle_PewterTraveler_RP
	dw PewterCityCoinCaseMeowthText ; Meowth, unused
	; signs
	dw PewterCityText6
	dw PewterCityText7
	dw MartSignText
	dw PokeCenterSignText
	dw PewterCityText10
	dw PewterCityText11
	dw PewterCityText12 ; 15
	; scripts
	dw TextPostBattle_PewterTraveler_RP ; 16, for traveler

PewterCityText1:
	text_far _PewterCityText1
	text_end

PewterCityText2:
	text_far _PewterCityText2
	text_end

PewterCityText3:
	text_asm
	ld hl, PewterCityText_193f1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .playerDidNotGoIntoMuseum
	ld hl, PewterCityText_193f6
	call PrintText
	jr .done
.playerDidNotGoIntoMuseum
	ld hl, PewterCityText_193fb
	call PrintText
.done
	jp TextScriptEnd

PewterCityText_193f1:
	text_far _PewterCityText_193f1
	text_end

PewterCityText_193f6:
	text_far _PewterCityText_193f6
	text_end

PewterCityText_193fb:
	text_far _PewterCityText_193fb
	text_end

;PewterCityText13:
;	text_far _PewterCityText13
;	text_end

PewterCityText4: ; edited
	text_asm
	CheckEvent EVENT_GOT_PEWTER_REPELS
	jr z, .didntGetRepelYet
	ld hl, PewterCityText_RepelToCross
	call PrintText
	jr .done
.didntGetRepelYet
	ld hl, PewterCityText_DoYouKnow
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp $0
	jr nz, .playerDoesNotKnow
	ld hl, PewterCityText_HardWork
	call PrintText
	jr .done
.playerDoesNotKnow
	ld hl, PewterCityText_Spraying
	call PrintText
	lb bc, REPEL, 5
	call GiveItem
	jr nc, .bag_full
	SetEvent EVENT_GOT_PEWTER_REPELS
	ld hl, PewterCityText_GotRepel
	call PrintText
	jr .done
.bag_full
	ld hl, PewterCityText_BagFull
	call PrintText
.done
	jp TextScriptEnd

PewterCityText_DoYouKnow:
	text_far _PewterCityText_DoYouKnow
	text_end

PewterCityText_HardWork:
	text_far _PewterCityText_HardWork
	text_end

PewterCityText_Spraying:
	text_far _PewterCityText_Spraying
	text_end

PewterCityText_GotRepel: ; new
	text_far _PewterCityText_GotRepel
	sound_get_item_1
	text_end

PewterCityText_BagFull: ; new
	text_far _PewterCityText_BagFull
	text_end

PewterCityText_RepelToCross: ; new
	text_far _PewterCityText_RepelToCross
	text_end

PewterCityText5:
	text_asm
	ld hl, PewterCityText_1945d
	CheckEvent EVENT_BEAT_BROCK
	jr z, .continue
	ld hl, PewterCityText_1945dBis
.continue
	call PrintText
	jp TextScriptEnd

PewterCityTextNewRoute:
	text_far _PewterCityTextNewRoute
	text_end

PewterCityText_1945d:
	text_far _PewterCityText_1945d
	text_end

PewterCityText_1945dBis:
	text_far _PewterCityText_1945dBis
	text_end

;PewterCityText14:
;	text_far _PewterCityText14
;	text_end

PewterCityText6:
	text_far _PewterCityText6
	text_end

PewterCityText7:
	text_far _PewterCityText7
	text_end

PewterCityText10:
	text_far _PewterCityText10
	text_end

PewterCityText11:
	text_far _PewterCityText11
	text_end

PewterCityText12:
	text_far _PewterCityText12
	text_end

; ================================

TextPreBattle_PewterTraveler: ; new
	text_asm
	callfar TravelerCommonPreBattleText
	jp c, TextScriptEnd
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_PewterTraveler:
	text_asm
	callfar TravelerCommonPostBattleText
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

PewterScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wCurMapScript], a
	ret
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_PEWTER_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 16 ; city-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; make the traveler run away to search Mega Mewtwo
	call GBFadeOutToBlack
    callfar LoopHideTraveler
    callfar LoopHideTravelerExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ret

; ================================

PewterCityCoinCaseMeowthText:
	text_far _Route30CoinCaseMeowthText_Miao
	text_asm
	ld a, MEOWTH
	call PlayCry
	call WaitForSoundToFinish
	call WaitForTextScrollButtonPress

	call GBFadeOutToBlack

	ld a, HS_PEWTER_CITY_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_ROUTE_22_COIN_CASE_MEOWTH
	ld [wMissableObjectIndex], a
	predef ShowObject

	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack

	ld hl, PewterCityCoinCaseMeowthText_HintNext
	call PrintText

	jp TextScriptEnd

PewterCityCoinCaseMeowthText_HintNext:
	text_far _PewterCityCoinCaseMeowthText_HintNext
	text_end

; new for RP ============================

TextPreBattle_PewterTraveler_RP:
	text_asm
	callfar TravelerCommonPreBattleText_RP
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_PewterTraveler_RP:
	text_asm
	callfar TravelerCommonPostBattleText_RP
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd
