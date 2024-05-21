	db DEX_PERSIAN ; pokedex id

	db  65,  70,  60, 115,  65
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 90 ; catch rate
	db 148 ; base exp

	INCBIN "gfx/pokemon/front/persian.pic", 0, 1 ; sprite dimensions
	dw PersianPicFront, PersianPicBack

	db SCRATCH, GROWL, BITE, SCREECH ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  BUBBLEBEAM,   \
	     HYPER_BEAM,   FEINT_ATTACK, THUNDERBOLT,  THUNDER,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         REST,         GUNK_SHOT,    \
	     SHADOW_BALL,  SUBSTITUTE,   FLAIL,        CUT,          FLASH,        \
	     CURSE         
	; end

	db BANK(PersianPicFront)
	assert BANK(PersianPicFront) == BANK(PersianPicBack)
