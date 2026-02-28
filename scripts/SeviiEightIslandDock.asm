SeviiEightIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry8
	call EnableAutoTextBoxDrawing
	ld hl, SeviiEightIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ActionsOnEntry8:
	ld a, SEVII_EIGHT_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiEightIslandDock_ScriptPointers:
	dw SeviiEightIslandDockScript_NullScript
	dw SeviiEightIslandDockScript_TurnSailorAndMovePlayerScript
	dw SeviiEightIslandDockScript_FerryWarpScript
	dw SeviiEightIslandDockScript_PostPlayerMovementAndShowSailors
	dw SeviiEightIslandDockScript_PostWarpFromKanto

SeviiEightIslandDockScript_NullScript:
 	CheckAndResetEvent EVENT_TRAVELING_WITH_FERRY
	ret z
	ld a, SFX_GO_OUTSIDE
	call PlaySound
; move player
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, SeviiEightDockPlayerUpMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiEightDockPlayerUpMovement:
	db D_UP, 1
	db -1 ; end

SeviiEightIslandDockScript_TurnSailorAndMovePlayerScript:
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
	ld de, SeviiEightDockPlayerDownMovement
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; load next script
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiEightDockPlayerDownMovement:
	db D_DOWN, 1
	db -1 ; end

SeviiEightIslandDockScript_FerryWarpScript:
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

SeviiEightIslandDockScript_PostPlayerMovementAndShowSailors:
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

SeviiEightIslandDockScript_PostWarpFromKanto:
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

SeviiEightIslandDock_TextPointers:
	dw SeviiEightIslandDockSpriteText1
	dw SeviiEightIslandDockBgText1
	dw SeviiEightIslandDockBgText2
	dw SeviiEightIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiEightIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiEightIslandDockSailorText_Intro
	call PrintText
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld hl, FerryDesinationsList_EightIsland_UpTo8
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
	ld hl, SeviiEightIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiEightIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_EightIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
;	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiEightIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiEightIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiEightIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

; ----------------------------------------------

; TBE
SeviiEightIslandDockBgText2:
SeviiEightIslandDockBgText3:
	text_asm
	ld hl, SeviiIslandsDockTruckMessage_Eight
	call PrintText
	ld hl, SeviiIslandsDockEmptykMessage_Eight
	call PrintText
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiIslandsDockTruckMessage_Eight_Braille
	call PrintText
	jp TextScriptEnd

SeviiIslandsDockTruckMessage_Eight_Braille:
	text_far _SeviiIslandsDockTruckMessage_Eight_Braille
	text_end

SeviiIslandsDockEmptykMessage_Eight:
	text_far _SeviiIslandsDockEmptykMessage
	text_end

SeviiIslandsDockTruckMessage_Eight:
	text_far _SeviiIslandsDockTheresIsAMessageText
	text_end

; ----------------------------------------------

SeviiEightIslandDockBgText1:
	text_far _SeviiEightIslandDockBgText1
	text_end
