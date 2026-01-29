	db DEX_MZYGARDE ; pokedex id

	db 216,  70,  91, 100, 216
	;   hp  atk  def  spd  spc

	db DRAGON, GROUND ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/mzygarde.pic", 0, 1 ; sprite dimensions
	dw MZygardePicFront, MZygardePicBack

	db WRAP, DRAGONBREATH, BITE, THOUSANDARROWS ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        BODY_SLAM,    HYPER_BEAM,   STONE_EDGE,   EARTHQUAKE,   \
	     DIG,          DOUBLE_TEAM,  OUTRAGE,      REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     CURSE,        ROCK_SMASH,   ROCK_CLIMB
	; end

	db BANK(MZygardePicFront)
	assert BANK(MZygardePicFront) == BANK(MZygardePicBack)
