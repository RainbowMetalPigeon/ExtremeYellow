	db DEX_KINGLER ; pokedex id

	db  55, 130, 115,  75,  50
	;   hp  atk  def  spd  spc

	db WATER, WATER ; type
	db 60 ; catch rate
	db 206 ; base exp

	INCBIN "gfx/pokemon/front/kingler.pic", 0, 1 ; sprite dimensions
	dw KinglerPicFront, KinglerPicBack

	db BUBBLE, LEER, TACKLE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   DIG,          MIMIC,        \
	     DOUBLE_TEAM,  BIDE,         HYDRO_PUMP,   REST,         X_SCISSOR,    \
	     ROCK_SLIDE,   SUBSTITUTE,   FLAIL,        CUT,          SURF,         \
	     STRENGTH,     CURSE         
	; end

	db BANK(KinglerPicFront)
	assert BANK(KinglerPicFront) == BANK(KinglerPicBack)
