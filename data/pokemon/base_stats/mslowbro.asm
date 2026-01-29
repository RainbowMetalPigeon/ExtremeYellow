	db DEX_MSLOWBRO ; pokedex id

	db  95,  75, 180,  30, 105
	;   hp  atk  def  spd  spc

	db WATER, PSYCHIC_TYPE ; type
	db 45 ; catch rate
	db 230 ; base exp

	INCBIN "gfx/pokemon/front/mslowbro.pic", 0, 1 ; sprite dimensions
	dw MSlowbroPicFront, MSlowbroPicBack

	db PSYCHIC_M, HARDEN, HYDRO_PUMP, AMNESIA ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   SEISMIC_TOSS, \
	     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     REST,         THUNDER_WAVE, PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   \
	     SURF,         STRENGTH,     FLASH,        EXPLOSION,    FLASH_CANNON, \
	     THUNDERBOLT,  DARK_PULSE,   MIRROR_COAT,  CURSE,        ROCK_SMASH,   \
	     WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(MSlowbroPicFront)
	assert BANK(MSlowbroPicFront) == BANK(MSlowbroPicBack)
