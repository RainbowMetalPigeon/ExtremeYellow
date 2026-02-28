SeviiFourIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry4
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFourIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ActionsOnEntry4:
	ld a, SEVII_FOUR_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiFourIslandDock_ScriptPointers:
	dw SeviiFourIslandDockScript_NullScript
	dw SeviiFourIslandDockScript_TurnSailorAndMovePlayerScript
	dw SeviiFourIslandDockScript_FerryWarpScript
	dw SeviiFourIslandDockScript_PostPlayerMovementAndShowSailors
	dw SeviiFourIslandDockScript_PostWarpFromKanto

SeviiFourIslandDockScript_NullScript:
 	CheckAndResetEvent EVENT_TRAVELING_WITH_FERRY
	ret z
	ld a, SFX_GO_OUTSIDE
	call PlaySound
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SeviiFourDockPlayerUpMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiFourDockPlayerUpMovement:
	db D_UP, 1
	db -1 ; end

SeviiFourIslandDockScript_TurnSailorAndMovePlayerScript:
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
	ld de, SeviiFourDockPlayerDownMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiFourDockPlayerDownMovement:
	db D_DOWN, 1
	db -1 ; end

SeviiFourIslandDockScript_FerryWarpScript:
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

SeviiFourIslandDockScript_PostPlayerMovementAndShowSailors:
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

SeviiFourIslandDockScript_PostWarpFromKanto:
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld a, D_UP
	ld [hl], a
	ld a, 1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpritePlayerStateData2MovementByte1], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	dec a
	ld [wJoyIgnore], a
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiFourIslandDock_TextPointers:
	dw SeviiFourIslandDockSpriteText1
	dw SeviiFourIslandDockBgText1
	dw SeviiFourIslandDockBgText2
	dw SeviiFourIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiFourIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiFourIslandDockSailorText_Intro
	call PrintText
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld hl, FerryDesinationsList_FourIsland_UpTo8
	jr nz, .loadDestinations
	ld hl, FerryDesinationsList_FourIsland_UpTo5
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
	ld [wUniQuizAnswer], a
	ld hl, SeviiFourIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiFourIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_FourIsland_UpTo5:
	db 5 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
;	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db -1 ; end

FerryDesinationsList_FourIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
;	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiFourIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiFourIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiFourIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

; ----------------------------------------------

; TBE
SeviiFourIslandDockBgText2:
SeviiFourIslandDockBgText3:
	text_asm
	ld hl, SeviiIslandsDockTruckMessage_Four
	call PrintText
	ld hl, SeviiIslandsDockEmptykMessage_Four
	call PrintText
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiIslandsDockTruckMessage_Four_Braille
	call PrintText
	jp TextScriptEnd

SeviiIslandsDockTruckMessage_Four_Braille:
	text_far _SeviiIslandsDockTruckMessage_Four_Braille
	text_end

SeviiIslandsDockEmptykMessage_Four:
	text_far _SeviiIslandsDockEmptykMessage
	text_end

SeviiIslandsDockTruckMessage_Four:
	text_far _SeviiIslandsDockTheresIsAMessageText
	text_end

; ----------------------------------------------

SeviiFourIslandDockBgText1:
	text_far _SeviiFourIslandDockBgText1
	text_end
