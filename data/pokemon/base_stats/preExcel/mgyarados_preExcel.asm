	db DEX_MGYARADOS ; pokedex id

	db  95, 155, 109,  81, 130
	;   hp  atk  def  spd  spc

	db WATER, DARK ; type
	db 45 ; catch rate
	db 245 ; base exp

	INCBIN "gfx/pokemon/front/mgyarados.pic", 0, 1 ; sprite dimensions
	dw MGyaradosPicFront, MGyaradosPicBack

	db DRAGON_RAGE, CRUNCH, TWISTER, HYPER_BEAM ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         HYDRO_PUMP,   FIRE_BLAST,   OUTRAGE,      REST,         \
	     THUNDER_WAVE, SUBSTITUTE,   SURF,         STRENGTH,     ROCK_SLIDE,   \
	     WILL_O_WISP,  GUNK_SHOT     
	; end

	db BANK(MGyaradosPicFront)
	assert BANK(MGyaradosPicFront) == BANK(MGyaradosPicBack)
