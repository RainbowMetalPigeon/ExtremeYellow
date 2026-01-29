	db DEX_KABUTO ; pokedex id

	db  30,  80,  90,  55,  45
	;   hp  atk  def  spd  spc

	db ROCK, WATER ; type
	db 45 ; catch rate
	db 119 ; base exp

	INCBIN "gfx/pokemon/front/kabuto.pic", 0, 1 ; sprite dimensions
	dw KabutoPicFront, KabutoPicBack

	db SCRATCH, HARDEN, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     \
	     BLIZZARD,     GIGA_DRAIN,   STONE_EDGE,   DIG,          MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         HYDRO_PUMP,   REST,         \
	     ROCK_SLIDE,   SUBSTITUTE,   FLAIL,        SURF,         CURSE         
	; end

	db BANK(KabutoPicFront)
	assert BANK(KabutoPicFront) == BANK(KabutoPicBack)
