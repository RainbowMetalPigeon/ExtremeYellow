	db DEX_MISSINGNO. ; pokedex id

	db  33, 136,   0,  29,   6
	;   hp  atk  def  spd  spc

	db BIRD, NORMAL ; type
	db 29 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/missingno.pic", 0, 1 ; sprite dimensions
	dw MissingNoPicFront, MissingNoPicBack

	db WATER_GUN, WATER_GUN, FLY, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   SWORDS_DANCE, TOXIC,        DOUBLE_EDGE,  BUBBLEBEAM,   \
	     METRONOME,    ICE_BEAM,     BLIZZARD,     SEISMIC_TOSS, THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   FISSURE,      PSYCHIC_M,    BIDE,         \
	     REST,         THUNDER_WAVE, SUBSTITUTE,   CUT,          FLY           
	; end

	db BANK(MissingNoPicFront)
	assert BANK(MissingNoPicFront) == BANK(MissingNoPicBack)
