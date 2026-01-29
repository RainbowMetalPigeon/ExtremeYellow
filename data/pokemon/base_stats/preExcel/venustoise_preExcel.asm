	db DEX_VENUSTOISE ; pokedex id

	db 105, 109, 131, 104, 131
	;   hp  atk  def  spd  spc

	db GRASS, WATER ; type
	db 3 ; catch rate
	db 253 ; base exp

	INCBIN "gfx/pokemon/front/venustoise.pic", 0, 1 ; sprite dimensions
	dw VenustoisePicFront, VenustoisePicBack

	db TACKLE, LEER, BUBBLE, WATER_GUN ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     MIRROR_COAT,  FLASH_CANNON, SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     HYDRO_PUMP,   OUTRAGE,      REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     GYRO_BALL,    BODY_PRESS,   FLAIL,        SURF,         STRENGTH,     \
	     SWORDS_DANCE, GIGA_DRAIN,   GUNK_SHOT,    CUT,          CURSE         
	; end

	db BANK(VenustoisePicFront)
	assert BANK(VenustoisePicFront) == BANK(VenustoisePicBack)
