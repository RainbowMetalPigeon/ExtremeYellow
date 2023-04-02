	db DEX_MACHAMP ; pokedex id

	db  90, 130,  80,  55,  65
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 193 ; base exp

	INCBIN "gfx/pokemon/front/machamp.pic", 0, 1 ; sprite dimensions
	dw MachampPicFront, MachampPicBack

	db KARATE_CHOP, LOW_KICK, LEER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     COUNTER,      SEISMIC_TOSS, EARTHQUAKE,   FISSURE,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         METRONOME,    FIRE_BLAST,   \
	     REST,         ROCK_SLIDE,   SUBSTITUTE,   STRENGTH      
	; end

	db BANK(MachampPicFront)
	assert BANK(MachampPicFront) == BANK(MachampPicBack)
