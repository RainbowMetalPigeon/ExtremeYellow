ObsidianIsland_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, ObsidianIsland_ScriptPointers
	ld a, [wObsidianIslandCurScript]
	call CallFunctionInTable
	ret

ObsidianIsland_ScriptPointers:
	dw ObsidianIslandScript0
	dw ObsidianIslandScript1
	dw ObsidianScript_Traveler ; new, for traveler
	
ObsidianIslandScript0:
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	ret nz
	ld hl, CoordsData_ObsidianHouses
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
	ld a, PLAYER_DIR_UP
	ld [wPlayerMovingDirection], a
	ld a, $17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ld a, $1
	ld [wObsidianIslandCurScript], a
	ret

ObsidianIslandScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, $0
	ld [wObsidianIslandCurScript], a
	ret

CoordsData_ObsidianHouses:
	dbmapcoord 17,  4
	dbmapcoord 35,  22
	dbmapcoord 35,  26
	dbmapcoord 35,  12 ; mart
	db -1 ; end

ObsidianIsland_TextPointers:
	; before Giovanni's defeat
	dw ObsidianIslandText1_RocketMines
	dw ObsidianIslandText2_RocketSouthBridge1
	dw ObsidianIslandText3_RocketSouthBridge2
	dw ObsidianIslandText5_SouthBridgeSlave1
	dw ObsidianIslandText6_SouthBridgeSlave2
	; after Giovanni's defeat
	dw ObsidianIslandText7_Scientist1
	dw ObsidianIslandText8_Scientist2
	dw ObsidianIslandText9_Officier
	dw ObsidianIslandText10_Citizen1
	dw ObsidianIslandText11_Citizen2
	dw ObsidianIslandText12_Citizen3
	dw ObsidianIslandText13_Citizen4
	dw TextPreBattle_ObsidianTraveler ; new, for traveler
	; item
	dw PickUpItemText
	; signs
	dw ObsidianIslandTextTest ; welcome
	dw PokeCenterSignText
	dw MartSignText
	dw ObsidianIslandTextTest ; pier
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; forest
	dw ObsidianIslandTextTest ; mines
	dw ObsidianIslandTextTest ; warehouse
	; other
	dw ObsidianIslandTextClosedHouse ; 23 = $17
	dw TextPostBattle_ObsidianTraveler ; 24, new, for traveler

; ----------------- people -----------------

ObsidianIslandText1_RocketMines:
ObsidianIslandText2_RocketSouthBridge1:
ObsidianIslandText3_RocketSouthBridge2:
ObsidianIslandText5_SouthBridgeSlave1:
ObsidianIslandText6_SouthBridgeSlave2:
ObsidianIslandText7_Scientist1:
ObsidianIslandText8_Scientist2:
ObsidianIslandText9_Officier:
ObsidianIslandText10_Citizen1:
ObsidianIslandText11_Citizen2:
ObsidianIslandText12_Citizen3:
ObsidianIslandText13_Citizen4:
	text_far _ObsidianIslandTextTestHuman
	text_end

; ----------------- signs -----------------

ObsidianIslandTextTest:
	text_far _ObsidianIslandTextTest
	text_end

; ----------------- other -----------------

ObsidianIslandTextClosedHouse:
	text_far _ObsidianIslandTextClosedHouse
	text_end

; ================================

TextPreBattle_ObsidianTraveler: ; new
	text_asm 
	ld hl, Text_Intro_ObsidianTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_ObsidianTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_ObsidianTraveler
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
	ld hl, Text_DefeatPostBattle_ObsidianTraveler
	ld de, Text_VictoryPostBattle_ObsidianTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 2 ; city-specific
	ld [wObsidianIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_ObsidianTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_ObsidianTraveler
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
	ld hl, Text_WhatWasThat_ObsidianTraveler
	call PrintText
	; script handling
	xor a
	ld [wObsidianIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

ObsidianScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wObsidianIslandCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_OBSIDIAN_ISLAND_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 24 ; city-specific
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

Text_Intro_ObsidianTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_ObsidianTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_ObsidianTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_ObsidianTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_ObsidianTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_ObsidianTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_ObsidianTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
