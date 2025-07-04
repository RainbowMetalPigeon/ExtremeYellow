FuchsiaCity_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld de, FuchsiaCity_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

FuchsiaCity_ScriptPointers: ; new, for traveler
	dw FuchsiaScript0
	dw FuchsiaScript_Traveler
	dw FuchsiaScript_MoveErik
	dw FuchsiaScript_HideAndShowErikAndSara

FuchsiaScript0:
	ret

FuchsiaCity_TextPointers:
	dw FuchsiaCityText1 ; edited
	dw FuchsiaCityText2 ; edited
	dw FuchsiaCityText3 ; Erik waiting for Sara, edited
	dw FuchsiaCityText4 ; edited
	dw FuchsiaCityText5
	dw FuchsiaCityText6
	dw FuchsiaCityText7
	dw FuchsiaCityText8
	dw FuchsiaCityText9
	dw FuchsiaCityText10
	dw FuchsiaCityTextRocket ; new
	dw FuchsiaCityTextErikHappy ; new
	dw FuchsiaCityTextSaraHappy ; new
	dw TextPreBattle_FuchsiaTraveler ; new, for traveler
	; signs
	dw FuchsiaCityText12
	dw FuchsiaCityText13
	dw MartSignText
	dw PokeCenterSignText
	dw FuchsiaCityText16
	dw FuchsiaCityText17
	dw FuchsiaCityText18
	dw FuchsiaCityText19
	dw FuchsiaCityText20
	dw FuchsiaCityText21
	dw FuchsiaCityText22
	dw FuchsiaCityText23
	dw FuchsiaCityText24
	dw FuchsiaCityTextAntiquities ; new, 28
	; extra
	dw TextPostBattle_FuchsiaTraveler ; new, for traveler, 29
	dw FuchsiaCityText_ErikSurprised ; new, for Erik, 30

FuchsiaCityText1:
	text_asm
	ld hl, FuchsiaCityText1_Pre
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr z, .printAndEnd
	ld hl, FuchsiaCityText1_Post
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaCityText1_Pre:
	text_far _FuchsiaCityText1_Pre
	text_end

FuchsiaCityText1_Post:
	text_far _FuchsiaCityText1_Post
	text_end

; ---------------

FuchsiaCityText2:
	text_asm
	ld hl, FuchsiaCityText2_Pre
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr z, .printAndEnd
	ld hl, FuchsiaCityText2_Post
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaCityText2_Pre:
	text_far _FuchsiaCityText2_Pre
	text_end

FuchsiaCityText2_Post:
	text_far _FuchsiaCityText2_Post
	text_end

; ---------------

FuchsiaCityText3: ; edited
	text_asm
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr nz, .giovanniDefeat
	ld hl, FuchsiaCityText_Erik_Pre
	call PrintText
	jr .conclude
.giovanniDefeat
	ld hl, FuchsiaCityText_ErikWaiting
	call PrintText
	CheckEvent EVENT_SPOKEN_WITH_SARA
	jr z, .notSpokenWithSara
	ld a, 2
	ld [wCurMapScript], a
	jr .conclude
.notSpokenWithSara
	SetEvent EVENT_SPOKEN_WITH_ERIK
.conclude
	jp TextScriptEnd

FuchsiaScript_MoveErik: ; new
	ld a, 3 ; Erik waiting
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	ld a, 30
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, [wXCoord]
	cp 29 ; is player standing left of Erik?
	jr z, .leftOfErik
	ld de, FuchsiaErikMovements_PlayerRight
	jr .continue
.leftOfErik
	ld de, FuchsiaErikMovements_PlayerLeft
.continue
	ld a, 3 ; index of Erik
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 3
	ld [wCurMapScript], a
	ret

FuchsiaScript_HideAndShowErikAndSara:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	ld a, HS_FUCHSIA_CITY_ERIK_WAITING
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_SAFARI_REST_HOUSE_SARA_WAITING
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_SAFARI_REST_HOUSE_ERIK_HAPPY
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_SAFARI_REST_HOUSE_SARA_HAPPY
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; script handling and return control to players
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

FuchsiaErikMovements_PlayerLeft:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

FuchsiaErikMovements_PlayerRight:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

; ---------------

FuchsiaCityText4:
	text_asm
	ld hl, FuchsiaCityText4_Pre
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr z, .printAndEnd
	ld hl, FuchsiaCityText4_Post
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaCityText4_Pre:
	text_far _FuchsiaCityText4_Pre
	text_end

FuchsiaCityText4_Post:
	text_far _FuchsiaCityText4_Post
	text_end

; ---------------

FuchsiaCityText5:
FuchsiaCityText6:
FuchsiaCityText7:
FuchsiaCityText8:
FuchsiaCityText9:
FuchsiaCityText10:
	text_far _FuchsiaCityText5
	text_end

FuchsiaCityTextRocket:
	text_far _FuchsiaCityTextRocket
	text_end

FuchsiaCityText12:
	text_far _FuchsiaCityText12 ; edited
	text_end

FuchsiaCityText13:
	text_far _FuchsiaCityText13
	text_end

FuchsiaCityText16:
	text_far _FuchsiaCityText16
	text_end

FuchsiaCityText17:
	text_far _FuchsiaCityText17
	text_end

FuchsiaCityText18:
	text_far _FuchsiaCityText18
	text_end

FuchsiaCityText19:
	text_asm
	ld hl, FuchsiaCityChanseyText
	call PrintText
	ld a, CHANSEY
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityChanseyText:
	text_far _FuchsiaCityChanseyText
	text_end

FuchsiaCityText20:
	text_asm
	ld hl, FuchsiaCityVoltorbText
	call PrintText
	ld a, VOLTORB
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityVoltorbText:
	text_far _FuchsiaCityVoltorbText
	text_end

FuchsiaCityText21:
	text_asm
	ld hl, FuchsiaCityKangaskhanText
	call PrintText
	ld a, KANGASKHAN
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityKangaskhanText:
	text_far _FuchsiaCityKangaskhanText
	text_end

FuchsiaCityText22:
	text_asm
	ld hl, FuchsiaCitySlowpokeText
	call PrintText
	ld a, SLOWPOKE
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCitySlowpokeText:
	text_far _FuchsiaCitySlowpokeText
	text_end

FuchsiaCityText23: ; edited
	text_asm
	ld hl, FuchsiaCityOmanyteText
	call PrintText
	ld a, OMANYTE
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityOmanyteText:
	text_far _FuchsiaCityOmanyteText
	text_end

FuchsiaCityText24: ; edited
	text_asm
	ld hl, FuchsiaCityKabutoText
	call PrintText
	ld a, KABUTO
	call DisplayPokedex
	jp TextScriptEnd

FuchsiaCityKabutoText:
	text_far _FuchsiaCityKabutoText
	text_end

FuchsiaCityTextAntiquities: ; new
	text_asm
	ld hl, FuchsiaCityTextAntiquities_Pre
	CheckEvent EVENT_BEAT_OBSIDIAN_WAREHOUSE_FINAL_TRAINER_4
	jr z, .printAndEnd
	ld hl, FuchsiaCityTextAntiquities_Post
.printAndEnd
	call PrintText
	jp TextScriptEnd

FuchsiaCityTextAntiquities_Pre: ; new
	text_far _FuchsiaCityTextAntiquities_Pre
	text_end

FuchsiaCityTextAntiquities_Post: ; new
	text_far _FuchsiaCityTextAntiquities_Post
	text_end

; ---------------------------------

FuchsiaCityText_Erik_Pre: ; new, before Giovanni defeat
	text_far _FuchsiaCityText_Erik_Pre
	text_end

FuchsiaCityText_ErikWaiting: ; edited
	text_far _FuchsiaCityText_ErikWaiting
	text_end

FuchsiaCityText_ErikSurprised: ; new
	text_far _FuchsiaCityText_ErikSurprised
	text_end

FuchsiaCityTextErikHappy: ; new
	text_far _FuchsiaCityTextErikHappy
	text_end

FuchsiaCityTextSaraHappy: ; new
	text_far _FuchsiaCityTextSaraHappy
	text_end

; ================================

TextPreBattle_FuchsiaTraveler: ; new
	text_asm
	ld hl, Text_Intro_FuchsiaTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_FuchsiaTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_FuchsiaTraveler
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
	ld hl, Text_DefeatPostBattle_FuchsiaTraveler
	ld de, Text_VictoryPostBattle_FuchsiaTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_FuchsiaTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_FuchsiaTraveler
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
	ld hl, Text_WhatWasThat_FuchsiaTraveler
	call PrintText
	; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

FuchsiaScript_Traveler:
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
    ld a, HS_FUCHSIA_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, 29 ; city-specific
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

Text_Intro_FuchsiaTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_FuchsiaTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_FuchsiaTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_FuchsiaTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_FuchsiaTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_FuchsiaTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_FuchsiaTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
