SeviiUndergroundThree_Script:
	call HideOrShowExitUndergroundThree
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundThree_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundThree:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementThree:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc, 11,  3 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundThree_ScriptPointers:
	dw SeviiUndergroundThree_Script0 ; 0
	dw SeviiUndergroundThree_ScriptUnlockExit ; 1

SeviiUndergroundThree_Script0:
	ret

SeviiUndergroundThree_ScriptUnlockExit:
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
	call ActualBlockReplacementThree
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundThree_TextPointers:
	dw SeviiUndergroundThreeText1
	dw SeviiUndergroundThreeText1
	dw SeviiUndergroundThreeScriptText1 ; thingy is blinking
	dw SeviiUndergroundThreeScriptText2 ; something opened

SeviiUndergroundThreeText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundThreeText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_THREE
	ld hl, SeviiUndergroundThreeText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_THREE
	ld hl, SeviiUndergroundThreeText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundThreeText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundThreeText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundThreeText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundThreeScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundThreeScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
