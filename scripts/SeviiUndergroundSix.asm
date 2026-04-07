SeviiUndergroundSix_Script:
	call HideOrShowExitUndergroundSix
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundSix_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundSix:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementSix:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  1,  2 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundSix_ScriptPointers:
	dw SeviiUndergroundSix_Script0 ; 0
	dw SeviiUndergroundSix_ScriptUnlockExit ; 1

SeviiUndergroundSix_Script0:
	ret

SeviiUndergroundSix_ScriptUnlockExit:
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
	call ActualBlockReplacementSix
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundSix_TextPointers:
	dw SeviiUndergroundSixText1
	dw SeviiUndergroundSixText1
	dw SeviiUndergroundSixScriptText1 ; thingy is blinking
	dw SeviiUndergroundSixScriptText2 ; something opened

SeviiUndergroundSixText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundSixText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	callfar CountHowManyUndergroundButtonsArePressed
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_SIX
	ld hl, SeviiUndergroundSixText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_SIX
	ld hl, SeviiUndergroundSixText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundSixText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundSixText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundSixText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundSixScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundSixScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
