	db DEX_POLIWAG ; pokedex id

	db  40,  50,  40,  90,  40
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 255 ; catch rate
	db 77 ; base exp

	INCBIN "gfx/pokemon/front/poliwag.pic", 0, 1 ; sprite dimensions
	dw PoliwagPicFront, PoliwagPicBack

	db BUBBLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     DIG,          PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         HYDRO_PUMP,   REST,         PSYWAVE,      SUBSTITUTE,   \
	     SURF,         CURSE         
	; end

	db BANK(PoliwagPicFront)
	assert BANK(PoliwagPicFront) == BANK(PoliwagPicBack)
