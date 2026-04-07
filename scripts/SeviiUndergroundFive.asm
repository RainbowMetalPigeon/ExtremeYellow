SeviiUndergroundFive_Script:
	call HideOrShowExitUndergroundFive
	call EnableAutoTextBoxDrawing
	ld de, SeviiUndergroundFive_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowExitUndergroundFive:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
; check if we need to change the block
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ret z
	; fallthrough
; replace block
ActualBlockReplacementFive:
	ld a, $60 ; yes-entrance block
;	ld a, $2F ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  1,  7 ; y-x block coordinates ; map-specific
	predef_jump ReplaceTileBlock

SeviiUndergroundFive_ScriptPointers:
	dw SeviiUndergroundFive_Script0 ; 0
	dw SeviiUndergroundFive_ScriptUnlockExit ; 1

SeviiUndergroundFive_Script0:
	ret

SeviiUndergroundFive_ScriptUnlockExit:
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
	call ActualBlockReplacementFive
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.resetScripts
	xor a
	ld [wCurMapScript], a
	ret

SeviiUndergroundFive_TextPointers:
	dw SeviiUndergroundFiveText1
	dw SeviiUndergroundFiveText1
	dw SeviiUndergroundFiveScriptText1 ; thingy is blinking
	dw SeviiUndergroundFiveScriptText2 ; something opened

SeviiUndergroundFiveText1:
	text_asm
; all already done?
	CheckEvent EVENT_SEVII_UNDERGROUND_OPENED
	ld hl, SeviiUndergroundFiveText1_AlreadyOpened
	jr nz, .printAndEnd
; this one already done?
	callfar CountHowManyUndergroundButtonsArePressed
	CheckEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_FIVE
	ld hl, SeviiUndergroundFiveText1_ThisButtonAlreadyPressed
	jr nz, .printAndEnd
; press this one
	ld a, SFX_GO_INSIDE
	call PlaySound
	SetEvent EVENT_SEVII_UNDERGROUND_BUTTON_PRESSED_FIVE
	ld hl, SeviiUndergroundFiveText1_PressThisButton
; handle script
	ld a, 1
	ld [wCurMapScript], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiUndergroundFiveText1_AlreadyOpened:
	text_far _SeviiUndergroundText1_AlreadyOpened
	text_end

SeviiUndergroundFiveText1_ThisButtonAlreadyPressed:
	text_far _SeviiUndergroundText1_ThisButtonAlreadyPressed
	text_end

SeviiUndergroundFiveText1_PressThisButton:
	text_far _SeviiUndergroundText1_PressThisButton
	text_end

SeviiUndergroundFiveScriptText1:
	text_far _SeviiUndergroundScriptText1
	text_end

SeviiUndergroundFiveScriptText2:
	text_far _SeviiUndergroundScriptText2
	text_end
