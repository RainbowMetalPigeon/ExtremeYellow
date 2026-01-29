	db DEX_SLOWPOKE ; pokedex id

	db  90,  65,  65,  15,  40
	;   hp  atk  def  spd  spc

	db WATER, PSYCHIC_TYPE ; type
	db 190 ; catch rate
	db 99 ; base exp

	INCBIN "gfx/pokemon/front/slowpoke.pic", 0, 1 ; sprite dimensions
	dw SlowpokePicFront, SlowpokePicBack

	db CONFUSION, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     EARTHQUAKE,   FISSURE,      DIG,          PSYCHIC_M,    \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   \
	     FIRE_BLAST,   REST,         THUNDER_WAVE, PSYWAVE,      SHADOW_BALL,  \
	     SUBSTITUTE,   SURF,         STRENGTH,     FLASH,        CURSE,        \
	     WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(SlowpokePicFront)
	assert BANK(SlowpokePicFront) == BANK(SlowpokePicBack)
