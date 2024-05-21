	db DEX_CHARMELEON ; pokedex id

	db  58,  64,  58,  80,  65
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 45 ; catch rate
	db 142 ; base exp

	INCBIN "gfx/pokemon/front/charmeleon.pic", 0, 1 ; sprite dimensions
	dw CharmeleonPicFront, CharmeleonPicBack

	db SCRATCH, GROWL, EMBER, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, DRAGON_CLAW,  TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  COUNTER,      SEISMIC_TOSS, DIG,          MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   REST,         \
	     ROCK_SLIDE,   SUBSTITUTE,   CUT,          STRENGTH,     CURSE         
	; end

	db BANK(CharmeleonPicFront)
	assert BANK(CharmeleonPicFront) == BANK(CharmeleonPicBack)
