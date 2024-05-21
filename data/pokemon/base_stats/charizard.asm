	db DEX_CHARIZARD ; pokedex id

	db  78,  84,  78, 100,  85
	;   hp  atk  def  spd  spc

	db FIRE, FLYING ; type
	db 45 ; catch rate
	db 209 ; base exp

	INCBIN "gfx/pokemon/front/charizard.pic", 0, 1 ; sprite dimensions
	dw CharizardPicFront, CharizardPicBack

	db SCRATCH, GROWL, EMBER, LEER ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, DRAGON_CLAW,  TOXIC,        BODY_SLAM,    \
	     DOUBLE_EDGE,  HYPER_BEAM,   COUNTER,      SEISMIC_TOSS, EARTHQUAKE,   \
	     FISSURE,      DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         FIRE_BLAST,   REST,         ROCK_SLIDE,   SUBSTITUTE,   \
	     CUT,          FLY,          STRENGTH,     CURSE         
	; end

	db BANK(CharizardPicFront)
	assert BANK(CharizardPicFront) == BANK(CharizardPicBack)
