SeviiFiveIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry5
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiFiveIslandDock_ScriptPointers:
	dw SeviiFiveIslandDockScritp_NullScript
	dw SeviiFiveIslandDockScritp_FerryWarpScript

SeviiFiveIslandDockScritp_NullScript:
	ret

SeviiFiveIslandDockScritp_FerryWarpScript:
	jpfar PerformFerryWarp

ActionsOnEntry5:
	ld a, SEVII_FIVE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	ret

SeviiFiveIslandDock_TextPointers:
	dw SeviiFiveIslandDockSpriteText1
	dw SeviiFiveIslandDockBgText1
	dw SeviiFiveIslandDockBgText2
	dw SeviiFiveIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiFiveIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiFiveIslandDockSailorText_Intro
	call PrintText
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SeviiFiveIslandDockSailorText_NoTicket
	jr z, .doNotHaveTicket
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld hl, FerryDesinationsList_FiveIsland_UpTo8
	jr nz, .loadDestinations
	ld hl, FerryDesinationsList_FiveIsland_UpTo5
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
	ld hl, SeviiFiveIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiFiveIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_FiveIsland_UpTo5:
	db 5 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
;	db FERRY_SEVII_FIVE
	db -1 ; end

FerryDesinationsList_FiveIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
;	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiFiveIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiFiveIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiFiveIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

SeviiFiveIslandDockSailorText_NoTicket:
	text_far _SeviiIslandsDockSailorText_NoTicket
	text_end

; ----------------------------------------------

; TBE
SeviiFiveIslandDockBgText2:
SeviiFiveIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end

; ----------------------------------------------

SeviiFiveIslandDockBgText1:
	text_far _SeviiFiveIslandDockBgText1
	text_end
