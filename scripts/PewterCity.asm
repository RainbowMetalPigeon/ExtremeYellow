PewterCity_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, wd492
	res 7, [hl]
	ld hl, PewterCity_ScriptPointers
	ld a, [wPewterCityCurScript]
	call CallFunctionInTable
	ret

PewterCity_ScriptPointers:
	dw PewterCityScript0
;	dw PewterCityScript1
;	dw PewterCityScript2
;	dw PewterCityScript3
;	dw PewterCityScript4
;	dw PewterCityScript5
;	dw PewterCityScript6
	dw PewterScript_Traveler ; new, for traveler

PewterCityScript0:
	xor a
	ld [wMuseum1FCurScript], a
	ResetEvent EVENT_BOUGHT_MUSEUM_TICKET
	ret

;PewterCityScript1:
;PewterCityScript2:
;PewterCityScript3:
;PewterCityScript4:
;PewterCityScript5:
;PewterCityScript6:
;	ret

PewterCity_TextPointers:
	dw PewterCityText1
	dw PewterCityText2
	dw PewterCityText3
	dw PewterCityText4
	dw PewterCityText5
	dw PewterCityTextNewRoute ; new
	dw TextPreBattle_PewterTraveler ; new, for traveler
	; signs
	dw PewterCityText6
	dw PewterCityText7
	dw MartSignText
	dw PokeCenterSignText
	dw PewterCityText10
	dw PewterCityText11
	dw PewterCityText12
	dw TextPostBattle_PewterTraveler ; 15, new, for traveler

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

PewterCityText4:
	text_asm
	ld hl, PewterCityText_19427
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	cp $0
	jr nz, .playerDoesNotKnow
	ld hl, PewterCityText_1942c
	call PrintText
	jr .done
.playerDoesNotKnow
	ld hl, PewterCityText_19431
	call PrintText
.done
	jp TextScriptEnd

PewterCityText_19427:
	text_far _PewterCityText_19427
	text_end

PewterCityText_1942c:
	text_far _PewterCityText_1942c
	text_end

PewterCityText_19431:
	text_far _PewterCityText_19431
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
	ld hl, Text_Intro_PewterTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_PewterTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_PewterTraveler
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic
	call Delay3
	ld a, OPP_TRAVELER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld hl, Text_DefeatPostBattle_PewterTraveler
	ld de, Text_VictoryPostBattle_PewterTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wPewterCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_PewterTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_PewterTraveler
	call PrintText
	call GBFadeOutToBlack
    ld a, SFX_PUSH_BOULDER
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	call GBFadeOutToBlack
	call GBFadeInFromBlack
	call GBFadeOutToBlack
    ld a, SFX_GO_INSIDE
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	ld hl, Text_WhatWasThat_PewterTraveler
	call PrintText
	; script handling
	xor a
	ld [wPewterCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

PewterScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wPewterCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_PEWTER_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObject ; city-specific
	ld a, 15 ; city-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; make the traveler run away to search Mega Mewtwo
	call GBFadeOutToBlack
    callfar LoopHideTraveler
    callfar LoopHideTravelerExtra
	ld a, HS_CERULEAN_CAVE_B1F_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ret

; --------------------------------

Text_Intro_PewterTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_PewterTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_PewterTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_PewterTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_PewterTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_PewterTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_PewterTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
