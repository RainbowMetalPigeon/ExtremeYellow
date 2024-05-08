SoftReset::
	call StopAllSounds
	call GBPalWhiteOut
	ld c, 32
	call DelayFrames
	; fallthrough

Init::
;  Program init.

DEF rLCDC_DEFAULT EQU %11100011
; * LCD enabled
; * Window tile map at $9C00
; * Window display enabled
; * BG and window tile data at $8800
; * BG tile map at $9800
; * 8x8 OBJ size
; * OBJ display enabled
; * BG display enabled

	di

	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rTMA], a
	ldh [rTAC], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a

	ld a, rLCDC_ENABLE_MASK
	ldh [rLCDC], a
	call DisableLCD

	ld sp, wStack

	ld hl, WRAM0_Begin
	ld bc, WRAM1_End - WRAM0_Begin
.loop
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .loop

; new, to update the Random_ function
;joenote - implement xor shift RNG
;Initialize the RNG state. It can be initialized to anything but zero; this is just a simple way of doing it.
;Initialize with whatever random garbage is in hram to get an initial seed.
	ld a, [hJoyLast]	;ffb1
	and a
	push af
	ld a, [hFrameCounter]	;ffd5
	and a
	push af
	ld a, [hDividend2]	;ffe5
	and a
	push af
	ld a, [hSpriteAnimFrameCounter]	;ffea
	and a
	push af
; back to vanilla

	call ClearVram

	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin - 1
	call FillMemory

	call ClearSprites

; new, to update the Random_ function
;finish initializing RNG
;joenote - added lines to save the RNG seed
	ld hl, $DEF0
	pop af
	call z, .inc_a
	ld [hRandomAdd], a
	ld [hli], a
	pop af
	call z, .inc_a
	ld [hRandomSub], a
	ld [hli], a
	pop af
	call z, .inc_a
	ld [hRandomLast], a
	ld [hli], a
	pop af
	call z, .inc_a
	ld [hRandomLast + 1], a
	ld [hli], a
; back to vanilla

	ld a, BANK(WriteDMACodeToHRAM)
	ldh [hLoadedROMBank], a
	ld [MBC1RomBank], a
	call WriteDMACodeToHRAM

	xor a
	ldh [hTileAnimations], a
	ldh [rSTAT], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rIF], a
	ld [wc0f3], a
	ld [wc0f3 + 1], a
	ld a, 1 << VBLANK + 1 << TIMER + 1 << SERIAL
	ldh [rIE], a

	ld a, 144 ; move the window off-screen
	ldh [hWY], a
	ldh [rWY], a
	ld a, 7
	ldh [rWX], a

	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a

	ld h, HIGH(vBGMap0)
	call ClearBgMap
	ld h, HIGH(vBGMap1)
	call ClearBgMap

	ld a, rLCDC_DEFAULT
	ldh [rLCDC], a
	ld a, 16
	ldh [hSoftReset], a
	call StopAllSounds

	ei

	predef LoadSGB

	ld a, BANK(SFX_Shooting_Star)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	ld a, $9c
	ldh [hAutoBGTransferDest + 1], a
	xor a
	ldh [hAutoBGTransferDest], a
	dec a
	ld [wUpdateSpritesEnabled], a

	predef PlayIntro

	call DisableLCD
	call ClearVram
	call GBPalNormal
	call ClearSprites
	ld a, rLCDC_DEFAULT
	ldh [rLCDC], a

	jp SetDefaultNamesBeforeTitlescreen
; new, to update the Random_ function
.inc_a
	inc a
	ret
; back to vanilla

ClearVram::
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
	jp FillMemory


StopAllSounds::
	ld a, BANK("Audio Engine 1")
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	xor a
	ld [wAudioFadeOutControl], a
	ld [wNewSoundID], a
	ld [wLastMusicSoundID], a
	jp StopAllMusic
