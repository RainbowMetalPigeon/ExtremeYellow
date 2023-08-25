	db DEX_PIDGEY ; pokedex id

	db  40,  45,  40,  56,  35
	;   hp  atk  def  spd  spc

	db NORMAL, FLYING ; type
	db 255 ; catch rate
	db 55 ; base exp

	INCBIN "gfx/pokemon/front/pidgey.pic", 0, 1 ; sprite dimensions
	dw PidgeyPicFront, PidgeyPicBack

	db GUST, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         BRAVE_BIRD,   REST,         SUBSTITUTE,   FLY           
	; end

	db BANK(PidgeyPicFront)
	assert BANK(PidgeyPicFront) == BANK(PidgeyPicBack)
