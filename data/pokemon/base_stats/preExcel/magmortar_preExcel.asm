	db DEX_MAGMORTAR ; pokedex id

	db  75,  95,  67,  83, 125
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 199 ; base exp

	INCBIN "gfx/pokemon/front/magmortar.pic", 0, 1 ; sprite dimensions
	dw MagmortarPicFront, MagmortarPicBack

	db EMBER, ROCK_TOMB, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, FEINT_ATTACK, WILL_O_WISP,  \
	     THUNDERBOLT,  EARTHQUAKE,   PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         FIRE_BLAST,   REST,         PSYWAVE,      ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     CURSE         
	; end

	db BANK(MagmortarPicFront)
	assert BANK(MagmortarPicFront) == BANK(MagmortarPicBack)
