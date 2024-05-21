	db DEX_FARFETCHD ; pokedex id

	db  52,  95,  55,  60,  58
	;   hp  atk  def  spd  spc

	db NORMAL, FLYING ; type
	db 45 ; catch rate
	db 94 ; base exp

	INCBIN "gfx/pokemon/front/farfetchd.pic", 0, 1 ; sprite dimensions
	dw FarfetchdPicFront, FarfetchdPicBack

	db PECK, SAND_ATTACK, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         CLOSE_COMBAT, BRAVE_BIRD,   \
	     REST,         SUBSTITUTE,   FLAIL,        CUT,          FLY,          \
	     CURSE         
	; end

	db BANK(FarfetchdPicFront)
	assert BANK(FarfetchdPicFront) == BANK(FarfetchdPicBack)
