	db DEX_MSCIZOR ; pokedex id

	db  70, 150, 140,  75,  83
	;   hp  atk  def  spd  spc

	db BUG, STEEL ; type
	db 45 ; catch rate
	db 238 ; base exp

	INCBIN "gfx/pokemon/front/mscizor.pic", 0, 1 ; sprite dimensions
	dw MScizorPicFront, MScizorPicBack

	db QUICK_ATTACK, BULLET_PUNCH, AGILITY, AIR_SLASH ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   \
	     FLASH_CANNON, MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, \
	     REST,         X_SCISSOR,    SUBSTITUTE,   CUT,          STRENGTH,     \
	     METEOR_MASH,  CURSE,        ROCK_SMASH    
	; end

	db BANK(MScizorPicFront)
	assert BANK(MScizorPicFront) == BANK(MScizorPicBack)
