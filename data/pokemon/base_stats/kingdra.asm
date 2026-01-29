	db DEX_KINGDRA ; pokedex id

	db  75,  95,  95,  85,  95
	;   hp  atk  def  spd  spc

	db WATER, DRAGON ; type
	db 45 ; catch rate
	db 207 ; base exp

	INCBIN "gfx/pokemon/front/kingdra.pic", 0, 1 ; sprite dimensions
	dw KingdraPicFront, KingdraPicBack

	db BUBBLE, SMOKESCREEN, DRAGONBREATH, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   FLASH_CANNON, MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         HYDRO_PUMP,   OUTRAGE,      REST,         SUBSTITUTE,   \
	     FLAIL,        SURF,         CURSE,        WATERFALL,    DIVE,         \
	     WHIRLPOOL     
	; end

	db BANK(KingdraPicFront)
	assert BANK(KingdraPicFront) == BANK(KingdraPicBack)
