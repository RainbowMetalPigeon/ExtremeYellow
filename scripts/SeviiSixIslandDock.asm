SeviiSixIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry6
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSixIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ActionsOnEntry6:
	ld a, SEVII_SIX_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiSixIslandDock_ScriptPointers:
	dw SeviiSixIslandDockScritp_NullScript
	dw SeviiSixIslandDockScritp_TurnSailorAndMovePlayerScript
	dw SeviiSixIslandDockScritp_FerryWarpScript
	dw SeviiSixIslandDockScritp_PostPlayerMovementAndShowSailors

SeviiSixIslandDockScritp_NullScript:
 	CheckAndResetEvent EVENT_TRAVELING_WITH_FERRY
	ret z
	ld a, SFX_GO_OUTSIDE
	call PlaySound
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SeviiSixDockPlayerUpMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiSixDockPlayerUpMovement:
	db D_UP, 1
	db -1 ; end

SeviiSixIslandDockScritp_TurnSailorAndMovePlayerScript:
; turn sailor
	ld a, 1
	ldh [hSpriteIndex], a
	lb bc, STAY, DOWN
	call ChangeSpriteMovementBytes ; new fancy approach from Engeze
	call Delay3
; hide sailors
	callfar HideSeviiDockSailors
	ld a, SFX_GO_INSIDE
	call PlaySound
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SeviiSixDockPlayerDownMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiSixDockPlayerDownMovement:
	db D_DOWN, 1
	db -1 ; end

SeviiSixIslandDockScritp_FerryWarpScript:
; wait for player to have moved
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
; hide player and Pikachu
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
	call LoadTransparentPlayerSpriteGraphics
	ld a, SFX_GO_INSIDE
	call PlaySound
	call WaitForSoundToFinish
; load next script
	ld a, 0
	ld [wCurMapScript], a
	jpfar PerformFerryWarp

SeviiSixIslandDockScritp_PostPlayerMovementAndShowSailors:
; wait for player to have moved
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
; show Pikachu, if present
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu
; load next script
	ld a, 0
	ld [wCurMapScript], a
	callfar ShowSeviiDockSailors
	ret

SeviiSixIslandDock_TextPointers:
	dw SeviiSixIslandDockSpriteText1
	dw SeviiSixIslandDockBgText1
	dw SeviiSixIslandDockBgText2
	dw SeviiSixIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiSixIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiSixIslandDockSailorText_Intro
	call PrintText
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SeviiSixIslandDockSailorText_NoTicket
	jr z, .doNotHaveTicket
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld hl, FerryDesinationsList_SixIsland_UpTo8
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
	ld [wUniQuizAnswer], a
	ld hl, SeviiSixIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiSixIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_SixIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
;	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiSixIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiSixIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiSixIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

SeviiSixIslandDockSailorText_NoTicket:
	text_far _SeviiIslandsDockSailorText_NoTicket
	text_end

; ----------------------------------------------

; TBE
SeviiSixIslandDockBgText2:
SeviiSixIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end

; ----------------------------------------------

SeviiSixIslandDockBgText1:
	text_far _SeviiSixIslandDockBgText1
	text_end
