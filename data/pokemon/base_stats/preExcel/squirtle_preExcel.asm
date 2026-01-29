	db DEX_SQUIRTLE ; pokedex id

	db  44,  48,  65,  43,  50
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 45 ; catch rate
	db 66 ; base exp

	INCBIN "gfx/pokemon/front/squirtle.pic", 0, 1 ; sprite dimensions
	dw SquirtlePicFront, SquirtlePicBack

	db TACKLE, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        DARK_PULSE,   BODY_SLAM,    \
	     DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     MIRROR_COAT,  SEISMIC_TOSS, \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     HYDRO_PUMP,   REST,         ROCK_SLIDE,   SUBSTITUTE,   GYRO_BALL,    \
	     FLAIL,        SURF,         STRENGTH,     CURSE         
	; end

	db BANK(SquirtlePicFront)
	assert BANK(SquirtlePicFront) == BANK(SquirtlePicBack)
