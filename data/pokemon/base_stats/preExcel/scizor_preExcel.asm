	db DEX_SCIZOR ; pokedex id

	db  70, 130, 100,  65,  68
	;   hp  atk  def  spd  spc

	db BUG, STEEL ; type
	db 45 ; catch rate
	db 200 ; base exp

	INCBIN "gfx/pokemon/front/scizor.pic", 0, 1 ; sprite dimensions
	dw ScizorPicFront, ScizorPicBack

	db QUICK_ATTACK, BULLET_PUNCH, AGILITY, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, COUNTER,      TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   \
	     FLASH_CANNON, MIMIC,        DOUBLE_TEAM,  BIDE,         CLOSE_COMBAT, \
	     REST,         X_SCISSOR,    SUBSTITUTE,   CUT,          STRENGTH      
	; end

	db BANK(ScizorPicFront)
	assert BANK(ScizorPicFront) == BANK(ScizorPicBack)
