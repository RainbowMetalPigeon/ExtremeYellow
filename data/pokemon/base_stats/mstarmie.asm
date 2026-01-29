	db DEX_MSTARMIE ; pokedex id

	db  60, 140, 105, 120, 130
	;   hp  atk  def  spd  spc

	db WATER, PSYCHIC_TYPE ; type
	db 60 ; catch rate
	db 238 ; base exp

	INCBIN "gfx/pokemon/front/mstarmie.pic", 0, 1 ; sprite dimensions
	dw MStarmiePicFront, MStarmiePicBack

	db TACKLE, WATER_GUN, MIMIC, CONFUSION ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   TOXIC,        BODY_SLAM,    METEOR_MASH,  DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   FLASH_CANNON, \
	     THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         HYDRO_PUMP,   CLOSE_COMBAT, REST,         \
	     THUNDER_WAVE, PSYWAVE,      SUBSTITUTE,   GYRO_BALL,    SURF,         \
	     FLASH,        CURSE,        WATERFALL,    DIVE,         WHIRLPOOL     
	; end

	db BANK(MStarmiePicFront)
	assert BANK(MStarmiePicFront) == BANK(MStarmiePicBack)
