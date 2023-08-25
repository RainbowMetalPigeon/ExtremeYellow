	db DEX_ARBOK ; pokedex id

	db  60,  95,  69,  80,  65
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 90 ; catch rate
	db 147 ; base exp

	INCBIN "gfx/pokemon/front/arbok.pic", 0, 1 ; sprite dimensions
	dw ArbokPicFront, ArbokPicBack

	db WRAP, LEER, POISON_STING, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     GIGA_DRAIN,   EARTHQUAKE,   FISSURE,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         REST,         GUNK_SHOT,    ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH      
	; end

	db BANK(ArbokPicFront)
	assert BANK(ArbokPicFront) == BANK(ArbokPicBack)
