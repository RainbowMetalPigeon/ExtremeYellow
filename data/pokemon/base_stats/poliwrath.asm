	db DEX_POLIWRATH ; pokedex id

	db  90,  95,  95,  70,  70
	;   hp  atk  def  spd  spc

	db WATER, FIGHTING ; type
	db 45 ; catch rate
	db 185 ; base exp

	INCBIN "gfx/pokemon/front/poliwrath.pic", 0, 1 ; sprite dimensions
	dw PoliwrathPicFront, PoliwrathPicBack

	db HYPNOSIS, WATER_GUN, FURY_SWIPES, BODY_SLAM ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   CLOSE_COMBAT, \
	     REST,         PSYWAVE,      ROCK_SLIDE,   SUBSTITUTE,   SURF,         \
	     STRENGTH,     CURSE,        ROCK_SMASH,   ROCK_CLIMB,   WATERFALL,    \
	     DIVE,         WHIRLPOOL     
	; end

	db BANK(PoliwrathPicFront)
	assert BANK(PoliwrathPicFront) == BANK(PoliwrathPicBack)
