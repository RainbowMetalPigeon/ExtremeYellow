CeladonCity_Script:
	RPTextChooser CeladonCity_TextPointers, CeladonCity_TextPointers_Rocket
; new, to open path to Lunar Temple after its events
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, CeladonCityHideShowLunarTemplePath
; end of Lunar temple stuff
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, CeladonCity_ScriptPointers
	ld a, [wCurMapScript]
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
	ld [wCurMapScript], a
	ret

; ================================

CeladonCity_TextPointers:
	dw CeladonCityText1
	dw CeladonCityText2 ; Uni guard
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
	dw CeladonCityText22 ; new
	; scripts
	dw TextPostBattle_CeladonTraveler ; 27, new, for traveler
	; unnecessary?
	dw CeladonCityTextUniQuizQuestion1 ; 28
	dw CeladonCityTextUniQuizQuestion2 ; 29
	dw CeladonCityTextUniQuizQuestion3 ; 30
	dw CeladonCityTextUniQuizWrong ; 31
	dw CeladonCityTextUniQuizCorrect ; 32

CeladonCity_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw CeladonCityText2_RP ; Uni guard
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw CeladonCityText7 ; monster
	dw RocketNPCText_RocketPath ; Rocket
	dw RocketNPCText_RocketPath ; Rocket
	dw CeladonCityText10New_RP ; Rocket guards
	dw CeladonCityText11New_RP ; Rocket guards
	dw TextPreBattle_CeladonTraveler_RP ; for traveler
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
	dw CeladonCityText22 ; new
	; scripts
	dw TextPostBattle_CeladonTraveler_RP ; 27, for traveler

CeladonCityText10New:
	text_far _CeladonCityText10New
	text_end

CeladonCityText11New:
	text_far _CeladonCityText11New
	text_end

CeladonCityText10New_RP: ; new for RP
	text_far _CeladonCityText10New_RP
	text_end

CeladonCityText11New_RP: ; new for RP
	text_far _CeladonCityText11New_RP
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

CeladonCityText22: ; new
	text_far _CeladonCityText22
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
	callfar TravelerCommonPreBattleText
	jp c, TextScriptEnd
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_CeladonTraveler:
	text_asm
	callfar TravelerCommonPostBattleText
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

CeladonScript_Traveler:
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
    ld a, HS_CELADON_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObject ; city-specific
	ld a, 27 ; city-specific
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

; ================================

CeladonCityText2_RP:
	text_asm
	ld hl, CeladonCityText2_RP_Beating
	call PrintText
; script handling
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd

CeladonCityText2_RP_Beating:
	text_far _CeladonCityText2_RP_Beating
	text_end

TextPreBattle_CeladonTraveler_RP:
	text_asm
	callfar TravelerCommonPreBattleText_RP
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_CeladonTraveler_RP:
	text_asm
	callfar TravelerCommonPostBattleText_RP
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd
