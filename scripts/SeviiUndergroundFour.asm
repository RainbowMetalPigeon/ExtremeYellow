SeviiUndergroundFour_Script:
	call HideOrShowExitUndergroundFour
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundFour_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundFour:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementFour:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  2, 26 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundFour_ScriptPointers:
	dw SeviiUndergroundFour_Script0 ; 0
	dw SeviiUndergroundFour_ScriptUnlockExit ; 1

SeviiUndergroundFour_Script0:
	ret

SeviiUndergroundFour_ScriptUnlockExit:
; check if with this button press all of them are pressed
	callfar CheckIfAllUndergroundButtonsArePressed ; nz if all are pressed
	jr z, .resetScripts
; all are pressed now
;	call WaitForTextScrollButtonPress ; wait for a button press after displaying all the text
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SEVII_UNDERGROUND_OPENED
	callfar ShakeScreen
	call PlayDefaultMusic
	call ActualBlockReplacementFour
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundFour_TextPointers:
	dw SeviiUndergroundFourText1
	dw SeviiUndergroundFourText1
	dw SeviiUndergroundFourScriptText1 ; thingy is blinking
	dw SeviiUndergroundFourScriptText2 ; something opened

SeviiUndergroundFourText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundFourText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_FOUR
	ld hl, SeviiUndergroundFourText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_FOUR
	ld hl, SeviiUndergroundFourText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundFourText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundFourText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundFourText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundFourScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundFourScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
