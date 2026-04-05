SeviiUndergroundOne_Script:
	call HideOrShowExitUndergroundOne
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundOne_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundOne:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementOne:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  1, 33 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundOne_ScriptPointers:
	dw SeviiUndergroundOne_Script0 ; 0
	dw SeviiUndergroundOne_ScriptUnlockExit ; 1

SeviiUndergroundOne_Script0:
	ret

SeviiUndergroundOne_ScriptUnlockExit:
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
	call ActualBlockReplacementOne
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundOne_TextPointers:
	dw SeviiUndergroundOneText1
	dw SeviiUndergroundOneText1
	dw SeviiUndergroundOneScriptText1 ; thingy is blinking
	dw SeviiUndergroundOneScriptText2 ; something opened

SeviiUndergroundOneText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundOneText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_ONE
	ld hl, SeviiUndergroundOneText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_ONE
	ld hl, SeviiUndergroundOneText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundOneText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundOneText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundOneText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundOneScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundOneScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
