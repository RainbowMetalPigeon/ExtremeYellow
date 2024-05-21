	db DEX_NIDOKING ; pokedex id

	db  81, 102,  77,  85,  75
	;   hp  atk  def  spd  spc

	db POISON, GROUND ; type
	db 45 ; catch rate
	db 195 ; base exp

	INCBIN "gfx/pokemon/front/nidoking.pic", 0, 1 ; sprite dimensions
	dw NidokingPicFront, NidokingPicBack

	db TACKLE, HORN_ATTACK, POISON_STING, THRASH ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   MEGAHORN,     COUNTER,      TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, STONE_EDGE,   THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   OUTRAGE,      REST,         ROCK_SLIDE,   \
	     SHADOW_BALL,  SUBSTITUTE,   BODY_PRESS,   CUT,          SURF,         \
	     STRENGTH,     GUNK_SHOT,    CURSE         
	; end

	db BANK(NidokingPicFront)
	assert BANK(NidokingPicFront) == BANK(NidokingPicBack)
