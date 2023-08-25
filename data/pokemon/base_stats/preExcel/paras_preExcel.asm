	db DEX_PARAS ; pokedex id

	db  35,  70,  55,  25,  55
	;   hp  atk  def  spd  spc

	db BUG, GRASS ; type
	db 190 ; catch rate
	db 70 ; base exp

	INCBIN "gfx/pokemon/front/paras.pic", 0, 1 ; sprite dimensions
	dw ParasPicFront, ParasPicBack

	db SCRATCH, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     GIGA_DRAIN,   DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         REST,         X_SCISSOR,    SUBSTITUTE,   CUT,          \
	     FLASH         
	; end

	db BANK(ParasPicFront)
	assert BANK(ParasPicFront) == BANK(ParasPicBack)
