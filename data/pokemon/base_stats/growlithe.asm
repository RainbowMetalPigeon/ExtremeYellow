	db DEX_GROWLITHE ; pokedex id

	db  55,  70,  45,  60,  50
	;   hp  atk  def  spd  spc

	db FIRE, FIRE ; type
	db 190 ; catch rate
	db 91 ; base exp

	INCBIN "gfx/pokemon/front/growlithe.pic", 0, 1 ; sprite dimensions
	dw GrowlithePicFront, GrowlithePicBack

	db BITE, TACKLE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  WILL_O_WISP,  DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         CLOSE_COMBAT, \
	     FIRE_BLAST,   OUTRAGE,      REST,         SUBSTITUTE,   STRENGTH,     \
	     CURSE,        ROCK_SMASH    
	; end

	db BANK(GrowlithePicFront)
	assert BANK(GrowlithePicFront) == BANK(GrowlithePicBack)
