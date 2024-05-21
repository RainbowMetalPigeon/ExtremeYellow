	db DEX_GOLDEEN ; pokedex id

	db  45,  67,  60,  63,  50
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 225 ; catch rate
	db 111 ; base exp

	INCBIN "gfx/pokemon/front/goldeen.pic", 0, 1 ; sprite dimensions
	dw GoldeenPicFront, GoldeenPicBack

	db PECK, LEER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGAHORN,     SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         HYDRO_PUMP,   REST,         SUBSTITUTE,   FLAIL,        \
	     SURF,         CURSE         
	; end

	db BANK(GoldeenPicFront)
	assert BANK(GoldeenPicFront) == BANK(GoldeenPicBack)
