	db DEX_MAGBY ; pokedex id

	db  45,  75,  37,  83,  55
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 10 ; base exp

	INCBIN "gfx/pokemon/front/magby.pic", 0, 1 ; sprite dimensions
	dw MagbyPicFront, MagbyPicBack

	db CHARM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(MagbyPicFront)
	assert BANK(MagbyPicFront) == BANK(MagbyPicBack)
