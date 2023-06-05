	db DEX_MSTEELIX ; pokedex id

	db  75, 125, 230,  30,  75
	;   hp  atk  def  spd  spc

	db STEEL, GROUND ; type
	db 45 ; catch rate
	db 229 ; base exp

	INCBIN "gfx/pokemon/front/msteelix.pic", 0, 1 ; sprite dimensions
	dw MSteelixPicFront, MSteelixPicBack

	db TAKE_DOWN, SCREECH, DIG, IRON_TAIL ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     FLASH_CANNON, STONE_EDGE,   EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, REST,         \
	     EXPLOSION,    ROCK_SLIDE,   SUBSTITUTE,   CUT,          STRENGTH,     \
	     COUNTER,      METEOR_MASH   
	; end

	db BANK(MSteelixPicFront)
	assert BANK(MSteelixPicFront) == BANK(MSteelixPicBack)
