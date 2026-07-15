; Syntactic sugar macros

MACRO lb ; r, hi, lo
	ld \1, ((\2) & $ff) << 8 + ((\3) & $ff)
ENDM

MACRO ldpal
	ld \1, \2 << 6 | \3 << 4 | \4 << 2 | \5
ENDM

; Design patterns

MACRO dict
	IF \1 == 0
		and a
	ELSE
		cp \1
	ENDC
	jp z, \2
ENDM

MACRO switch_sram_bank
; assumes that the requested bank (0-3) is in register a
	push bc
	ld b, a
	ld a, [wCurrentSaveSlot] ; 0, 1, 2, or 3
	add a ; double
	add a ; quadruple the slot, because we have 4 banks per save slot
	add b ; add the requested bank
	ld [MBC1SRamBank], a ; write to hardware register $4000
	pop bc
ENDM
