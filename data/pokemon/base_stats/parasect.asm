	db DEX_PARASECT ; pokedex id

	db  60,  95,  80,  30,  80
	;   hp  atk  def  spd  spc

	db BUG, GRASS ; type
	db 75 ; catch rate
	db 128 ; base exp

	INCBIN "gfx/pokemon/front/parasect.pic", 0, 1 ; sprite dimensions
	dw ParasectPicFront, ParasectPicBack

	db SCRATCH, STUN_SPORE, LEECH_LIFE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   GIGA_DRAIN,   DIG,          MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         X_SCISSOR,    SUBSTITUTE,   \
	     FLAIL,        CUT,          FLASH,        CURSE         
	; end

	db BANK(ParasectPicFront)
	assert BANK(ParasectPicFront) == BANK(ParasectPicBack)
