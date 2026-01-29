	db DEX_SNORLAX ; pokedex id

	db 160, 110,  65,  30,  65
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 25 ; catch rate
	db 154 ; base exp

	INCBIN "gfx/pokemon/front/snorlax.pic", 0, 1 ; sprite dimensions
	dw SnorlaxPicFront, SnorlaxPicBack

	db HEADBUTT, AMNESIA, REST, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      EARTHQUAKE,   FISSURE,      \
	     PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     HYDRO_PUMP,   SELFDESTRUCT, FIRE_BLAST,   OUTRAGE,      REST,         \
	     GUNK_SHOT,    PSYWAVE,      ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     FLAIL,        BODY_PRESS,   SURF,         STRENGTH,     CURSE,        \
	     ROCK_SMASH,   ROCK_CLIMB,   WHIRLPOOL     
	; end

	db BANK(SnorlaxPicFront)
	assert BANK(SnorlaxPicFront) == BANK(SnorlaxPicBack)
