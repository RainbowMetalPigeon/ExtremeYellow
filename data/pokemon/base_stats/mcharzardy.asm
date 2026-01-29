	db DEX_MCHARZARDY ; pokedex id

	db  78, 104,  78, 100, 159
	;   hp  atk  def  spd  spc

	db FIRE, FLYING ; type
	db 45 ; catch rate
	db 234 ; base exp

	INCBIN "gfx/pokemon/front/mcharzardy.pic", 0, 1 ; sprite dimensions
	dw MCharzardYPicFront, MCharzardYPicBack

	db SCRATCH, GROWL, FLAMETHROWER, LEER ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, DRAGON_CLAW,  TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   COUNTER,      SEISMIC_TOSS, EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   BRAVE_BIRD,   REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   CUT,          FLY,          STRENGTH,     CURSE,        \
	     WILL_O_WISP,  OUTRAGE,      ROCK_SMASH    
	; end

	db BANK(MCharzardYPicFront)
	assert BANK(MCharzardYPicFront) == BANK(MCharzardYPicBack)
