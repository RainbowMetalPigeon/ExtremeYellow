CinnabarIsland_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
;	ld hl, wCurrentMapScriptFlags	; unused
;	set 5, [hl]						; unused
	ResetEvent EVENT_MANSION_SWITCH_ON
	ResetEvent EVENT_LAB_STILL_REVIVING_FOSSIL
	ld hl, CinnabarIsland_ScriptPointers
	ld a, [wCinnabarIslandCurScript]
	jp CallFunctionInTable

CinnabarIsland_ScriptPointers:
	dw CinnabarIslandScript0
	dw CinnabarIslandScript1
	dw CinnabarScript_Traveler ; new, for traveler

CinnabarIslandScript0:
	ld b, SECRET_KEY
	call IsItemInBag
	ret nz
	ld a, [wYCoord]
	cp 4
	ret nz
	ld a, [wXCoord]
	cp 48 ; edited
	ret nz
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ld a, $1
	ld [wCinnabarIslandCurScript], a
	ret

CinnabarIslandScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, $0
	ld [wCinnabarIslandCurScript], a
	ret

CinnabarIsland_TextPointers:
	dw CinnabarIslandText1
	dw CinnabarIslandText2
	dw CinnabarIslandTextNewPerson1 ; new
	dw CinnabarIslandTextNewPerson2 ; new
	dw CinnabarIslandTextNewPerson3 ; new
	dw CinnabarIslandTextNewPerson4 ; new
	dw CinnabarIslandTextNewPerson5 ; new
	dw CinnabarIslandTextNewPerson6 ; new
	dw CinnabarIslandTextNewPerson7 ; new
	dw CinnabarIslandTextNewPerson8 ; new
	dw TextPreBattle_CinnabarTraveler ; new, for traveler
	dw CinnabarIslandText3
	dw MartSignText
	dw PokeCenterSignText
	dw CinnabarIslandText6
	dw CinnabarIslandText7
	dw CinnabarIslandTextVulcano ; new
	dw CinnabarIslandTextGymDoor ; 18
	dw TextPostBattle_CinnabarTraveler ; 19, new, for traveler

CinnabarIslandTextGymDoor:
	text_far _CinnabarIslandTextGymDoor
	text_end

CinnabarIslandText1:
	text_far _CinnabarIslandText1
	text_end

CinnabarIslandText2:
	text_far _CinnabarIslandText2
	text_end

CinnabarIslandText3:
	text_far _CinnabarIslandText3
	text_end

CinnabarIslandText6:
	text_far _CinnabarIslandText6
	text_end

CinnabarIslandText7:
	text_far _CinnabarIslandText7
	text_end

; new -----

CinnabarIslandTextNewPerson1:
	text_far _CinnabarIslandTextNewPerson1
	text_end

CinnabarIslandTextNewPerson2:
	text_far _CinnabarIslandTextNewPerson2
	text_end

CinnabarIslandTextNewPerson3:
	text_far _CinnabarIslandTextNewPerson3
	text_end

CinnabarIslandTextNewPerson4:
	text_far _CinnabarIslandTextNewPerson4
	text_end

CinnabarIslandTextVulcano:
	text_far _CinnabarIslandTextVulcano
	text_end

CinnabarIslandTextNewPerson5:
	text_far _CinnabarIslandTextNewPerson5
	text_end

CinnabarIslandTextNewPerson6:
	text_far _CinnabarIslandTextNewPerson6
	text_end

CinnabarIslandTextNewPerson7:
	text_far _CinnabarIslandTextNewPerson7
	text_end

CinnabarIslandTextNewPerson8:
	text_far _CinnabarIslandTextNewPerson8
	text_end

; ================================

TextPreBattle_CinnabarTraveler: ; new
	text_asm 
	ld hl, Text_Intro_CinnabarTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_CinnabarTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_CinnabarTraveler
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
	ld hl, Text_DefeatPostBattle_CinnabarTraveler
	ld de, Text_VictoryPostBattle_CinnabarTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 2 ; city-specific
	ld [wCinnabarIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_CinnabarTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_CinnabarTraveler
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
	ld hl, Text_WhatWasThat_CinnabarTraveler
	call PrintText
	; script handling
	xor a
	ld [wCinnabarIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

CinnabarScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wCinnabarIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_CINNABAR_ISLAND_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 19 ; city-specific
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

Text_Intro_CinnabarTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_CinnabarTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_CinnabarTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_CinnabarTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_CinnabarTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_CinnabarTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_CinnabarTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
