	db DEX_VULPIX ; pokedex id

	db  38,  41,  40,  65,  65
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 190 ; catch rate
	db 63 ; base exp

	INCBIN "gfx/pokemon/front/vulpix.pic", 0, 1 ; sprite dimensions
	dw VulpixPicFront, VulpixPicBack

	db EMBER, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  FEINT_ATTACK, \
	     WILL_O_WISP,  DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   REST,         SUBSTITUTE    
	; end

	db BANK(VulpixPicFront)
	assert BANK(VulpixPicFront) == BANK(VulpixPicBack)
