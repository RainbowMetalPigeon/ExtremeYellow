VermilionCity_Script:
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld hl, wd492
	res 7, [hl]
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	push hl
	call nz, .initCityScript
	pop hl
	bit 5, [hl]
	res 5, [hl]
	call nz, .setFirstLockTrashCanIndex
	ld hl, VermilionCity_ScriptPointers
	ld a, [wVermilionCityCurScript]
	call CallFunctionInTable
	call .vermilionCityScript_19869
	ret

.vermilionCityScript_19869
	CheckEventHL EVENT_152
	ret nz
	CheckEventReuseHL EVENT_GOT_BIKE_VOUCHER
	ret z
	SetEventReuseHL EVENT_152
	ret

.setFirstLockTrashCanIndex
	call Random
	ldh a, [hRandomAdd]
	ld b, a
	ldh a, [hRandomSub]
	adc b
	and $e
	ld [wFirstLockTrashCanIndex], a
	ret

.initCityScript
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; new, testing
	ret nz ; new, testing
	CheckEventHL EVENT_SS_ANNE_LEFT
	ret z
	CheckEventReuseHL EVENT_WALKED_PAST_GUARD_AFTER_SS_ANNE_LEFT
	SetEventReuseHL EVENT_WALKED_PAST_GUARD_AFTER_SS_ANNE_LEFT
	ret nz
	ld a, $2
	ld [wVermilionCityCurScript], a
	ret

VermilionCity_ScriptPointers:
	dw VermilionCityScript0
	dw VermilionCityScript1
	dw VermilionCityScript2
	dw VermilionCityScript3
	dw VermilionCityScript4
	dw VermilionScript_Traveler ; new, for traveler

VermilionCityScript0:
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; new, testing
	ret nz ; new, testing
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	jr nz, .return
	ld hl, SSAnneTicketCheckCoords
	call ArePlayerCoordsInArray
	jr nc, .return
	xor a
	ldh [hJoyHeld], a
	ld [wcf0d], a
	ld a, $3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .shipHasDeparted
	ld b, S_S_TICKET
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	ret nz
.shipHasDeparted
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
	ld [wVermilionCityCurScript], a
	ret

.return
	ret

SSAnneTicketCheckCoords:
	dbmapcoord 18, 30
	db -1 ; end

VermilionCityScript4:
	ld hl, SSAnneTicketCheckCoords
	call ArePlayerCoordsInArray
	ret c
	ld a, $0
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript2:
	ld a, $ff
	ld [wJoyIgnore], a
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld a, 2
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript3:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ldh [hJoyHeld], a
	ld a, $0
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld c, 10
	call DelayFrames
	ld a, $0
	ld [wVermilionCityCurScript], a
	ret

VermilionCity_TextPointers:
	dw VermilionCityText1
	dw VermilionCityText2
	dw VermilionCityText3 ; SS Anne Guardian
	dw VermilionCityText4
	dw VermilionCityText5 ; Machoke
	dw VermilionCityText5PG ; new, Machamp
	dw VermilionCityText6
	dw VermilionCityText7
	dw TextPreBattle_VermilionTraveler ; new, for traveler
	dw VermilionCityText8
	dw VermilionCityText9
	dw MartSignText
	dw PokeCenterSignText
	dw VermilionCityText12
	dw VermilionCityText13
	dw VermilionCityText14
	dw VermilionCityText16
	dw TextPostBattle_VermilionTraveler ; 18, new, for traveler

VermilionCityText1:
	text_far _VermilionCityText1
	text_end

VermilionCityText2:
	text_asm
; new code to handle the ship return
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .beforeShipReturn
	ld hl, VermilionCityTextAnneReturned
	call PrintText
	jr .end
.beforeShipReturn
; back to vanilla code
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .shipHasDeparted
	ld hl, VermilionCityTextDidYouSee
	call PrintText
	jr .end
.shipHasDeparted
	ld hl, VermilionCityTextSSAnneDeparted
	call PrintText
.end
	jp TextScriptEnd

VermilionCityTextDidYouSee:
	text_far _VermilionCityTextDidYouSee
	text_end

VermilionCityTextSSAnneDeparted:
	text_far _VermilionCityTextSSAnneDeparted
	text_end

VermilionCityTextAnneReturned:
	text_far _VermilionCityTextAnneReturned
	text_end

VermilionCityText3:
	text_asm
; new code to handle the ship return
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .beforeShipReturn
	ld hl, SSAnneWelcomeTextPostReturn
	call PrintText
	jr .end
.beforeShipReturn
; back to vanilla code
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .shipHasDeparted
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_RIGHT
	jr z, .greetPlayer
	ld hl, .inFrontOfOrBehindGuardCoords
	call ArePlayerCoordsInArray
	jr nc, .greetPlayerAndCheckTicket
.greetPlayer
	ld hl, SSAnneWelcomeText4
	call PrintText
	jr .end
.greetPlayerAndCheckTicket
	ld hl, SSAnneWelcomeText9
	call PrintText
	ld b, S_S_TICKET
	predef GetQuantityOfItemInBag
	ld a, b
	and a
	jr nz, .playerHasTicket
	ld hl, SSAnneNoTicketText
	call PrintText
	jr .end
.playerHasTicket
	ld hl, SSAnneFlashedTicketText
	call PrintText
	ld a, $4
	ld [wVermilionCityCurScript], a
	jr .end
.shipHasDeparted
	ld hl, SSAnneNotHereText
	call PrintText
.end
	jp TextScriptEnd

.inFrontOfOrBehindGuardCoords
	dbmapcoord 19, 29 ; in front of guard
	dbmapcoord 19, 31 ; behind guard
	db -1 ; end

SSAnneWelcomeText4:
	text_far _SSAnneWelcomeText4
	text_end

SSAnneWelcomeText9:
	text_far _SSAnneWelcomeText9
	text_end

SSAnneWelcomeTextPostReturn:
	text_far _SSAnneWelcomeTextPostReturn
	text_end

SSAnneFlashedTicketText:
	text_far _SSAnneFlashedTicketText
	text_end

SSAnneNoTicketText:
	text_far _SSAnneNoTicketText
	text_end

SSAnneNotHereText:
	text_far _SSAnneNotHereText
	text_end

VermilionCityText4:
	text_asm
	farcall Func_ElderBattleFacility
	jp TextScriptEnd

VermilionCityText5:
	text_far _VermilionCityText5
	text_asm
	ld a, MACHOKE
	call PlayCry
	call WaitForSoundToFinish
	ld hl, VermilionCityText15
	ret

VermilionCityText5PG:
	text_far _VermilionCityText5PG
	text_asm
	ld a, MACHAMP
	call PlayCry
	call WaitForSoundToFinish
	ld hl, VermilionCityText15PG
	ret

VermilionCityText15:
	text_far _VermilionCityText15
	text_end

VermilionCityText15PG:
	text_far _VermilionCityText15PG
	text_end

VermilionCityText6:
	text_far _VermilionCityText6
	text_end

VermilionCityText8:
	text_asm
	farcall Func_f1a8a
	jp TextScriptEnd

VermilionCityText9:
	text_asm
	farcall Func_f1a96
	jp TextScriptEnd

VermilionCityText12:
	text_asm
	farcall Func_f1aa2
	jp TextScriptEnd

VermilionCityText13:
	text_asm
	farcall Func_f1aae
	jp TextScriptEnd

VermilionCityText14:
	text_asm
	farcall Func_f1aba
	jp TextScriptEnd

VermilionCityText7:
	text_asm
	farcall Func_f1a0f
	jp TextScriptEnd

VermilionCityText16: ; new
	text_asm
	farcall Func_BattleFacility
	jp TextScriptEnd

; ================================

TextPreBattle_VermilionTraveler: ; new
	text_asm 
	ld hl, Text_Intro_VermilionTraveler
	call PrintText
	callfar CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, Text_NoMMewtwo_VermilionTraveler
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic
	ld hl, Text_YesMMewtwo_VermilionTraveler
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
	ld hl, Text_DefeatPostBattle_VermilionTraveler
	ld de, Text_VictoryPostBattle_VermilionTraveler
	call SaveEndBattleTextPointers
; script handling
	ld a, 5 ; city-specific
	ld [wVermilionCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_VermilionTraveler:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Compliments_VermilionTraveler
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
	ld hl, Text_WhatWasThat_VermilionTraveler
	call PrintText
	; script handling
	xor a
	ld [wVermilionCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

; --------------------------------

VermilionScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wVermilionCityCurScript], a ; city-specific
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_VERMILION_CITY_TRAVELER ; city-specific
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

; --------------------------------

Text_Intro_VermilionTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_VermilionTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_VermilionTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

Text_DefeatPostBattle_VermilionTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

Text_VictoryPostBattle_VermilionTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_VermilionTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_VermilionTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; ================================
