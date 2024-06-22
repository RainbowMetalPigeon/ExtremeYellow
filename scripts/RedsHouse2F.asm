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

RedsHouse2FScript0:
RedsHouse2FScript1:
RedsHouse2FScript2:
RedsHouse2FScript3:
RedsHouse2FScript4:
	ret

RedsHouse2F_TextPointers:
	dw RedsHouse2FPersonalizationOptions
	dw RedsHouse2FRandomizationOptions
	dw RedsHouse2FLuckOptions

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
	ld hl, RedsHouse2FLuckOptions_Intro
	call PrintText
	jp TextScriptEnd

RedsHouse2FLuckOptions_Intro:
	text_far _RedsHouse2FLuckOptions_Intro
	text_end

RedsHouse2FLuckOptions_Outro:
	text_far _RedsHouse2FLuckOptions_Outro
	text_end
