	db DEX_TANGROWTH ; pokedex id

	db 100, 100, 125,  50, 110
	;   hp  atk  def  spd  spc

	db GRASS, GRASS ; type
	db 35 ; catch rate
	db 211 ; base exp

	INCBIN "gfx/pokemon/front/tangrowth.pic", 0, 1 ; sprite dimensions
	dw TangrowthPicFront, TangrowthPicBack

	db TACKLE, MEGA_DRAIN, ROCK_TOMB, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     GIGA_DRAIN,   EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         REST,         ROCK_SLIDE,   SUBSTITUTE,   FLAIL,        \
	     CUT,          STRENGTH,     FLASH,        CURSE,        ROCK_SMASH    
	; end

	db BANK(TangrowthPicFront)
	assert BANK(TangrowthPicFront) == BANK(TangrowthPicBack)
