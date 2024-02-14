ViridianCity_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, ViridianCity_ScriptPointers
	ld a, [wViridianCityCurScript]
	call CallFunctionInTable
	ret

ViridianCity_ScriptPointers:
	dw ViridianCityScript0
	dw ViridianCityScript1
	dw ViridianCityScript2
	dw ViridianCityScript3
	dw ViridianCityScript4
	dw ViridianCityScript5
	dw ViridianCityScript6
	dw ViridianCityScript7
	dw ViridianCityScript8
	dw ViridianCityScript9
	dw ViridianCityScript10
	dw ViridianScript_Traveler ; new, for traveler

ViridianCityScript0:
	call ViridianCityScript_1905b
	call ViridianCityScript_190ab
	ret

ViridianCityScript1:
	call ViridianCityScript_19162
ViridianCityScript2:
	call ViridianCityScript_1905b
	ret

ViridianCityScript_1905b:
	CheckEvent EVENT_VIRIDIAN_GYM_OPEN
	ret nz
	ld a, [wObtainedBadges]
	cp ~(1 << BIT_EARTHBADGE)
	jr nz, .gym_closed
	SetEvent EVENT_VIRIDIAN_GYM_OPEN
	ret
.gym_closed
	ld a, [wYCoord]
	cp 8
	ret nz
	ld a, [wXCoord]
	cp 32
	ret nz
	ld a, $10 ; +1 because of traveler
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ld a, $6
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript6:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, $2
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript_190ab:
	ld a, [wYCoord]
	cp 9
	ret nz
	ld a, [wXCoord]
	cp 19
	ret nz
	ld a, $5
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	call ViridianCityScript_1914d
	ld a, $5
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript3:
	call ViridianCityScript_190ef
	call ViridianCityScript_190db
	ResetEvent EVENT_02F
	ld a, $4
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript_190db:
	xor a
	ld [wListScrollOffset], a
	ld a, BATTLE_TYPE_OLD_MAN
	ld [wBattleType], a
	ld a, 5
	ld [wCurEnemyLVL], a
	ld a, RATTATA
	ld [wCurOpponent], a
	ret

ViridianCityScript_190ef:
	ld a, [wSprite03StateData1YPixels]
	ldh [hSpriteScreenYCoord], a
	ld a, [wSprite03StateData1XPixels]
	ldh [hSpriteScreenXCoord], a
	ld a, [wSprite03StateData2MapY]
	ldh [hSpriteMapYCoord], a
	ld a, [wSprite03StateData2MapX]
	ldh [hSpriteMapXCoord], a
	ret

ViridianCityScript4:
	call ViridianCityScript_1912a
	call UpdateSprites
	call Delay3
	SetEvent EVENT_02E
	xor a
	ld [wJoyIgnore], a
	ld a, $11 ; +1 because of traveler
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wBattleType], a
	ld [wJoyIgnore], a
	ld a, $2
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript_1912a:
	ldh a, [hSpriteScreenYCoord]
	ld [wSprite03StateData1YPixels], a
	ldh a, [hSpriteScreenXCoord]
	ld [wSprite03StateData1XPixels], a
	ldh a, [hSpriteMapYCoord]
	ld [wSprite03StateData2MapY], a
	ldh a, [hSpriteMapXCoord]
	ld [wSprite03StateData2MapX], a
	ret

ViridianCityScript5:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	ld a, $0
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript_1914d:
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_DOWN
	ld [wSimulatedJoypadStatesEnd], a
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a
	ld [wJoyIgnore], a
	ret

ViridianCityScript_19162:
	CheckEvent EVENT_02D
	ret nz
	ld a, [wYCoord]
	cp 9
	ret nz
	ld a, [wXCoord]
	cp 19
	ret nz
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	call SetSpriteFacingDirectionAndDelay
	ld a, $8
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, D_UP | D_DOWN | D_LEFT | D_RIGHT | START | SELECT
	ld [wJoyIgnore], a
	ret

ViridianCityScript7:
	call ViridianCityScript_190ef
	call ViridianCityScript_190db
	SetEvent EVENT_02F
	ld a, D_UP | D_DOWN | D_LEFT | D_RIGHT | START | SELECT
	ld [wJoyIgnore], a
	ld a, $8
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript8:
	call ViridianCityScript_1912a
	call UpdateSprites
	call Delay3
	SetEvent EVENT_02D
	ld a, D_UP | D_DOWN | D_LEFT | D_RIGHT | START | SELECT
	ld [wJoyIgnore], a
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wBattleType], a
	dec a
	ld [wJoyIgnore], a
	ld a, $9
	ld [wViridianCityCurScript], a
	ret

ViridianCityScript9:
	ld de, ViridianCityOldManMovementData2
	ld a, [wXCoord]
	cp 19
	jr z, .asm_191e4
	callfar Func_f1a01
	ld de, ViridianCityOldManMovementData1
.asm_191e4
	ld a, $8
	ldh [hSpriteIndexOrTextID], a
	call MoveSprite
	ld a, $a
	ld [wViridianCityCurScript], a
	ret

ViridianCityOldManMovementData1:
	db NPC_MOVEMENT_RIGHT
ViridianCityOldManMovementData2:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db $ff

ViridianCityScript10:
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_OLD_MAN ; edited, no longer hard-coded
	ld [wMissableObjectIndex], a
	predef HideObject
	xor a
	ld [wJoyIgnore], a
	ld a, $2
	ld [wViridianCityCurScript], a
	ret

ViridianCity_TextPointers:
	dw ViridianCityText_0 ; 1
	dw ViridianCityText_1 ; 2
	dw ViridianCityText_2 ; 3
	dw ViridianCityText_3 ; 4
	dw ViridianCityText_4 ; 5
	dw ViridianCityText_5 ; 6
	dw ViridianCityText_6 ; 7
	dw ViridianCityText_7 ; 8
	dw TextPreBattle_ViridianTraveler ; 9, new, for traveler
	dw ViridianCityText_8 ; $A
	dw ViridianCityText_9 ; $B
	dw ViridianCityText_10 ; $C
	dw MartSignText ; $D
	dw PokeCenterSignText ; $E
	dw ViridianCityText_11 ; $F
	dw ViridianCityText_12 ; $10
	dw ViridianCityText_13 ; $11 ; need to weak target mon
	dw TextPostBattle_ViridianTraveler ; 18=$12 new, for traveler

ViridianCityText_0:
	text_asm
	farcall Func_f18bb
	jp TextScriptEnd

ViridianCityText_1:
	text_asm
	farcall Func_f18c7
	jp TextScriptEnd

ViridianCityText_2:
	text_asm
	farcall Func_f18e9
	jp TextScriptEnd

ViridianCityText_3:
	text_asm
	farcall Func_f1911
	jp TextScriptEnd

ViridianCityText_4:
	text_asm
	farcall Func_f192c
	jp TextScriptEnd

ViridianCityText_5:
	text_asm
	farcall Func_f194a
	jp TextScriptEnd

ViridianCityText_6:
	text_asm
	farcall Func_f198e
	jp TextScriptEnd

ViridianCityText_13:
	text_far _ViridianCityText_19219
	text_end

ViridianCityText_7:
	text_asm
	CheckEvent EVENT_02D
	jr nz, .asm_192a6
	ld hl, ViridianCityText_192af
	call PrintText
	ld c, 2
	call DelayFrames
	ld a, $7
	ld [wViridianCityCurScript], a
	jr .asm_192ac

.asm_192a6
	ld hl, ViridianCityText_192b4
	call PrintText
.asm_192ac
	jp TextScriptEnd

ViridianCityText_192af:
	text_far _ViridianCityText_1920a
	text_end

ViridianCityText_192b4:
	text_far _OldManTextAfterBattle
	text_end

ViridianCityText_8:
	text_asm
	farcall Func_f19c5
	jp TextScriptEnd

ViridianCityText_9:
	text_asm
	farcall Func_f19d1
	jp TextScriptEnd

ViridianCityText_10:
	text_asm
	farcall Func_f19dd
	jp TextScriptEnd

ViridianCityText_11:
	text_asm
	farcall Func_f19e9
	jp TextScriptEnd

ViridianCityText_12:
	text_asm
	farcall Func_f19f5
	jp TextScriptEnd

; ================================

TextPreBattle_ViridianTraveler: ; new
	text_asm 
	ld hl, Text_Intro_ViridianTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_ViridianTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_ViridianTraveler
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
	ld hl, Text_DefeatPostBattle_ViridianTraveler
	ld de, Text_VictoryPostBattle_ViridianTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 11 ; city-specific
	ld [wViridianCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_ViridianTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_ViridianTraveler
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
	ld hl, Text_WhatWasThat_ViridianTraveler
	call PrintText
	; script handling
	xor a
	ld [wViridianCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

Text_Intro_ViridianTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_ViridianTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_ViridianTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_ViridianTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_ViridianTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_ViridianTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_ViridianTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; --------------------------------

ViridianScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wViridianCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_VIRIDIAN_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObject ; city-specific
	ld a, 18 ; city-specific
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
