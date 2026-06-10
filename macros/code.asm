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

; new =====================================

MACRO RPTextChooser
	CheckEvent EVENT_ROCKET_PATH
	ld hl, \2
	jr nz, .pointersFound
	ld hl, \1
.pointersFound
	ld a, l
	ld [wMapTextPtr], a
	ld a, h
	ld [wMapTextPtr+1], a
	ret
ENDM
