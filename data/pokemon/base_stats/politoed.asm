	db DEX_POLITOED ; pokedex id

	db  90,  75,  75,  70,  90
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 45 ; catch rate
	db 185 ; base exp

	INCBIN "gfx/pokemon/front/politoed.pic", 0, 1 ; sprite dimensions
	dw PolitoedPicFront, PolitoedPicBack

	db HYPNOSIS, BUBBLEBEAM, MUD_SHOT, BODY_SLAM ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    BUBBLEBEAM,   \
	     METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   REST,         PSYWAVE,      \
	     SUBSTITUTE,   SURF,         STRENGTH,     CURSE,        ROCK_SMASH,   \
	     WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(PolitoedPicFront)
	assert BANK(PolitoedPicFront) == BANK(PolitoedPicBack)
