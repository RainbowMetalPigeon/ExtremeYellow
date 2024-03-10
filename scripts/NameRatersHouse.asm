NameRatersHouse_Script:
	jp EnableAutoTextBoxDrawing

NameRaterScript_1da15:
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ret

NameRaterScript_1da20:
	callfar IsThisPartymonStarterPikachu_Party ; sets carry flag if it's Starter Pikachu ; new
	jr c, .canRename ; new
	ld hl, wPartyMonOT
	ld bc, NAME_LENGTH
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wPlayerName
	ld c, NAME_LENGTH
	call .asm_1da47
	jr c, .asm_1da52
	ld hl, wPartyMon1OTID
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes
	ld de, wPlayerID
	ld c, $2
.asm_1da47
	ld a, [de]
	cp [hl]
	jr nz, .asm_1da52
	inc hl
	inc de
	dec c
	jr nz, .asm_1da47
.canRename ; new label
	and a
	ret
.asm_1da52 ; cannot rename
	scf
	ret

NameRatersHouse_TextPointers:
	dw NameRaterText1

NameRaterText1:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, NameRaterText_1dab3
	call NameRaterScript_1da15
	jr nz, .asm_1daae
	ld hl, NameRaterText_1dab8
	call PrintText
	xor a
	ld [wPartyMenuTypeOrMessageID], a
	ld [wUpdateSpritesEnabled], a
	ld [wMenuItemToSwap], a
	call DisplayPartyMenu
	push af
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadGBPal
	pop af
	jr c, .asm_1daae
	call GetPartyMonName2
; new, to handle MISSINGNO, shouldn't need push-pop
	ld a, [wWhichPokemon]
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl] ; species
	cp CHANSEY ; TBE with MISSINGNO, testing
	jp z, .cantHandleThisMon
; back to vanilla
	call NameRaterScript_1da20
	ld hl, NameRaterText_1dad1
	jr c, .asm_1daa8
	call ReloadTilesetTilePatterns ; new, to expand tileset
	ld hl, NameRaterText_1dabd
	call NameRaterScript_1da15
	jr nz, .asm_1daae
	ld hl, NameRaterText_1dac2
	call PrintText
	farcall DisplayNameRaterScreen
	call ReloadTilesetTilePatterns ; new, to expand tileset
	jr c, .asm_1daae
	ld hl, NameRaterText_1dac7
.asm_1daa8
	call PrintText
	jp TextScriptEnd
.asm_1daae
	ld hl, NameRaterText_1dacc
	jr .asm_1daa8
.cantHandleThisMon ; new
	ld hl, NameRaterText_cantHandleThisMon
	jr .asm_1daa8

NameRaterText_1dab3:
	text_far _NameRaterText_1dab3
	text_end

NameRaterText_1dab8:
	text_far _NameRaterText_1dab8
	text_end

NameRaterText_1dabd:
	text_far _NameRaterText_1dabd
	text_end

NameRaterText_1dac2:
	text_far _NameRaterText_1dac2
	text_end

NameRaterText_1dac7:
	text_far _NameRaterText_1dac7
	text_end

NameRaterText_1dacc:
	text_far _NameRaterText_1dacc
	text_end

NameRaterText_1dad1:
	text_far _NameRaterText_1dad1
	text_end

NameRaterText_cantHandleThisMon: ; new
	text_far _DayCareCantTakeThisMon ; same as Day Care
	text_end
