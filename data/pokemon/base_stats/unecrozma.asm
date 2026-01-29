	db DEX_UNECROZMA ; pokedex id

	db  97, 167,  97, 129, 167
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, DRAGON ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/unecrozma.pic", 0, 1 ; sprite dimensions
	dw UNecrozmaPicFront, UNecrozmaPicBack

	db METAL_CLAW, CONFUSION, RECOVER, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        DARK_PULSE,   HYPER_BEAM,   FLASH_CANNON, \
	     STONE_EDGE,   EARTHQUAKE,   PSYCHIC_M,    DOUBLE_TEAM,  REFLECT,      \
	     OUTRAGE,      REST,         X_SCISSOR,    THUNDER_WAVE, ROCK_SLIDE,   \
	     SUBSTITUTE,   GYRO_BALL,    FLASH,        FLY,          CURSE,        \
	     ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(UNecrozmaPicFront)
	assert BANK(UNecrozmaPicFront) == BANK(UNecrozmaPicBack)
