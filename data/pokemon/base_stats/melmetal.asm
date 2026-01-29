	db DEX_MELMETAL ; pokedex id

	db 135, 143, 143,  34,  80
	;   hp  atk  def  spd  spc

	db STEEL, STEEL ; type
	db 3 ; catch rate
	db 254 ; base exp

	INCBIN "gfx/pokemon/front/melmetal.pic", 0, 1 ; sprite dimensions
	dw MelmetalPicFront, MelmetalPicBack

	db THUNDERPUNCH, HEADBUTT, HARDEN, THUNDER_WAVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   TOXIC,        BODY_SLAM,    METEOR_MASH,  DOUBLE_EDGE,  \
	     ICE_BEAM,     HYPER_BEAM,   FLASH_CANNON, THUNDERBOLT,  THUNDER,      \
	     EARTHQUAKE,   MIMIC,        SELFDESTRUCT, CLOSE_COMBAT, REST,         \
	     THUNDER_WAVE, ROCK_SLIDE,   SUBSTITUTE,   CURSE,        ROCK_SMASH,   \
	     ROCK_CLIMB
	; end

	db BANK(MelmetalPicFront)
	assert BANK(MelmetalPicFront) == BANK(MelmetalPicBack)
