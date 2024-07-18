; edited: now just a wrapper for the actual function which is in
; engine/menus/print_text_internal.asm
PrintLetterDelay::
	push hl
	push de
	push bc
	push af
	callfar PrintLetterDelay_
	pop af
	pop bc
	pop de
	pop hl
	ret
