	db DEX_GOLEM ; pokedex id

	db  80, 120, 130,  45,  55
	;   hp  atk  def  spd  spc

	db ROCK, GROUND ; type
	db 45 ; catch rate
	db 177 ; base exp

	INCBIN "gfx/pokemon/front/golem.pic", 0, 1 ; sprite dimensions
	dw GolemPicFront, GolemPicBack

	db TACKLE, DEFENSE_CURL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     SELFDESTRUCT, FIRE_BLAST,   REST,         EXPLOSION,    ROCK_SLIDE,   \
	     SUBSTITUTE,   GYRO_BALL,    BODY_PRESS,   FLAIL,        STRENGTH,     \
	     CURSE         
	; end

	db BANK(GolemPicFront)
	assert BANK(GolemPicFront) == BANK(GolemPicBack)
