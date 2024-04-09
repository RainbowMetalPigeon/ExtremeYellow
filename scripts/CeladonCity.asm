CeladonCity_Script:
	; new, to open path to Lunar Temple after its events
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, CeladonCityHideShowLunarTemplePath
	; end of Lunar temple stuff
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, CeladonCity_ScriptPointers
	ld a, [wCeladonCityCurScript]
	call CallFunctionInTable
	ret

CeladonCityHideShowLunarTemplePath:
	CheckEvent EVENT_RETURNED_LUNAR_RELIC
	jr nz, .openPath	; if yes, open path
	ld a, 229			; ledge block ID
	jr .replaceBlock
.openPath
	ld a, 10			; clear path block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 5, 5 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock

CeladonCity_ScriptPointers:
	dw CeladonCityScript0
	dw CeladonScript_Traveler ; new, for traveler
	dw CeladonCityScript2 ; new, to hide Uni guard

CeladonCityScript0: ; edited, for Uni entry quiz
	ret

CeladonCityScript2:
	call GBFadeOutToBlack
	ld a, HS_CELADON_UNI_GUARD
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	xor a
	ld [wCeladonCityCurScript], a
	ld [wCurMapScript], a
	ret

; ================================

CeladonCity_TextPointers:
	dw CeladonCityText1
	dw CeladonCityText2
	dw CeladonCityText3
	dw CeladonCityText4
	dw CeladonCityText5
	dw CeladonCityText6
	dw CeladonCityText7
	dw CeladonCityText8
	dw CeladonCityText9
	dw CeladonCityText10New
	dw CeladonCityText11New
	dw TextPreBattle_CeladonTraveler ; new, for traveler
	dw PickUpItemText ; new, Rare Candy for Lunar Shrine teasing
	; signs
	dw CeladonCityText10
	dw CeladonCityText11
	dw PokeCenterSignText
	dw CeladonCityText13
	dw CeladonCityText14
	dw CeladonCityText15
	dw CeladonCityText16
	dw CeladonCityText17
	dw CeladonCityText18
	dw CeladonCityText19 ; new
	dw CeladonCityText20 ; new
	dw CeladonCityText21 ; new
	dw TextPostBattle_CeladonTraveler ; 26, new, for traveler
	dw CeladonCityTextUniQuizQuestion1 ; 27
	dw CeladonCityTextUniQuizQuestion2 ; 28
	dw CeladonCityTextUniQuizQuestion3 ; 29
	dw CeladonCityTextUniQuizWrong ; 30
	dw CeladonCityTextUniQuizCorrect ; 31

CeladonCityText10New:
	text_far _CeladonCityText10New
	text_end

CeladonCityText11New:
	text_far _CeladonCityText11New
	text_end

CeladonCityText1:
	text_far _CeladonCityText1
	text_end

CeladonCityText2: ; edited
	text_asm
	call SaveScreenTilesToBuffer2
	CheckEvent EVENT_UNI_QUIZ_ANSWERED_WRONGLY_2
	jr nz, .question3
	CheckEvent EVENT_UNI_QUIZ_ANSWERED_WRONGLY_1
	jr nz, .question2
	; first time
	ld hl, CeladonCityTextUniQuizQuestion1
	jr .continue
.question2
	ld hl, CeladonCityTextUniQuizQuestion2
	jr .continue
.question3
	ld hl, CeladonCityTextUniQuizQuestion3
	jr .continue
.continue
	call PrintText
	farcall DisplayUniQuizScreen
; check the answer
	ld a, [wUniQuizAnswer]
	cp "U"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+1]
	cp "N"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+2]
	cp "I"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+3]
	cp "U"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+4]
	cp "N"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+5]
	cp "I"
	jr nz, .wrongAnswer
	ld a, [wUniQuizAnswer+6]
	cp "@"
	jr nz, .wrongAnswer
; right answer
	ld hl, CeladonCityTextUniQuizCorrect
	call PrintText
; script handling
	ld a, 2
	ld [wCeladonCityCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
.wrongAnswer
	CheckAndSetEvent EVENT_UNI_QUIZ_ANSWERED_WRONGLY_1
	jr z, .firstWrong
	SetEvent EVENT_UNI_QUIZ_ANSWERED_WRONGLY_2
.firstWrong
	ld hl, CeladonCityTextUniQuizWrong
	call PrintText
	jp TextScriptEnd

CeladonCityText3:
	text_far _CeladonCityText3
	text_end

CeladonCityText4:
	text_far _CeladonCityText4
	text_end

CeladonCityText5:
	text_asm
	CheckEvent EVENT_GOT_TM41
	jr nz, .asm_7053f
	ld hl, TM41PreText
	call PrintText
	lb bc, TM_BRAVE_BIRD, 1
	call GiveItem
	jr c, .Success
	ld hl, TM41NoRoomText
	call PrintText
	jr .Done
.Success
	ld hl, ReceivedTM41Text
	call PrintText
	SetEvent EVENT_GOT_TM41
	jr .Done
.asm_7053f
	ld hl, TM41ExplanationText
	call PrintText
.Done
	jp TextScriptEnd

TM41PreText:
	text_far _TM41PreText
	text_end

ReceivedTM41Text:
	text_far _ReceivedTM41Text
	sound_get_item_1
	text_end

TM41ExplanationText:
	text_far _TM41ExplanationText
	text_end

TM41NoRoomText:
	text_far _TM41NoRoomText
	text_end

CeladonCityText6:
	text_far _CeladonCityText6
	text_end

CeladonCityText7:
	text_far _CeladonCityText7
	text_asm
	ld a, POLIWRATH
	call PlayCry
	jp TextScriptEnd

CeladonCityText8:
	text_far _CeladonCityText8
	text_end

CeladonCityText9:
	text_far _CeladonCityText9
	text_end

CeladonCityText10:
	text_asm
	farcall Func_f1ac6
	jp TextScriptEnd

CeladonCityText11:
	text_far _CeladonCityText11
	text_end

CeladonCityText13:
	text_far _CeladonCityText13
	text_end

CeladonCityText14:
	text_far _CeladonCityText14
	text_end

CeladonCityText15:
	text_far _CeladonCityText15
	text_end

CeladonCityText16:
	text_far _CeladonCityText16
	text_end

CeladonCityText17:
	text_far _CeladonCityText17
	text_end

CeladonCityText18:
	text_far _CeladonCityText18
	text_end

CeladonCityText19: ; new
	text_far _CeladonCityText19
	text_end

CeladonCityText20: ; new
	text_far _CeladonCityText20
	text_end

CeladonCityText21: ; new
	text_far _CeladonCityText21
	text_end

CeladonCityTextUniQuizQuestion1: ; new
	text_far _CeladonCityTextUniQuizQuestion1
	text_end

CeladonCityTextUniQuizQuestion2: ; new
	text_far _CeladonCityTextUniQuizQuestion2
	text_end

CeladonCityTextUniQuizQuestion3: ; new
	text_far _CeladonCityTextUniQuizQuestion3
	text_end

CeladonCityTextUniQuizWrong: ; new
	text_far _CeladonCityTextUniQuizWrong
	text_end

CeladonCityTextUniQuizCorrect: ; new
	text_far _CeladonCityTextUniQuizCorrect
	text_end

; ================================

TextPreBattle_CeladonTraveler: ; new
	text_asm
	ld hl, Text_Intro_CeladonTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_CeladonTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_CeladonTraveler
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
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, Text_DefeatPostBattle_CeladonTraveler
	ld de, Text_VictoryPostBattle_CeladonTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wCeladonCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_CeladonTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_CeladonTraveler
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
	ld hl, Text_WhatWasThat_CeladonTraveler
	call PrintText
	; script handling
	xor a
	ld [wCeladonCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

CeladonScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wCeladonCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_CELADON_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObject ; city-specific
	ld a, 26 ; city-specific
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

Text_Intro_CeladonTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_CeladonTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_CeladonTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_CeladonTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_CeladonTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_CeladonTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_CeladonTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
