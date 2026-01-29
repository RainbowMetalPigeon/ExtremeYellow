	db DEX_DODUO ; pokedex id

	db  35,  85,  45,  75,  35
	;   hp  atk  def  spd  spc

	db NORMAL, FLYING ; type
	db 190 ; catch rate
	db 96 ; base exp

	INCBIN "gfx/pokemon/front/doduo.pic", 0, 1 ; sprite dimensions
	dw DoduoPicFront, DoduoPicBack

	db PECK, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         BRAVE_BIRD,   REST,         \
	     SUBSTITUTE,   FLAIL,        FLY,          CURSE         
	; end

	db BANK(DoduoPicFront)
	assert BANK(DoduoPicFront) == BANK(DoduoPicBack)
