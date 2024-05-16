;\1 = hideshow variable index
;\2 = return result in carry instead of zero flag
MACRO CheckHideShow
	DEF hideshow_byte = ((\1) / 8)
	ld a, [wMissableObjectFlags + hideshow_byte]

	IF _NARG > 1
		IF ((\1) % 8) == 7
			add a
		ELSE
			REPT ((\1) % 8) + 1
				rrca
			ENDR
		ENDC
	ELSE
		bit (\1) % 8, a
	ENDC
ENDM

;\1 = hideshow variable index
;\2 = return result in carry instead of zero flag
MACRO CheckHideShowExtra
	DEF hideshow_byte = ((\1) / 8)
	ld a, [wMissableObjectFlagsExtra + hideshow_byte]

	IF _NARG > 1
		IF ((\1) % 8) == 7
			add a
		ELSE
			REPT ((\1) % 8) + 1
				rrca
			ENDR
		ENDC
	ELSE
		bit (\1) % 8, a
	ENDC
ENDM
