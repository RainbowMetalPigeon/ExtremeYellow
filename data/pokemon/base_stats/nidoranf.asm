	db DEX_NIDORAN_F ; pokedex id

	db  55,  47,  52,  41,  40
	;   hp  atk  def  spd  spc

	db POISON, POISON ; type
	db 235 ; catch rate
	db 59 ; base exp

	INCBIN "gfx/pokemon/front/nidoranf.pic", 0, 1 ; sprite dimensions
	dw NidoranFPicFront, NidoranFPicBack

	db GROWL, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     \
	     STONE_EDGE,   THUNDERBOLT,  THUNDER,      EARTHQUAKE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         FIRE_BLAST,   \
	     REST,         ROCK_SLIDE,   SHADOW_BALL,  SUBSTITUTE,   CUT,          \
	     GUNK_SHOT,    CURSE         
	; end

	db BANK(NidoranFPicFront)
	assert BANK(NidoranFPicFront) == BANK(NidoranFPicBack)
