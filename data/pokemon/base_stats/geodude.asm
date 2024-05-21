	db DEX_GEODUDE ; pokedex id

	db  40,  80, 100,  20,  30
	;   hp  atk  def  spd  spc

	db ROCK, GROUND ; type
	db 255 ; catch rate
	db 86 ; base exp

	INCBIN "gfx/pokemon/front/geodude.pic", 0, 1 ; sprite dimensions
	dw GeodudePicFront, GeodudePicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   FISSURE,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         SELFDESTRUCT, \
	     FIRE_BLAST,   REST,         EXPLOSION,    ROCK_SLIDE,   SUBSTITUTE,   \
	     GYRO_BALL,    FLAIL,        STRENGTH,     CURSE         
	; end

	db BANK(GeodudePicFront)
	assert BANK(GeodudePicFront) == BANK(GeodudePicBack)
