	db DEX_SYLVEON ; pokedex id

	db  95,  65,  65,  60, 130
	;   hp  atk  def  spd  spc

	db FAIRY, FAIRY ; type
	db 45 ; catch rate
	db 184 ; base exp

	INCBIN "gfx/pokemon/front/sylveon.pic", 0, 1 ; sprite dimensions
	dw SylveonPicFront, SylveonPicBack

	db TACKLE, LEER, QUICK_ATTACK, DRAININGKISS ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   DRAININGKISS, \
	     DIG,          MOONBLAST,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         REST,         SHADOW_BALL,  SUBSTITUTE,   FLAIL,        \
	     CUT,          FLASH,        CURSE         
	; end

	db BANK(SylveonPicFront)
	assert BANK(SylveonPicFront) == BANK(SylveonPicBack)
