	db DEX_MANKEY ; pokedex id

	db  40,  80,  35,  70,  35
	;   hp  atk  def  spd  spc

	db FIGHTING, FIGHTING ; type
	db 190 ; catch rate
	db 74 ; base exp

	INCBIN "gfx/pokemon/front/mankey.pic", 0, 1 ; sprite dimensions
	dw MankeyPicFront, MankeyPicBack

	db SCRATCH, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  COUNTER,      \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         METRONOME,    REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH      
	; end

	db BANK(MankeyPicFront)
	assert BANK(MankeyPicFront) == BANK(MankeyPicBack)