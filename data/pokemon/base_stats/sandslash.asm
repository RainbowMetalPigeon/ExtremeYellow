	db DEX_SANDSLASH ; pokedex id

	db  75, 100, 110,  65,  55
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 90 ; catch rate
	db 163 ; base exp

	INCBIN "gfx/pokemon/front/sandslash.pic", 0, 1 ; sprite dimensions
	dw SandslashPicFront, SandslashPicBack

	db SCRATCH, SAND_ATTACK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   MIRROR_COAT,  SEISMIC_TOSS, \
	     STONE_EDGE,   EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         REST,         X_SCISSOR,    ROCK_SLIDE,   \
	     SUBSTITUTE,   GYRO_BALL,    FLAIL,        CUT,          STRENGTH,     \
	     CURSE         
	; end

	db BANK(SandslashPicFront)
	assert BANK(SandslashPicFront) == BANK(SandslashPicBack)
