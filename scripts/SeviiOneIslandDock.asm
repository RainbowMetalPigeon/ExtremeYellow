SeviiOneIslandDock_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, ActionsOnEntry1
	call EnableAutoTextBoxDrawing
	ld hl, SeviiOneIslandDock_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiOneIslandDock_ScriptPointers:
	dw SeviiOneIslandDockScritp_NullScript
	dw SeviiOneIslandDockScritp_FerryWarpScript

SeviiOneIslandDockScritp_NullScript:
	ret

SeviiOneIslandDockScritp_FerryWarpScript:
	jpfar PerformFerryWarp

ActionsOnEntry1:
	SetEvent EVENT_UNLOCKED_SEVII
	ld a, SEVII_ONE_ISLAND_CITY
	ld [wLastBlackoutMap], a
	IF DEF(_DEBUG)
		ld hl, wd732
		set 1, [hl]
	ENDC
	ret
	
SeviiOneIslandDock_TextPointers:
	dw SeviiOneIslandDockSpriteText1
	dw SeviiOneIslandDockBgText1
	dw SeviiOneIslandDockBgText2
	dw SeviiOneIslandDockBgText3
	text_end

; ----------------------------------------------

SeviiOneIslandDockSpriteText1:
	text_asm
; print intro
	ld hl, SeviiOneIslandDockSailorText_Intro
	call PrintText
	ld b, SEVII_TICKET
	call IsItemInBag ; set zero flag if item isn't in player's bag
	ld hl, SeviiOneIslandDockSailorText_NoTicket
	jr z, .doNotHaveTicket
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_8
	ld hl, FerryDesinationsList_OneIsland_UpTo8
	jr nz, .loadDestinations
	CheckEvent EVENT_SEVII_TICKET_UNLOCKED_UP_TO_5
	ld hl, FerryDesinationsList_OneIsland_UpTo5
	jr nz, .loadDestinations
	ld hl, FerryDesinationsList_OneIsland_UpTo3
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
	ld hl, SeviiOneIslandDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiOneIslandDockSailorText_Canceled
.doNotHaveTicket
	call PrintText
	jp TextScriptEnd

FerryDesinationsList_OneIsland_UpTo3:
	db 3 ; #
	db FERRY_VERMILION
;	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db -1 ; end

FerryDesinationsList_OneIsland_UpTo5:
	db 5 ; #
	db FERRY_VERMILION
;	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db -1 ; end

FerryDesinationsList_OneIsland_UpTo8:
	db 8 ; #
	db FERRY_VERMILION
;	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiOneIslandDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiOneIslandDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiOneIslandDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
	text_end

SeviiOneIslandDockSailorText_NoTicket:
	text_far _SeviiIslandsDockSailorText_NoTicket
	text_end

; ----------------------------------------------

; TBE
SeviiOneIslandDockBgText2:
SeviiOneIslandDockBgText3:
	text_far _SeviiIslandsDockTheresNothingText
	text_end

; ----------------------------------------------

SeviiOneIslandDockBgText1:
	text_far _SeviiOneIslandDockBgText1
	text_end
