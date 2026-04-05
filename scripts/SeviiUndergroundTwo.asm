SeviiUndergroundTwo_Script:
	call HideOrShowExitUndergroundTwo
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundTwo_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundTwo:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementTwo:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc, 13, 10 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundTwo_ScriptPointers:
	dw SeviiUndergroundTwo_Script0 ; 0
	dw SeviiUndergroundTwo_ScriptUnlockExit ; 1

SeviiUndergroundTwo_Script0:
	ret

SeviiUndergroundTwo_ScriptUnlockExit:
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
	call ActualBlockReplacementTwo
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundTwo_TextPointers:
	dw SeviiUndergroundTwoText1
	dw SeviiUndergroundTwoText1
	dw SeviiUndergroundTwoScriptText1 ; thingy is blinking
	dw SeviiUndergroundTwoScriptText2 ; something opened

SeviiUndergroundTwoText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundTwoText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_TWO
	ld hl, SeviiUndergroundTwoText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_TWO
	ld hl, SeviiUndergroundTwoText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundTwoText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundTwoText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundTwoText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundTwoScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundTwoScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
