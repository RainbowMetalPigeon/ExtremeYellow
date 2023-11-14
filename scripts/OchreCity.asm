OchreCity_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld de, OchreCity_ScriptPointers
	ld a, [wOchreCityCurScript]
	call ExecuteCurMapScriptInTable
	ld [wOchreCityCurScript], a
	ret

OchreCity_ScriptPointers: ; new, for traveler
	dw OchreScript0
	dw OchreScript_Traveler

OchreScript0:
	ret

OchreCity_TextPointers:
	; NPCs
	dw OchreCity_NPCText1
	dw OchreCity_NPCText2
	dw OchreCity_NPCText3
	dw OchreCity_NPCText4
	dw OchreCity_NPCText5
	dw OchreCity_NPCText6
	dw OchreCity_NPCText7
	dw OchreCity_NPCText8
	dw OchreCity_NPCText9
	dw TextPreBattle_OchreTraveler ; new, for traveler
	dw OchreCity_NPCText11
	dw OchreCity_NPCText12
	dw OchreCity_NPCText13
	dw OchreCity_NPCText14
	; signs
	dw MartSignText
	dw PokeCenterSignText
	dw OchreCity_SignCity
	dw OchreCity_SignGym
	dw OchreCity_SignRehabilitation
	dw OchreCity_SignParkAndSquare
	dw OchreCity_SignResearch
	dw OchreCity_SignBirbFan
	dw TextPostBattle_OchreTraveler ; 23, new, for traveler

; -------------- NPCs texts --------------

OchreCity_NPCText1:
	text_far _OchreCity_NPCText1
	text_end

OchreCity_NPCText2:
	text_far _OchreCity_NPCText2
	text_end

OchreCity_NPCText3:
	text_far _OchreCity_NPCText3
	text_end

OchreCity_NPCText4:
	text_far _OchreCity_NPCText4
	text_end

OchreCity_NPCText5:
	text_far _OchreCity_NPCText5
	text_end

OchreCity_NPCText6:
	text_far _OchreCity_NPCText6
	text_end

OchreCity_NPCText7:
	text_far _OchreCity_NPCText7
	text_end

OchreCity_NPCText8:
	text_far _OchreCity_NPCText8
	text_end

OchreCity_NPCText9:
	text_far _OchreCity_NPCText9
	text_end

;OchreCity_NPCText10:
;	text_far _OchreCity_NPCText10
;	text_end

OchreCity_NPCText11:
	text_far _OchreCity_NPCText11
	text_end

OchreCity_NPCText12:
	text_far _OchreCity_NPCText12
	text_end

OchreCity_NPCText13:
	text_far _OchreCity_NPCText13
	text_end

OchreCity_NPCText14:
	text_far _OchreCity_NPCText14
	text_end

; -------------- signs texts --------------

OchreCity_SignCity:
	text_far _OchreCity_SignCity
	text_end

OchreCity_SignGym:
	text_far _OchreCity_SignGym
	text_end

OchreCity_SignRehabilitation:
	text_far _OchreCity_SignRehabilitation
	text_end

OchreCity_SignParkAndSquare:
	text_far _OchreCity_SignParkAndSquare
	text_end

OchreCity_SignResearch:
	text_far _OchreCity_SignResearch
	text_end

OchreCity_SignBirbFan:
	text_far _OchreCity_SignBirbFan
	text_end

; ================================

TextPreBattle_OchreTraveler: ; new
	text_asm 
	ld hl, Text_Intro_OchreTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_OchreTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_OchreTraveler
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
	ld hl, Text_DefeatPostBattle_OchreTraveler
	ld de, Text_VictoryPostBattle_OchreTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_OchreTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_OchreTraveler
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
	ld hl, Text_WhatWasThat_OchreTraveler
	call PrintText
	; script handling
	xor a
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

OchreScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wOchreCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_OCHRE_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 23 ; city-specific
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

Text_Intro_OchreTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_OchreTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_OchreTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_OchreTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_OchreTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_OchreTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_OchreTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
