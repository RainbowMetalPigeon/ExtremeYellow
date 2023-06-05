	db DEX_MIME_JR ; pokedex id

	db  20,  25,  45,  60,  70
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, FAIRY ; type
	db 45 ; catch rate
	db 10 ; base exp

	INCBIN "gfx/pokemon/front/mimejr.pic", 0, 1 ; sprite dimensions
	dw MimeJrPicFront, MimeJrPicBack

	db CHARM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(MimeJrPicFront)
	assert BANK(MimeJrPicFront) == BANK(MimeJrPicBack)
