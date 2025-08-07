SeviiEightIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry8
	call EnableAutoTextBoxDrawing
	ld hl, SeviiEightIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiEightIslandDock_ScriptPointers:
	dw SeviiEightIslandDockScritp_NullScript
	dw SeviiEightIslandDockScritp_FerryWarpScript

SeviiEightIslandDockScritp_NullScript:
	ret

SeviiEightIslandDockScritp_FerryWarpScript:
	jpfar PerformFerryWarp

ActionsOnEntry8:
	ld a, SEVII_EIGHT_ISLAND_CITY
	ld [wLastBlackoutMap], a
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
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SeviiEightIslandDockSailorText_NoTicket
	jr z, .doNotHaveTicket
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

SeviiEightIslandDockSailorText_NoTicket:
	text_far _SeviiIslandsDockSailorText_NoTicket
	text_end

; ----------------------------------------------

; TBE
SeviiEightIslandDockBgText2:
SeviiEightIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end

; ----------------------------------------------

SeviiEightIslandDockBgText1:
	text_far _SeviiEightIslandDockBgText1
	text_end
