	db DEX_NIDORINA ; pokedex id

	db  70,  62,  67,  56,  55
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 120 ; catch rate
	db 117 ; base exp

	INCBIN "gfx/pokemon/front/nidorina.pic", 0, 1 ; sprite dimensions
	dw NidorinaPicFront, NidorinaPicBack

	db GROWL, TACKLE, SCRATCH, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     STONE_EDGE,   THUNDERBOLT,  THUNDER,      EARTHQUAKE,   \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   \
	     CUT,          GUNK_SHOT,    CURSE         
	; end

	db BANK(NidorinaPicFront)
	assert BANK(NidorinaPicFront) == BANK(NidorinaPicBack)
