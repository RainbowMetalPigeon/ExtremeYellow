	db DEX_SLOWKING ; pokedex id

	db  95,  75,  80,  30, 105
	;   hp  atk  def  spd  spc

	db WATER, PSYCHIC_TYPE ; type
	db 74 ; catch rate
	db 164 ; base exp

	INCBIN "gfx/pokemon/front/slowking.pic", 0, 1 ; sprite dimensions
	dw SlowkingPicFront, SlowkingPicBack

	db PSYCHIC_M, DISABLE, HEADBUTT, ZEN_HEADBUTT ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     REST,         THUNDER_WAVE, PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   \
	     SURF,         STRENGTH,     FLASH,        CURSE         
	; end

	db BANK(SlowkingPicFront)
	assert BANK(SlowkingPicFront) == BANK(SlowkingPicBack)
