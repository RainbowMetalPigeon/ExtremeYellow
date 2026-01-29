	db DEX_WARTORTLE ; pokedex id

	db  59,  63,  80,  58,  65
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 45 ; catch rate
	db 143 ; base exp

	INCBIN "gfx/pokemon/front/wartortle.pic", 0, 1 ; sprite dimensions
	dw WartortlePicFront, WartortlePicBack

	db TACKLE, LEER, BUBBLE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     MIRROR_COAT,  \
	     SEISMIC_TOSS, EARTHQUAKE,   DIG,          MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         HYDRO_PUMP,   REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   GYRO_BALL,    FLAIL,        SURF,         STRENGTH,     \
	     CURSE,        ROCK_SMASH,   WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(WartortlePicFront)
	assert BANK(WartortlePicFront) == BANK(WartortlePicBack)
