	db DEX_MPIDGEOT ; pokedex id

	db  83,  80,  80, 121, 135
	;   hp  atk  def  spd  spc

	db NORMAL, FLYING ; type
	db 45 ; catch rate
	db 211 ; base exp

	INCBIN "gfx/pokemon/front/mpidgeot.pic", 0, 1 ; sprite dimensions
	dw MPidgeotPicFront, MPidgeotPicBack

	db GUST, SAND_ATTACK, QUICK_ATTACK, WING_ATTACK ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         BRAVE_BIRD,   REST,         SUBSTITUTE,   \
	     FLY,          THUNDER,      BLIZZARD      
	; end

	db BANK(MPidgeotPicFront)
	assert BANK(MPidgeotPicFront) == BANK(MPidgeotPicBack)
