	db DEX_SANDSHREW ; pokedex id

	db  50,  75,  85,  40,  30
	;   hp  atk  def  spd  spc

	db GROUND, GROUND ; type
	db 255 ; catch rate
	db 93 ; base exp

	INCBIN "gfx/pokemon/front/sandshrew.pic", 0, 1 ; sprite dimensions
	dw SandshrewPicFront, SandshrewPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     ICE_BEAM,     BLIZZARD,     MIRROR_COAT,  SEISMIC_TOSS, STONE_EDGE,   \
	     EARTHQUAKE,   DIG,          MIMIC,        DOUBLE_TEAM,  BIDE,         \
	     REST,         X_SCISSOR,    ROCK_SLIDE,   SUBSTITUTE,   GYRO_BALL,    \
	     FLAIL,        CUT,          STRENGTH,     CURSE         
	; end

	db BANK(SandshrewPicFront)
	assert BANK(SandshrewPicFront) == BANK(SandshrewPicBack)
