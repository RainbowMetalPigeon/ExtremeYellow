	db DEX_MPINSIR ; pokedex id

	db  65, 155, 120, 105,  78
	;   hp  atk  def  spd  spc

	db BUG, FLYING ; type
	db 45 ; catch rate
	db 233 ; base exp

	INCBIN "gfx/pokemon/front/mpinsir.pic", 0, 1 ; sprite dimensions
	dw MPinsirPicFront, MPinsirPicBack

	db TACKLE, X_SCISSOR, AIR_CUTTER, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     SEISMIC_TOSS, FEINT_ATTACK, STONE_EDGE,   EARTHQUAKE,   DIG,          \
	     MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, OUTRAGE,      \
	     REST,         X_SCISSOR,    ROCK_SLIDE,   SUBSTITUTE,   FLAIL,        \
	     CUT,          STRENGTH,     MEGAHORN,     EXPLOSION,    CURSE
	; end

	db BANK(MPinsirPicFront)
	assert BANK(MPinsirPicFront) == BANK(MPinsirPicBack)
