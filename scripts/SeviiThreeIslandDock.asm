SeviiThreeIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry3
	call EnableAutoTextBoxDrawing
	ld hl, SeviiThreeIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ActionsOnEntry3:
	ld a, SEVII_THREE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiThreeIslandDock_ScriptPointers:
	dw SeviiThreeIslandDockScript_NullScript
	dw SeviiThreeIslandDockScript_TurnSailorAndMovePlayerScript
	dw SeviiThreeIslandDockScript_FerryWarpScript
	dw SeviiThreeIslandDockScript_PostPlayerMovementAndShowSailors
	dw SeviiThreeIslandDockScript_PostWarpFromKanto

SeviiThreeIslandDockScript_NullScript:
 	CheckAndResetEvent EVENT_TRAVELING_WITH_FERRY
	ret z
	ld a, SFX_GO_OUTSIDE
	call PlaySound
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SeviiThreeDockPlayerUpMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiThreeDockPlayerUpMovement:
	db D_UP, 1
	db -1 ; end

SeviiThreeIslandDockScript_TurnSailorAndMovePlayerScript:
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
	ld de, SeviiThreeDockPlayerDownMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiThreeDockPlayerDownMovement:
	db D_DOWN, 1
	db -1 ; end

SeviiThreeIslandDockScript_FerryWarpScript:
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

SeviiThreeIslandDockScript_PostPlayerMovementAndShowSailors:
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

SeviiThreeIslandDockScript_PostWarpFromKanto:
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

SeviiThreeIslandDock_TextPointers:
	dw SeviiThreeIslandDockSpriteText1
	dw SeviiThreeIslandDockBgText1
	dw SeviiThreeIslandDockBgText2
	dw SeviiThreeIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiThreeIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiThreeIslandDockSailorText_Intro
	call PrintText
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld hl, FerryDesinationsList_ThreeIsland_UpTo8
	jr nz, .loadDestinations
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_5
	ld hl, FerryDesinationsList_ThreeIsland_UpTo5
	jr nz, .loadDestinations
	ld hl, FerryDesinationsList_ThreeIsland_UpTo3
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
	ld hl, SeviiThreeIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiThreeIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_ThreeIsland_UpTo3:
	db 3 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
;	db FERRY_SEVII_THREE
	db -1 ; end

FerryDesinationsList_ThreeIsland_UpTo5:
	db 5 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
;	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db -1 ; end

FerryDesinationsList_ThreeIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
;	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiThreeIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiThreeIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiThreeIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end


; ----------------------------------------------

; TBE
SeviiThreeIslandDockBgText2:
SeviiThreeIslandDockBgText3:
	text_asm
	ld hl, SeviiIslandsDockTruckMessage_Three
	call PrintText
	ld hl, SeviiIslandsDockEmptykMessage_Three
	call PrintText
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiIslandsDockTruckMessage_Three_Braille
	call PrintText
	jp TextScriptEnd

SeviiIslandsDockTruckMessage_Three_Braille:
	text_far _SeviiIslandsDockTruckMessage_Three_Braille
	text_end

SeviiIslandsDockEmptykMessage_Three:
	text_far _SeviiIslandsDockEmptykMessage
	text_end

SeviiIslandsDockTruckMessage_Three:
	text_far _SeviiIslandsDockTheresIsAMessageText
	text_end

; ----------------------------------------------

SeviiThreeIslandDockBgText1:
	text_far _SeviiThreeIslandDockBgText1
	text_end
