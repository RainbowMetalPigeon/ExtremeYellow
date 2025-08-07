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
	jpfar PerformFerryWarp ; TBE
;	jpfar WarpScriptToKanto

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
	ld hl, SeviiIslandsDockSailorText_Intro
	call PrintText
; print the list of destinations
	xor a
	ld [wCurrentMenuItem], a
	ld [wListScrollOffset], a
	ld hl, FerryDesinationsList
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
	ld hl, SeviiIslandsDockSailorText_LetsGo
	call PrintText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
; we canceled with B
.exit
	xor a
	ld [wListScrollOffset], a
	ld hl, SeviiIslandsDockSailorText_Canceled
	call PrintText
	jp TextScriptEnd

FerryDesinationsList:
	db 9 ; #
	db FERRY_VERMILION
	db FERRY_SEVII_ONE
	db FERRY_SEVII_TWO
	db FERRY_SEVII_THREE
	db FERRY_SEVII_FOUR
	db FERRY_SEVII_FIVE
	db FERRY_SEVII_SIX
	db FERRY_SEVII_SEVEN
	db FERRY_SEVII_EIGHT
	db -1 ; end

SeviiIslandsDockSailorText_Intro:
	text_far _SeviiIslandsDockSailorText_Intro
	text_end

SeviiIslandsDockSailorText_LetsGo:
	text_far _SeviiIslandsDockSailorText_LetsGo
	text_end

SeviiIslandsDockSailorText_Canceled:
	text_far _SeviiIslandsDockSailorText_Canceled
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
