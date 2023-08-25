	db DEX_MVENUSAUR ; pokedex id

	db  80, 100, 123,  80, 122
	;   hp  atk  def  spd  spc

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 233 ; base exp

	INCBIN "gfx/pokemon/front/mvenusaur.pic", 0, 1 ; sprite dimensions
	dw MVenusaurPicFront, MVenusaurPicBack

	db TACKLE, GROWL, LEECH_SEED, VINE_WHIP ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     MIRROR_COAT,  GIGA_DRAIN,   EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         GUNK_SHOT,    SUBSTITUTE,   \
	     CUT,          STRENGTH      
	; end

	db BANK(MVenusaurPicFront)
	assert BANK(MVenusaurPicFront) == BANK(MVenusaurPicBack)
