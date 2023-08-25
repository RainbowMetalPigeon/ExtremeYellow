	db DEX_GLACEON ; pokedex id

	db  65,  60, 110,  65, 130
	;   hp  atk  def  spd  spc

	db ICE, ICE ; type
	db 45 ; catch rate
	db 196 ; base exp

	INCBIN "gfx/pokemon/front/glaceon.pic", 0, 1 ; sprite dimensions
	dw GlaceonPicFront, GlaceonPicBack

	db TACKLE, LEER, QUICK_ATTACK, AURORA_BEAM ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   MIRROR_COAT,  DIG,          MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         SHADOW_BALL,  SUBSTITUTE,   \
	     STRENGTH      
	; end

	db BANK(GlaceonPicFront)
	assert BANK(GlaceonPicFront) == BANK(GlaceonPicBack)
