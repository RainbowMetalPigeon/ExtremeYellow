VermilionCity_Script:
	RPTextChooser VermilionCity_TextPointers, VermilionCity_TextPointers_Rocket
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
	CheckEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY ; new
	ret nz ; new
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
	dw VermilionCityScript6 ; new, for Sevii ferry
	dw VermilionCityScript7 ; new, for Sevii ferry
	dw VermilionCityScript8 ; new, for RP
	dw VermilionCityScript9 ; new, for RP
	dw VermilionCityScript10 ; new, for RP

VermilionCityScript0: ; edited for RP
	CheckEvent EVENT_ROCKET_PATH
	jr z, .notRP
; are we at the Jenny's coordinates?
	ld hl, VermilionJennyCheckCoords
	call ArePlayerCoordsInArray
	jr nc, .notRP ; normal stuff for dock
; already beat Jenny?
	CheckEvent EVENT_RP_DEFEAT_JENNY_VERMILION
	jr nz, .notRP
; Jenny sees and approaches us
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
	ld a, 20
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, [wXCoord]
	ld de, VermilionCityMovement_Jenny_18
	cp 18
	jr z, .gotJennyMovements
	ld de, VermilionCityMovement_Jenny_19
.gotJennyMovements
	ld a, 8
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 8
	jr .changeScript
.notRP
; BTV
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; new
	ret nz ; new
	ld a, [wSpritePlayerStateData1FacingDirection]
	and a ; cp SPRITE_FACING_DOWN
	ret nz
	ld hl, SSAnneTicketCheckCoords
	call ArePlayerCoordsInArray
	ret nc
; we are by side of the dock sailor
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .vanillaCode
	CheckEvent EVENT_ROCKET_PATH
	ret nz
	CheckEvent EVENT_FLASHED_SS_TICKET
	ret nz
.vanillaCode
	xor a
	ldh [hJoyHeld], a
	ld [wcf0d], a
	ld a, $3 ; VermilionCityText3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY ; new
	ret nz ; new
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .accessDenied
	CheckEvent EVENT_FLASHED_SS_TICKET
	ret nz
.accessDenied
	ld a, D_UP | B_BUTTON ; edited to fix Pikachu blocker
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $1
.changeScript ; new
	ld [wVermilionCityCurScript], a
	ret

SSAnneTicketCheckCoords:
	dbmapcoord 18, 30
	db -1 ; end

VermilionJennyCheckCoords: ; new
	dbmapcoord 18, 11
	dbmapcoord 19, 11
	db -1 ; end

VermilionCityMovement_Jenny_18: ; new for RP
	db NPC_FAST_MOVEMENT_LEFT
VermilionCityMovement_Jenny_19:
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
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
	ld a, D_UP | B_BUTTON ; edited to fix Pikachu blocker
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

VermilionCityScript6: ; new
	ld a, $ff
	ld [wJoyIgnore], a
; choose player movement depending on Y
	ld a, [wYCoord]
	cp 29
	ld de, VermilionDockY29_RLEMovement
	jr z, .gotMovements
	cp 30
	ld de, VermilionDockY30_RLEMovement
	jr z, .gotMovements
	ld de, VermilionDockY31_RLEMovement
.gotMovements
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; script handling
	ld a, 7
	ld [wVermilionCityCurScript], a
	ret

VermilionDockY29_RLEMovement:
	db D_DOWN, 3
	db D_LEFT, 1
	db -1 ; end

VermilionDockY30_RLEMovement:
	db D_DOWN, 2
	db -1 ; end

VermilionDockY31_RLEMovement:
	db D_DOWN, 1
	db -1 ; end

VermilionCityScript7: ; new
; check if player movement is over
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; script handling
	xor a
	ld [wJoyIgnore], a
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript8: ; new for RP
; wait for Jenny to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; finished walking
	call VermilionCity_PlayerAndJennyFacings
	ld a, 9
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript9: ; new for RP
	xor a
	ld [wJoyIgnore], a
	ld a, 21
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, VermilionCityText_AfterFightJenny
	ld de, VermilionCityText_AfterFightJenny
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld a, OPP_JENNY
	ld [wCurOpponent], a
	ld a, 2
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 10
	ld [wVermilionCityCurScript], a
	ret

VermilionCityScript10: ; new for RP
	ld a, [wIsInBattle]
	cp $ff
	jp z, VermilionCityResetScripts
; we won
	xor a
	ld [wIsTrainerBattle], a
	call VermilionCity_PlayerAndJennyFacings
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_RP_DEFEAT_JENNY_VERMILION
	ld a, 22
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; if we already got SQUIRTLE, do nothing
	CheckEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	jr nz, VermilionCityResetScripts
; steal SQUIRTLE
	call VermilionCityResetScripts
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

VermilionCityResetScripts: ; new
	xor a
	ld [wJoyIgnore], a
	ld [wVermilionCityCurScript], a
	ret

VermilionCity_PlayerAndJennyFacings: ; new
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, 8
	ldh [hSpriteIndex], a
	lb bc, STAY, UP
	jp ChangeSpriteMovementBytes ; new from Engeze

; texts =========================================================

VermilionCity_TextPointers:
	dw VermilionCityText1
	dw VermilionCityText2
	dw VermilionCityText3 ; SS Anne Guardian
	dw VermilionCityText4 ; Battle Facility boss
	dw VermilionCityText5 ; Machoke
	dw VermilionCityText5PG ; new, Machamp
	dw VermilionCityText6
	dw VermilionCityText7 ; Jenny
	dw TextPreBattle_VermilionTraveler ; new, for traveler
	dw PickUpItemText ; 10=$A, new, rare candy
	; signs
	dw VermilionCityText8
	dw VermilionCityText9
	dw MartSignText
	dw PokeCenterSignText
	dw VermilionCityText12
	dw VermilionCityText13
	dw VermilionCityText14
	dw VermilionCityText16
	; scripts
	dw TextPostBattle_VermilionTraveler ; 19, new, for traveler

VermilionCity_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw VermilionCityText3 ; SS Anne Guardian
	dw VermilionCityText4_RP ; Battle Facility boss
	dw VermilionCityText5_RP ; Machoke
	dw VermilionCityText5PG ; Machamp
	dw GenericNPCText_RocketPath
	dw VermilionCityText7_RP ; Jenny
	dw TextPreBattle_VermilionTraveler_RP ; Traveler
	dw PickUpItemText ; 10=$A
	; signs
	dw VermilionCityText8
	dw VermilionCityText9
	dw MartSignText
	dw PokeCenterSignText
	dw VermilionCityText12
	dw VermilionCityText13
	dw VermilionCityText14
	dw VermilionCityText16 ; 18
	; scripts
	dw TextPostBattle_VermilionTraveler_RP ; 19, for traveler
	dw VermilionCityText_RP_Script1 ; 20
	dw VermilionCityText_RP_Script2 ; 21
	dw VermilionCityText_RP_Script3 ; 22

VermilionCityText1:
	text_far _VermilionCityText1
	text_end

VermilionCityText2: ; edited
	text_asm
	SetEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH ; for debugging
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .beforeShipReturn
	ld hl, VermilionCityTextAnneReturned
	jr .end
.beforeShipReturn
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .shipHasDeparted
	ld hl, VermilionCityTextDidYouSee
	jr .end
.shipHasDeparted
	ld hl, wObtainedBadges
	ld b, 1
	call CountSetBits ; INPUT: hl = address of string of bytes, b = length of string of bytes, OUTPUT: [wNumSetBits] = number of set bits
	ld a, [wNumSetBits]
	cp 4
	jr nc, .someBadges1
	ld hl, VermilionCityTextSSAnneDeparted
	jr .end
.someBadges1
	cp 7
	jr nc, .someBadges2
	ld hl, VermilionCityTextSSAnneReturnsSoon
	jr .end
.someBadges2
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	jr nz, .beatenLeague
	ld hl, VermilionCityTextSSAnneReturnsVerySoon
	jr .end
.beatenLeague
	ld hl, VermilionCityTextSSAnneReturnsAnyTimeNow
.end
	call PrintText
	jp TextScriptEnd

VermilionCityTextDidYouSee:
	text_far _VermilionCityTextDidYouSee
	text_end

VermilionCityTextSSAnneDeparted:
	text_far _VermilionCityTextSSAnneDeparted
	text_end

VermilionCityTextSSAnneReturnsSoon: ; new
	text_far _VermilionCityTextSSAnneReturnsSoon
	text_end

VermilionCityTextSSAnneReturnsVerySoon: ; new
	text_far _VermilionCityTextSSAnneReturnsVerySoon
	text_end

VermilionCityTextSSAnneReturnsAnyTimeNow: ; new
	text_far _VermilionCityTextSSAnneReturnsAnyTimeNow
	text_end

VermilionCityTextAnneReturned: ; new
	text_far _VermilionCityTextAnneReturned
	text_end

VermilionCityText3: ; edited
	text_asm

; post-League: SS returned
	CheckEvent EVENT_BEAT_CHAMPION_FINAL_REMATCH
	jr z, .beforePostLeague
; post-League: choose between SS and Sevii
	ld hl, SSAnneWelcomeTextPostReturn
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SSAnneWelcomeEnjoyFreelyText
	jp nz, .printAndEnd

; we want to travel to the Sevii
	jr .normalSeviiDestinations
; SS Anne has not returned yet
.beforePostLeague
; have we already traveled to Sevii?
	CheckEvent EVENT_TRAVELED_TO_SEVII_AT_LEAST_ONCE
	jr nz, .normalSeviiDestinations
; try to travel for the first time, check if we have ticket
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jp z, .noSeviiTicket
; we have the Sevii Ticket, propose special first trip to Sevii

	CheckEvent EVENT_ROCKET_PATH
	ld hl, SeviiOnlyOneIslandText_RP
	jr nz, .printRPText1
	ld hl, SeviiOnlyOneIslandText
.printRPText1
	call PrintText

	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .exit
; traveling to One Island
	SetEvent EVENT_TRAVELED_TO_SEVII_AT_LEAST_ONCE
	ld a, SEVII_TICKET
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID

	CheckEvent EVENT_ROCKET_PATH
	ld hl, VermilionSailorRegisterSeviiTravelerText_RP
	jr nz, .printRPText2
	ld hl, VermilionSailorRegisterSeviiTravelerText
.printRPText2
	call PrintText

	ld a, FERRY_SEVII_ONE
	jr .destinationChosen
; print the list of destinations
.normalSeviiDestinations

	CheckEvent EVENT_ROCKET_PATH
	ld hl, SeviiWhichDestinationText_RP
	jr nz, .printRPText3
	ld hl, SeviiWhichDestinationText
.printRPText3
	call PrintText

	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld hl, FerryDesinationsList_Vermilion_UpTo8
	jr nz, .loadDestinations
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_5
	ld hl, FerryDesinationsList_Vermilion_UpTo5
	jr nz, .loadDestinations
	ld hl, FerryDesinationsList_Vermilion_UpTo3
.loadDestinations
	call LoadItemList
	ld hl, wItemList
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	xor a
	ld [wPrintItemPrices], a
	ld [wMenuItemToSwap], a
	ld a, SPECIALLISTMENU
	ld [wListMenuID], a
	call DisplayListMenuID
	jr c, .exit
; we chose a destination
	ld a, [wcf91]
.destinationChosen
	ld [wUniQuizAnswer], a

	CheckEvent EVENT_ROCKET_PATH
	ld hl, VermilionSailorLetsGoText_RP
	jr nz, .printRPText4
	ld hl, VermilionSailorLetsGoText
.printRPText4
	call PrintText

	SetEvent EVENT_VERMILION_DOCK_AUTOWALKING_SEVII_FERRY
	ld a, 6 ; VermilionCityScript6
	ld [wVermilionCityCurScript], a
	jp .end

; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, VermilionSailorCanceledText
	jr .printAndEnd

; has the SS already departed?
.noSeviiTicket
	CheckEvent EVENT_SS_ANNE_LEFT
	jr nz, .shipHasDeparted

; SS anne not departed
; new RP
	CheckEvent EVENT_ROCKET_PATH
	ld hl, SSAnneRocketPathText
	jp nz, .printAndEnd
; BTV
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_RIGHT
	jr z, .greetPlayer
	ld hl, .inFrontOfOrBehindGuardCoords
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .greetPlayerAndCheckTicket
.greetPlayer
	ld hl, SSAnneWelcomeText4
	jp .printAndEnd
.greetPlayerAndCheckTicket
; did we flash the SS ticket?
	CheckEvent EVENT_FLASHED_SS_TICKET
	jr nz, .end
; first time?
	ld hl, SSAnneWelcomeText9
	call PrintText
	ld b, S_S_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr nz, .playerHasTicket
	ld hl, SSAnneNoTicketText
	jp .printAndEnd
.playerHasTicket
	SetEvent EVENT_FLASHED_SS_TICKET
	ld a, S_S_TICKET
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	ld hl, SSAnneFlashedTicketText
	call PrintText
	ld a, $4
	ld [wVermilionCityCurScript], a
	jp .end
; ship has departed
.shipHasDeparted
	ld hl, SSAnneNotHereText
.printAndEnd
	call PrintText
.end
	jp TextScriptEnd

.inFrontOfOrBehindGuardCoords
	dbmapcoord 19, 29 ; in front of guard
	dbmapcoord 19, 31 ; behind guard
	db -1 ; end

FerryDesinationsList_Vermilion_UpTo3:
	db 3 ; #
;	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db -1 ; end

FerryDesinationsList_Vermilion_UpTo5:
	db 5 ; #
;	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db -1 ; end

FerryDesinationsList_Vermilion_UpTo8:
	db 8 ; #
;	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
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

SeviiWhichDestinationText:
	text_far _SeviiWhichDestinationText
	text_end

SeviiOnlyOneIslandText:
	text_far _SeviiOnlyOneIslandText
	text_end

VermilionSailorLetsGoText:
	text_far _VermilionSailorLetsGoText
	text_end

VermilionSailorCanceledText:
	text_far _VermilionSailorCanceledText
	text_end

SSAnneWelcomeEnjoyFreelyText:
	text_far _SSAnneWelcomeEnjoyFreelyText
	text_end

VermilionSailorRegisterSeviiTravelerText:
	text_far _VermilionSailorRegisterSeviiTravelerText
	text_end

SSAnneRocketPathText:
	text_far _SSAnneRocketPathText
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
	callfar TravelerCommonPreBattleText
	jp c, TextScriptEnd
; script handling
	ld a, 5 ; city-specific
	ld [wVermilionCityCurScript], a
	ld [wCurMapScript], a ; unnecessary?
	jp TextScriptEnd

TextPostBattle_VermilionTraveler:
	text_asm
	callfar TravelerCommonPostBattleText
; script handling
	xor a
	ld [wVermilionCityCurScript], a
	ld [wCurMapScript], a ; unnecessary?
	jp TextScriptEnd

; --------------------------------

VermilionScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wVermilionCityCurScript], a
	ld [wCurMapScript], a ; unnecessary?
	ret
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_VERMILION_CITY_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObject ; city-specific
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

; new for RP ================================

VermilionCityText_AfterFightJenny:
	text_far _VermilionCityText_AfterFightJenny
	text_end

VermilionCityText_RP_Script1:
	text_far _VermilionCityText_RP_Script1
	text_end

VermilionCityText_RP_Script2:
	text_far _VermilionCityText_RP_Script2
	text_end

VermilionCityText_RP_Script3:
	text_far _VermilionCityText_RP_Script3
	text_end

VermilionCityText7_RP:
	text_asm
	CheckEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	jr z, .tryToGetSquirtle
	ld hl, VermilionCityText7_RP_PoorSquirtle
	jr .printAndEnd
.tryToGetSquirtle
	ld hl, VermilionCityText7_RP_OhNoSquirtle
	call PrintText
	call TryToGiveSquirtle
	jp nc, TextScriptEnd
	SetEvent EVENT_GOT_SQUIRTLE_FROM_OFFICER_JENNY
	ld hl, VermilionCityText7_RP_DamnYou
.printAndEnd
	call PrintText
	jp TextScriptEnd

VermilionCityText7_RP_PoorSquirtle:
	text_far _VermilionCityText7_RP_PoorSquirtle
	text_end

VermilionCityText7_RP_OhNoSquirtle:
	text_far _VermilionCityText7_RP_OhNoSquirtle
	text_end

VermilionCityText7_RP_DamnYou:
	text_far _VermilionCityText7_RP_DamnYou
	text_end

TryToGiveSquirtle:
	ld a, SQUIRTLE
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, SQUIRTLE, 15
	jp GivePokemon

VermilionCityText4_RP:
	text_far _VermilionCityText4_RP
	text_end

SeviiOnlyOneIslandText_RP:
	text_far _SeviiOnlyOneIslandText_RP
	text_end

VermilionSailorLetsGoText_RP:
	text_far _VermilionSailorLetsGoText_RP
	text_end

VermilionSailorRegisterSeviiTravelerText_RP:
	text_far _VermilionSailorRegisterSeviiTravelerText_RP
	text_end

SeviiWhichDestinationText_RP:
	text_far _SeviiWhichDestinationText_RP
	text_end

TextPreBattle_VermilionTraveler_RP:
	text_asm
	callfar TravelerCommonPreBattleText_RP
; script handling
	ld a, 5 ; city-specific
	ld [wVermilionCityCurScript], a ; city-specific
	ld [wCurMapScript], a ; unnecessary?
	jp TextScriptEnd

TextPostBattle_VermilionTraveler_RP:
	text_asm
	callfar TravelerCommonPostBattleText_RP
; script handling
	xor a
	ld [wVermilionCityCurScript], a ; city-specific
	ld [wCurMapScript], a ; unnecessary?
	jp TextScriptEnd

VermilionCityText5_RP:
	text_far _VermilionCityText5
	text_asm
	ld a, MACHOKE
	call PlayCry
	call WaitForSoundToFinish
	ld hl, VermilionCityText15_RP
	ret

VermilionCityText15_RP:
	text_far _VermilionCityText15_RP
	text_end
