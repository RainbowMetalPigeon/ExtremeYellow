	db DEX_HITMONLEE ; pokedex id

	db  50, 120,  53,  87,  35
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 45 ; catch rate
	db 139 ; base exp

	INCBIN "gfx/pokemon/front/hitmonlee.pic", 0, 1 ; sprite dimensions
	dw HitmonleePicFront, HitmonleePicBack

	db DOUBLE_KICK, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    SEISMIC_TOSS, STONE_EDGE,   EARTHQUAKE,   MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     CURSE,        ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(HitmonleePicFront)
	assert BANK(HitmonleePicFront) == BANK(HitmonleePicBack)
