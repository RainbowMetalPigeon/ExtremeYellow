	db DEX_HITMONTOP ; pokedex id

	db  50,  95,  95,  70,  35
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 138 ; base exp

	INCBIN "gfx/pokemon/front/hitmontop.pic", 0, 1 ; sprite dimensions
	dw HitmontopPicFront, HitmontopPicBack

	db DOUBLE_KICK, COMET_PUNCH, AGILITY, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  CLOSE_COMBAT, REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   GYRO_BALL,    STRENGTH,     CURSE         
	; end

	db BANK(HitmontopPicFront)
	assert BANK(HitmontopPicFront) == BANK(HitmontopPicBack)
