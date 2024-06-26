	db DEX_ODDISH ; pokedex id

	db  45,  50,  55,  30,  75
	;   hp  atk  def  spd  spc

	db GRASS, POISON ; type
	db 255 ; catch rate
	db 78 ; base exp

	INCBIN "gfx/pokemon/front/oddish.pic", 0, 1 ; sprite dimensions
	dw OddishPicFront, OddishPicBack

	db ABSORB, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        DOUBLE_EDGE,  GIGA_DRAIN,   MOONBLAST,    \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     SUBSTITUTE,   FLAIL,        CUT,          FLASH,        GUNK_SHOT,    \
	     CURSE         
	; end

	db BANK(OddishPicFront)
	assert BANK(OddishPicFront) == BANK(OddishPicBack)
