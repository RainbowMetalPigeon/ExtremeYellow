	db DEX_SMOOCHUM ; pokedex id

	db  45,  30,  15,  65,  65
	;   hp  atk  def  spd  spc

	db ICE, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 10 ; base exp

	INCBIN "gfx/pokemon/front/smoochum.pic", 0, 1 ; sprite dimensions
	dw SmoochumPicFront, SmoochumPicBack

	db CHARM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(SmoochumPicFront)
	assert BANK(SmoochumPicFront) == BANK(SmoochumPicBack)
