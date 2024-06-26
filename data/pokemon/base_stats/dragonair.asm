	db DEX_DRAGONAIR ; pokedex id

	db  61,  84,  65,  70,  70
	;   hp  atk  def  spd  spc

	db DRAGON, DRAGON ; type
	db 27 ; catch rate
	db 144 ; base exp

	INCBIN "gfx/pokemon/front/dragonair.pic", 0, 1 ; sprite dimensions
	dw DragonairPicFront, DragonairPicBack

	db WRAP, LEER, THUNDER_WAVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   THUNDERBOLT,  THUNDER,      MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     OUTRAGE,      REST,         THUNDER_WAVE, SUBSTITUTE,   SURF,         \
	     CURSE         
	; end

	db BANK(DragonairPicFront)
	assert BANK(DragonairPicFront) == BANK(DragonairPicBack)
