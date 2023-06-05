	db DEX_CROBAT ; pokedex id

	db  85,  90,  80, 130,  80
	;   hp  atk  def  spd  spc

	db POISON, FLYING ; type
	db 47 ; catch rate
	db 204 ; base exp

	INCBIN "gfx/pokemon/front/crobat.pic", 0, 1 ; sprite dimensions
	dw CrobatPicFront, CrobatPicBack

	db LEECH_LIFE, SCREECH, BITE, WING_ATTACK ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   FEINT_ATTACK, GIGA_DRAIN,   \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         BRAVE_BIRD,   REST,         \
	     SHADOW_BALL,  SUBSTITUTE,   FLY,          GUNK_SHOT,    X_SCISSOR     
	; end

	db BANK(CrobatPicFront)
	assert BANK(CrobatPicFront) == BANK(CrobatPicBack)
