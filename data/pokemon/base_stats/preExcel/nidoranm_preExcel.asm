	db DEX_NIDORAN_M ; pokedex id

	db  46,  57,  40,  50,  40
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 235 ; catch rate
	db 60 ; base exp

	INCBIN "gfx/pokemon/front/nidoranm.pic", 0, 1 ; sprite dimensions
	dw NidoranMPicFront, NidoranMPicBack

	db LEER, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     \
	     STONE_EDGE,   THUNDERBOLT,  THUNDER,      EARTHQUAKE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
	     REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   CUT,          \
	     GUNK_SHOT     
	; end

	db BANK(NidoranMPicFront)
	assert BANK(NidoranMPicFront) == BANK(NidoranMPicBack)
