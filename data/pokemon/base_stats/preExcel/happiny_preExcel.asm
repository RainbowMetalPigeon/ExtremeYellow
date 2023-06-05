	db DEX_HAPPINY ; pokedex id

	db 100,   5,   5,  30,  65
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 31 ; catch rate
	db 10 ; base exp

	INCBIN "gfx/pokemon/front/happiny.pic", 0, 1 ; sprite dimensions
	dw HappinyPicFront, HappinyPicBack

	db CHARM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(HappinyPicFront)
	assert BANK(HappinyPicFront) == BANK(HappinyPicBack)
