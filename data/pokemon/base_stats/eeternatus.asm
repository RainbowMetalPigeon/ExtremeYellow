	db DEX_EETERNATUS ; pokedex id

	db 255, 115, 250, 130, 250
	;   hp  atk  def  spd  spc

	db POISON, DRAGON ; type
	db 3 ; catch rate
	db 255 ; base exp

	INCBIN "gfx/pokemon/front/eeternatus.pic", 0, 1 ; sprite dimensions
	dw EEternatusPicFront, EEternatusPicBack

	db CONFUSE_RAY, AGILITY, ACID, DRAGONBREATH ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        HYPER_BEAM,   FLASH_CANNON, REFLECT,      REST,         \
	     SHADOW_BALL,  SUBSTITUTE,   FLY,          GUNK_SHOT,    OUTRAGE,      \
	     DRAGON_CLAW,  CURSE         
	; end

	db BANK(EEternatusPicFront)
	assert BANK(EEternatusPicFront) == BANK(EEternatusPicBack)
