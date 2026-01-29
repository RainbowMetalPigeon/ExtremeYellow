	db DEX_VENUSAUR ; pokedex id

	db  80,  82,  83,  80, 100
	;   hp  atk  def  spd  spc

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 208 ; base exp

	INCBIN "gfx/pokemon/front/venusaur.pic", 0, 1 ; sprite dimensions
	dw VenusaurPicFront, VenusaurPicBack

	db BODY_SLAM, GROWL, LEECH_SEED, VINE_WHIP ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     MIRROR_COAT,  GIGA_DRAIN,   EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         GUNK_SHOT,    SUBSTITUTE,   \
	     CUT,          STRENGTH,     CURSE         
	; end

	db BANK(VenusaurPicFront)
	assert BANK(VenusaurPicFront) == BANK(VenusaurPicBack)
