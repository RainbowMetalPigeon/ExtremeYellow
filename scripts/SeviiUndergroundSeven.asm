SeviiUndergroundSeven_Script:
	call HideOrShowExitUndergroundSeven
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundSeven_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundSeven:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementSeven:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  2, 19 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundSeven_ScriptPointers:
	dw SeviiUndergroundSeven_Script0 ; 0
	dw SeviiUndergroundSeven_ScriptUnlockExit ; 1

SeviiUndergroundSeven_Script0:
	ret

SeviiUndergroundSeven_ScriptUnlockExit:
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
	call ActualBlockReplacementSeven
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundSeven_TextPointers:
	dw SeviiUndergroundSevenText1
	dw SeviiUndergroundSevenText1
	dw SeviiUndergroundSevenScriptText1 ; thingy is blinking
	dw SeviiUndergroundSevenScriptText2 ; something opened

SeviiUndergroundSevenText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundSevenText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	callfar CountHowManyUndergroundButtonsArePressed
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_SEVEN
	ld hl, SeviiUndergroundSevenText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_SEVEN
	ld hl, SeviiUndergroundSevenText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundSevenText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundSevenText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundSevenText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundSevenScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundSevenScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
