	db DEX_ARTICUNO ; pokedex id

	db  90,  85, 100,  85, 125
	;   hp  atk  def  spd  spc

	db ICE, FLYING ; type
	db 3 ; catch rate
	db 215 ; base exp

	INCBIN "gfx/pokemon/front/articuno.pic", 0, 1 ; sprite dimensions
	dw ArticunoPicFront, ArticunoPicBack

	db PECK, ICE_BEAM, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   MIRROR_COAT,  MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         BRAVE_BIRD,   REST,         SUBSTITUTE,   FREEZE_DRY,   \
	     FLY,          CURSE,        ROCK_SMASH    
	; end

	db BANK(ArticunoPicFront)
	assert BANK(ArticunoPicFront) == BANK(ArticunoPicBack)
