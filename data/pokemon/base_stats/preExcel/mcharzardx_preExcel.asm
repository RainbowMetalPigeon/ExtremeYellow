	db DEX_MCHARZARDX ; pokedex id

	db  78, 130, 111, 100,  85
	;   hp  atk  def  spd  spc

	db FIRE, DRAGON ; type
	db 45 ; catch rate
	db 234 ; base exp

	INCBIN "gfx/pokemon/front/mcharzardx.pic", 0, 1 ; sprite dimensions
	dw MCharzardXPicFront, MCharzardXPicBack

	db DRAGON_CLAW, GROWL, EMBER, LEER ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, DRAGON_CLAW,  TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   COUNTER,      SEISMIC_TOSS, EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   OUTRAGE,      REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   CUT,          FLY,          STRENGTH      
	; end

	db BANK(MCharzardXPicFront)
	assert BANK(MCharzardXPicFront) == BANK(MCharzardXPicBack)
