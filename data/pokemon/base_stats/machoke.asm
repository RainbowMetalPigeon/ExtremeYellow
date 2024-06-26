	db DEX_MACHOKE ; pokedex id

	db  80, 100,  70,  45,  50
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 90 ; catch rate
	db 146 ; base exp

	INCBIN "gfx/pokemon/front/machoke.pic", 0, 1 ; sprite dimensions
	dw MachokePicFront, MachokePicBack

	db KARATE_CHOP, LOW_KICK, LEER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, FIRE_BLAST,   \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   STRENGTH,     CURSE         
	; end

	db BANK(MachokePicFront)
	assert BANK(MachokePicFront) == BANK(MachokePicBack)
