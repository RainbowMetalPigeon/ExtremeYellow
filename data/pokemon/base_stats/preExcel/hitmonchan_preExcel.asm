	db DEX_HITMONCHAN ; pokedex id

	db  50, 105,  79,  76,  35
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 140 ; base exp

	INCBIN "gfx/pokemon/front/hitmonchan.pic", 0, 1 ; sprite dimensions
	dw HitmonchanPicFront, HitmonchanPicBack

	db COMET_PUNCH, AGILITY, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     CURSE         
	; end

	db BANK(HitmonchanPicFront)
	assert BANK(HitmonchanPicFront) == BANK(HitmonchanPicBack)
