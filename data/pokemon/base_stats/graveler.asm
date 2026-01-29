	db DEX_GRAVELER ; pokedex id

	db  55,  95, 115,  35,  45
	;   hp  atk  def  spd  spc

	db ROCK, GROUND ; type
	db 120 ; catch rate
	db 134 ; base exp

	INCBIN "gfx/pokemon/front/graveler.pic", 0, 1 ; sprite dimensions
	dw GravelerPicFront, GravelerPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, \
	     FIRE_BLAST,   REST,         EXPLOSION,    ROCK_SLIDE,   SUBSTITUTE,   \
	     GYRO_BALL,    BODY_PRESS,   FLAIL,        STRENGTH,     CURSE,        \
	     ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(GravelerPicFront)
	assert BANK(GravelerPicFront) == BANK(GravelerPicBack)
