LoadFontTilePatterns::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, FontGraphics
	ld de, vFont
	ld bc, FontGraphicsEnd - FontGraphics
	ld a, BANK(FontGraphics)
	jp FarCopyDataDouble ; if LCD is off, transfer all at once
.on
	ld de, FontGraphics
	ld hl, vFont
	lb bc, BANK(FontGraphics), (FontGraphicsEnd - FontGraphics) / $8
	jp CopyVideoDataDouble ; if LCD is on, transfer during V-blank

LoadTextBoxTilePatterns::
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, TextBoxGraphics
	ld de, vChars2 tile $79 ; new, to expand tileset ; edited, move VS: to text area
	ld bc, TextBoxGraphicsEnd - TextBoxGraphics
	ld a, BANK(TextBoxGraphics)
	jp FarCopyData ; if LCD is off, transfer all at once
.on
	ld de, TextBoxGraphics
	ld hl, vChars2 tile $79 ; new, to expand tileset ; edited, move VS: to text area
	lb bc, BANK(TextBoxGraphics), (TextBoxGraphicsEnd - TextBoxGraphics) / $10
	jp CopyVideoData ; if LCD is on, transfer during V-blank

LoadHpBarAndStatusTilePatterns::
;	ldh a, [rLCDC]
;	bit 7, a ; is the LCD enabled?
;	jr nz, .on
;.off
;	ld hl, HpBarAndStatusGraphics
;	ld de, vChars2 tile $62
;	ld bc, HpBarAndStatusGraphicsEnd - HpBarAndStatusGraphics
;	ld a, BANK(HpBarAndStatusGraphics)
;	jp FarCopyData ; if LCD is off, transfer all at once
;.on
	ld de, HpBarAndStatusGraphics
	ld hl, vChars2 tile $62
	lb bc, BANK(HpBarAndStatusGraphics), (HpBarAndStatusGraphicsEnd - HpBarAndStatusGraphics) / $10
;	jp CopyVideoData ; if LCD is on, transfer during V-blank
	call GoodCopyVideoData
	ld de, EXPBarGraphics
	ld hl, vChars1 tile $40
	lb bc, BANK(EXPBarGraphics), (EXPBarGraphicsEnd - EXPBarGraphics) / $10
	jp GoodCopyVideoData

GoodCopyVideoData:
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jp nz, CopyVideoData ; if LCD is on, transfer during V-blank
	ld a, b
	push hl
	push de
	ld h, 0
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop hl
	pop de
	jp FarCopyData ; if LCD is off, transfer all at once
