	db DEX_MBEEDRILL ; pokedex id

	db  65, 150,  40, 145,  48
	;   hp  atk  def  spd  spc

	db BUG, POISON ; type
	db 45 ; catch rate
	db 203 ; base exp

	INCBIN "gfx/pokemon/front/mbeedrill.pic", 0, 1 ; sprite dimensions
	dw MBeedrillPicFront, MBeedrillPicBack

	db FURY_ATTACK, SWORDS_DANCE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   GIGA_DRAIN,   \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     X_SCISSOR,    SUBSTITUTE,   CUT,          FLASH,        MEGAHORN,     \
	     GUNK_SHOT,    CURSE,        ROCK_SMASH    
	; end

	db BANK(MBeedrillPicFront)
	assert BANK(MBeedrillPicFront) == BANK(MBeedrillPicBack)
