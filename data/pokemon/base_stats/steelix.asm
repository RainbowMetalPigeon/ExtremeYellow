	db DEX_STEELIX ; pokedex id

	db  75,  85, 200,  30,  65
	;   hp  atk  def  spd  spc

	db STEEL, GROUND ; type
	db 45 ; catch rate
	db 196 ; base exp

	INCBIN "gfx/pokemon/front/steelix.pic", 0, 1 ; sprite dimensions
	dw SteelixPicFront, SteelixPicBack

	db TACKLE, SCREECH, DIG, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     FLASH_CANNON, STONE_EDGE,   EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, REST,         \
	     EXPLOSION,    ROCK_SLIDE,   SUBSTITUTE,   GYRO_BALL,    BODY_PRESS,   \
	     FLAIL,        CUT,          STRENGTH,     CURSE,        ROCK_SMASH,   \
	     ROCK_CLIMB    
	; end

	db BANK(SteelixPicFront)
	assert BANK(SteelixPicFront) == BANK(SteelixPicBack)
