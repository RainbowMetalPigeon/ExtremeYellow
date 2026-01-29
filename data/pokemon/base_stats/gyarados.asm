	db DEX_GYARADOS ; pokedex id

	db  95, 125,  79,  81, 100
	;   hp  atk  def  spd  spc

	db WATER, FLYING ; type
	db 45 ; catch rate
	db 214 ; base exp

	INCBIN "gfx/pokemon/front/gyarados.pic", 0, 1 ; sprite dimensions
	dw GyaradosPicFront, GyaradosPicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         HYDRO_PUMP,   FIRE_BLAST,   OUTRAGE,      REST,         \
	     THUNDER_WAVE, SUBSTITUTE,   FLAIL,        SURF,         STRENGTH,     \
	     CURSE,        ROCK_SMASH,   WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(GyaradosPicFront)
	assert BANK(GyaradosPicFront) == BANK(GyaradosPicBack)
