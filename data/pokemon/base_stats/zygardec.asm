	db DEX_ZYGARDEC ; pokedex id

	db 216, 100, 121,  85,  95
	;   hp  atk  def  spd  spc

	db DRAGON, GROUND ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/zygardec.pic", 0, 1 ; sprite dimensions
	dw ZygardeCPicFront, ZygardeCPicBack

	db WRAP, DRAGONBREATH, BITE, THOUSANDARROWS ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   STONE_EDGE,   EARTHQUAKE,   \
	     DIG,          DOUBLE_TEAM,  OUTRAGE,      REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     CURSE         
	; end

	db BANK(ZygardeCPicFront)
	assert BANK(ZygardeCPicFront) == BANK(ZygardeCPicBack)
