SeviiSevenIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry7
	call EnableAutoTextBoxDrawing
	ld hl, SeviiSevenIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiSevenIslandDock_ScriptPointers:
	dw SeviiSevenIslandDockScritp_NullScript
	dw SeviiSevenIslandDockScritp_FerryWarpScript

SeviiSevenIslandDockScritp_NullScript:
	ret

SeviiSevenIslandDockScritp_FerryWarpScript:
	jpfar PerformFerryWarp

ActionsOnEntry7:
	ld a, SEVII_SEVEN_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiSevenIslandDock_TextPointers:
	dw SeviiSevenIslandDockSpriteText1
	dw SeviiSevenIslandDockBgText1
	dw SeviiSevenIslandDockBgText2
	dw SeviiSevenIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiSevenIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiSevenIslandDockSailorText_Intro
	call PrintText
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SeviiSevenIslandDockSailorText_NoTicket
	jr z, .doNotHaveTicket
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld hl, FerryDesinationsList_SevenIsland_UpTo8
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
	ld hl, SeviiSevenIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiSevenIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_SevenIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
;	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiSevenIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiSevenIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiSevenIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

SeviiSevenIslandDockSailorText_NoTicket:
	text_far _SeviiIslandsDockSailorText_NoTicket
	text_end

; ----------------------------------------------

; TBE
SeviiSevenIslandDockBgText2:
SeviiSevenIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end

; ----------------------------------------------

SeviiSevenIslandDockBgText1:
	text_far _SeviiSevenIslandDockBgText1
	text_end
