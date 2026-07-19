SaffronCity_Script:
	RPTextChooser SaffronCity_TextPointers, SaffronCity_TextPointers_Rocket
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld de, SaffronCity_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SaffronCity_ScriptPointers: ; new, for traveler
	dw SaffronScript0
	dw SaffronScript_Traveler

SaffronScript0:
	ret

SaffronCity_TextPointers:
	dw SaffronCityText1
	dw SaffronCityText2
	dw SaffronCityText3
	dw SaffronCityText4
	dw SaffronCityText5
	dw TextPreBattle_SaffronTraveler ; new/edited, for traveler
	dw SaffronCityText7
	dw SaffronCityText8
	dw SaffronCityText9
	dw SaffronCityText10
	dw SaffronCityText11
	dw SaffronCityText12
	dw SaffronCityText13
	dw SaffronCityText14
	; signs
	dw SaffronCityText16
	dw SaffronCityText17
	dw SaffronCityText18
	dw MartSignText
	dw SaffronCityText20
	dw SaffronCityText21
	dw SaffronCityText22
	dw PokeCenterSignText
	dw SaffronCityText24
	dw SaffronCityText25
	dw SaffronCityText26 ; new sign for Climb Club
	; scripts
	dw TextPostBattle_SaffronTraveler ; new, for traveler

SaffronCity_TextPointers_Rocket:
	dw SaffronCityText_BlockingRocket_RP ; blocking building
	dw RocketNPCText_RocketPath
	dw SaffronCityText_BlockingRocket_RP ; blocking building
	dw SaffronCityText_BlockingRocket_RP ; blocking building
	dw SaffronCityText_BlockingRocket_RP ; blocking building
	dw TextPreBattle_SaffronTraveler ; TBE
	dw RocketNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw SaffronCityText12 ; Mon
	dw GenericNPCText_RocketPath
	dw SaffronCityText_BlockingSilph_RP ; blocking Silph
	; signs
	dw SaffronCityText16
	dw SaffronCityText17
	dw SaffronCityText18
	dw MartSignText
	dw SaffronCityText20
	dw SaffronCityText21
	dw SaffronCityText22
	dw PokeCenterSignText
	dw SaffronCityText24
	dw SaffronCityText25
	dw SaffronCityText26

SaffronCityText1:
	text_far _SaffronCityText1
	text_end

SaffronCityText2:
	text_far _SaffronCityText2
	text_end

SaffronCityText3:
	text_far _SaffronCityText3
	text_end

SaffronCityText4:
	text_far _SaffronCityText4
	text_end

SaffronCityText5:
	text_far _SaffronCityText5
	text_end

;SaffronCityText6:
;	text_far _SaffronCityText6
;	text_end

SaffronCityText7:
	text_far _SaffronCityText7
	text_end

SaffronCityText8:
	text_far _SaffronCityText8
	text_end

SaffronCityText9:
	text_far _SaffronCityText9
	text_end

SaffronCityText10:
	text_far _SaffronCityText10
	text_end

SaffronCityText11:
	text_far _SaffronCityText11
	text_end

SaffronCityText12:
	text_far _SaffronCityText12
	sound_cry_pidgeot
	text_end

SaffronCityText13:
	text_far _SaffronCityText13
	text_end

SaffronCityText14:
	text_far _SaffronCityText14
	text_end

;SaffronCityText15:
;	text_far _SaffronCityText15
;	text_end

SaffronCityText16:
	text_far _SaffronCityText16
	text_end

SaffronCityText17:
	text_far _SaffronCityText17
	text_end

SaffronCityText18:
	text_far _SaffronCityText18
	text_end

SaffronCityText20:
	text_far _SaffronCityText20
	text_end

SaffronCityText21:
	text_far _SaffronCityText21
	text_end

SaffronCityText22:
	text_far _SaffronCityText22
	text_end

SaffronCityText24:
	text_far _SaffronCityText24
	text_end

SaffronCityText25:
	text_far _SaffronCityText25
	text_end

SaffronCityText26:
	text_far _SaffronCityText26
	text_end

; ================================

TextPreBattle_SaffronTraveler: ; new
	text_asm
	ld hl, Text_Intro_SaffronTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_SaffronTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_SaffronTraveler
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic
	set 6, [hl] ; battle style set
	call Delay3
	ld a, OPP_TRAVELER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld hl, Text_DefeatPostBattle_SaffronTraveler
	ld de, Text_VictoryPostBattle_SaffronTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_SaffronTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_SaffronTraveler
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
	ld hl, Text_WhatWasThat_SaffronTraveler
	call PrintText
	; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

SaffronScript_Traveler:
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
    ld a, HS_SAFFRON_CITY_TRAVELER ; city-specific
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

Text_Intro_SaffronTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_SaffronTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_SaffronTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_SaffronTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_SaffronTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_SaffronTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_SaffronTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; new for RP ================================

SaffronCityText_BlockingRocket_RP:
	text_far _SaffronCityText_BlockingRocket_RP
	text_end

SaffronCityText_BlockingSilph_RP:
	text_asm
	CheckEvent EVENT_RP_UNLOCKED_SILPH
	ld hl, SaffronCityText_BlockingSilph_RP_Before
	jr z, .printAndEnd
; silph unlocked: give CARD_KEY
	ld hl, SaffronCityText_BlockingSilph_RP_After_GoodTakeThis
	call PrintText
	lb bc, CARD_KEY, 1
	call GiveItem
	jr nc, .bagFull
; actually give the card, hide the card key item in 5F, hide the guard
	ld hl, SaffronCityText_BlockingSilph_RP_After_ObtainItem
	call PrintText
	ld hl, SaffronCityText_BlockingSilph_RP_After_NowGo
	call PrintText
	call GBFadeOutToBlack
	ld a, HS_SAFFRON_CITY_E
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_SILPH_CO_5F_ITEM_3
	ld [wMissableObjectIndex], a
	predef HideObject
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jr .done
.bagFull
	ld hl, SaffronCityText_BlockingSilph_RP_After_RP_BagFull
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SaffronCityText_BlockingSilph_RP_Before:
	text_far _SaffronCityText_BlockingSilph_RP_Before
	text_end

SaffronCityText_BlockingSilph_RP_After_GoodTakeThis:
	text_far _SaffronCityText_BlockingSilph_RP_After_GoodTakeThis
	text_end

SaffronCityText_BlockingSilph_RP_After_ObtainItem:
	text_far _ReceivedHM01Text
	sound_get_key_item
	text_end

SaffronCityText_BlockingSilph_RP_After_RP_BagFull:
	text_far _SaffronCityText_BlockingSilph_RP_After_RP_BagFull
	text_end

SaffronCityText_BlockingSilph_RP_After_NowGo:
	text_far _SaffronCityText_BlockingSilph_RP_After_NowGo
	text_end
