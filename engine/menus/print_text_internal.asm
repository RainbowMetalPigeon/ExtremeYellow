; new: originally this function was in home/print_text.asm, moved here to save space
; edited: added check for playing sound even under instant text printing

; This function is used to wait a short period after printing a letter to the
; screen unless the player presses the A/B button or the delay is turned off
; through the [wd730] or [wLetterPrintingDelayFlags] flags.
PrintLetterDelay_::
; new block for instant text printing, from Chatot4444
	ld a, [wOptions]
	and %111
	cp 1
	jr nz, .notInstantPrinting
; new, from Jojo: fix no-sound-with-instant-text bug
	push hl
	ld hl, wChannelSoundIDs + CHAN5
	ld a, [hli]
	add [hl]
	inc hl
	add [hl]
	inc hl
	add [hl]
	pop hl
	jr z, .continue
	SetEvent EVENT_SOUND_PLAYING_DURING_TEXT
.continue
	ret
.notInstantPrinting
; vanilla code
	ld a, [wd730]
	bit 6, a
	ret nz
	ld a, [wLetterPrintingDelayFlags]
	bit 1, a
	ret z
	push hl
	push de
	push bc

	ld a, [wLetterPrintingDelayFlags]
	bit 0, a
	jr z, .waitOneFrame
	ld a, [wOptions]
	dec a ; new, added to speed up text printing
	dec a ; new, added to speed up text printing
	and $f
	ldh [hFrameCounter], a
	jr .checkButtons
.waitOneFrame
	ld a, 1
	ldh [hFrameCounter], a
.checkButtons
	call Joypad
	ldh a, [hJoyHeld]
.checkAButton
	bit BIT_A_BUTTON, a
	jr z, .checkBButton
	jr .endWait
.checkBButton
	bit BIT_B_BUTTON, a
	jr z, .buttonsNotPressed
.endWait
	call DelayFrame
	jr .done
.buttonsNotPressed ; if neither A nor B is pressed
	ldh a, [hFrameCounter]
	and a
	jr nz, .checkButtons
.done
	pop bc
	pop de
	pop hl
	ret
