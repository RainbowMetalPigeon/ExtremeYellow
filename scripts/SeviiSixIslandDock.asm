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
	dw SeviiSixIslandDockScript_NullScript
	dw SeviiSixIslandDockScript_TurnSailorAndMovePlayerScript
	dw SeviiSixIslandDockScript_FerryWarpScript
	dw SeviiSixIslandDockScript_PostPlayerMovementAndShowSailors
	dw SeviiSixIslandDockScript_PostWarpFromKanto

SeviiSixIslandDockScript_NullScript:
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

SeviiSixIslandDockScript_TurnSailorAndMovePlayerScript:
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

SeviiSixIslandDockScript_FerryWarpScript:
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

SeviiSixIslandDockScript_PostPlayerMovementAndShowSailors:
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

SeviiSixIslandDockScript_PostWarpFromKanto:
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

; ----------------------------------------------

; TBE
SeviiSixIslandDockBgText2:
SeviiSixIslandDockBgText3:
	text_asm
	ld hl, SeviiIslandsDockTruckMessage_Six
	call PrintText
	ld hl, SeviiIslandsDockEmptykMessage_Six
	call PrintText
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiIslandsDockTruckMessage_Six_Braille
	call PrintText
	jp TextScriptEnd

SeviiIslandsDockTruckMessage_Six_Braille:
	text_far _SeviiIslandsDockTruckMessage_Six_Braille
	text_end

SeviiIslandsDockEmptykMessage_Six:
	text_far _SeviiIslandsDockEmptykMessage
	text_end

SeviiIslandsDockTruckMessage_Six:
	text_far _SeviiIslandsDockTheresIsAMessageText
	text_end

; ----------------------------------------------

SeviiSixIslandDockBgText1:
	text_far _SeviiSixIslandDockBgText1
	text_end
