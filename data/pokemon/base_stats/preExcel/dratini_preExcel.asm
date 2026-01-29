	db DEX_DRATINI ; pokedex id

	db  41,  64,  45,  50,  50
	;   hp  atk  def  spd  spc

	db DRAGON, DRAGON ; type
	db 45 ; catch rate
	db 67 ; base exp

	INCBIN "gfx/pokemon/front/dratini.pic", 0, 1 ; sprite dimensions
	dw DratiniPicFront, DratiniPicBack

	db WRAP, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     HYPER_BEAM,   THUNDERBOLT,  THUNDER,      MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   FIRE_BLAST,   \
	     OUTRAGE,      REST,         THUNDER_WAVE, SUBSTITUTE,   SURF,         \
	     CURSE         
	; end

	db BANK(DratiniPicFront)
	assert BANK(DratiniPicFront) == BANK(DratiniPicBack)
