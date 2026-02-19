RedsHouse2F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, RedsHouse2F_ScriptPointers
	ld a, 0
	call CallFunctionInTable
	ret

RedsHouse2F_ScriptPointers:
	dw RedsHouse2FScript0
	dw RedsHouse2FScript1
	dw RedsHouse2FScript2
	dw RedsHouse2FScript3
	dw RedsHouse2FScript4

RedsHouse2FScript0: ; edited, to tell us about the options
	CheckEvent EVENT_INFORMED_ABOUT_OPTIONS
	ret nz
; if we have not been told already, check if we are near the stairs
	ld hl, CoordsData_NearStairs
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; we are near the stairs
	ld a, 5 ; RedsHouse2FInfoAboutOptions
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; boring technical stuff
	SetEvent EVENT_INFORMED_ABOUT_OPTIONS
	ret
RedsHouse2FScript1:
RedsHouse2FScript2:
RedsHouse2FScript3:
RedsHouse2FScript4:
	ret

CoordsData_NearStairs:
	dbmapcoord  6,  1
	dbmapcoord  7,  2
	db -1 ; end

RedsHouse2F_TextPointers:
	dw RedsHouse2FPersonalizationOptions
	dw RedsHouse2FRandomizationOptions
	dw RedsHouse2FLuckOptions
	dw RedsHouse2FLayoutOptions
	dw RedsHouse2FInfoAboutOptions

; -------------------------------------------------------------

RedsHouse2FPersonalizationOptions:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, RedsHouse2FPersonalizationOptions_Intro
	call PrintText
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call UpdateSprites
	callfar DisplayPersonalizationMenu ; main function
	call ClearScreen
	call LoadScreenTilesFromBuffer2
	call LoadTextBoxTilePatterns ; testing
	call ReloadMapData
	call UpdateSprites
	ld a, $1
	ldh [hAutoBGTransferEnabled], a ; testing
	ld hl, RedsHouse2FPersonalizationOptions_Outro
	call PrintText
	jp TextScriptEnd

RedsHouse2FPersonalizationOptions_Intro:
	text_far _RedsHouse2FPersonalizationOptions_Intro
	text_end

RedsHouse2FPersonalizationOptions_Outro:
	text_far _RedsHouse2FPersonalizationOptions_Outro
	text_end

; -------------------------------------------------------------

RedsHouse2FRandomizationOptions:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, RedsHouse2FRandomizationOptions_Intro
	call PrintText
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call UpdateSprites
	callfar DisplayRandomizationMenu ; main function
	call ClearScreen
	call LoadScreenTilesFromBuffer2
	call LoadTextBoxTilePatterns ; testing
	call ReloadMapData
	call UpdateSprites
	ld a, $1
	ldh [hAutoBGTransferEnabled], a ; testing
	ld hl, RedsHouse2FRandomizationOptions_Outro
	call PrintText
	jp TextScriptEnd

RedsHouse2FRandomizationOptions_Intro:
	text_far _RedsHouse2FRandomizationOptions_Intro
	text_end

RedsHouse2FRandomizationOptions_Outro:
	text_far _RedsHouse2FRandomizationOptions_Outro
	text_end

; -------------------------------------------------------------

RedsHouse2FLuckOptions:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, RedsHouse2FLuckOptions_Intro
	call PrintText
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call UpdateSprites
	callfar DisplayLuckMenu ; main function
	call ClearScreen
	call LoadScreenTilesFromBuffer2
	call LoadTextBoxTilePatterns ; testing
	call ReloadMapData
	call UpdateSprites
	ld a, $1
	ldh [hAutoBGTransferEnabled], a ; testing
	ld hl, RedsHouse2FLuckOptions_Outro
	call PrintText
	jp TextScriptEnd

RedsHouse2FLuckOptions_Intro:
	text_far _RedsHouse2FLuckOptions_Intro
	text_end

RedsHouse2FLuckOptions_Outro:
	text_far _RedsHouse2FLuckOptions_Outro
	text_end

; -------------------------------------------------------------

RedsHouse2FLayoutOptions:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, RedsHouse2FLayoutOptions_Intro
	call PrintText
	xor a
	ldh [hAutoBGTransferEnabled], a
	call ClearScreen
	call UpdateSprites
	callfar DisplayLayoutMenu ; main function
	call ClearScreen
	call LoadScreenTilesFromBuffer2
	call LoadTextBoxTilePatterns ; testing
	call ReloadMapData
	call UpdateSprites
	ld a, $1
	ldh [hAutoBGTransferEnabled], a ; testing
	ld hl, RedsHouse2FLayoutOptions_Outro
	call PrintText
	jp TextScriptEnd

RedsHouse2FLayoutOptions_Intro:
	text_far _RedsHouse2FLayoutOptions_Intro
	text_end

RedsHouse2FLayoutOptions_Outro:
	text_far _RedsHouse2FLayoutOptions_Outro
	text_end

; -------------------------------------------------------------

RedsHouse2FInfoAboutOptions:
	text_far _RedsHouse2FInfoAboutOptions
	text_end
	