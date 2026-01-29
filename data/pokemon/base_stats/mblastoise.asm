	db DEX_MBLASTOISE ; pokedex id

	db  79, 103, 120,  78, 135
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 45 ; catch rate
	db 235 ; base exp

	INCBIN "gfx/pokemon/front/mblastoise.pic", 0, 1 ; sprite dimensions
	dw MBlastoisePicFront, MBlastoisePicBack

	db TACKLE, LEER, WATER_PULSE, WATER_GUN ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     MIRROR_COAT,  FLASH_CANNON, SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     HYDRO_PUMP,   OUTRAGE,      REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     GYRO_BALL,    BODY_PRESS,   FLAIL,        SURF,         STRENGTH,     \
	     CURSE,        ROCK_SMASH,   ROCK_CLIMB,   WATERFALL,    DIVE,         \
	     WHIRLPOOL     
	; end

	db BANK(MBlastoisePicFront)
	assert BANK(MBlastoisePicFront) == BANK(MBlastoisePicBack)
