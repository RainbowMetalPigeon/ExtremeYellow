	db DEX_MAGNEMITE ; pokedex id

	db  25,  35,  70,  45,  95
	;   hp  atk  def  spd  spc

	db ELECTRIC, STEEL ; type
	db 190 ; catch rate
	db 89 ; base exp

	INCBIN "gfx/pokemon/front/magnemite.pic", 0, 1 ; sprite dimensions
	dw MagnemitePicFront, MagnemitePicBack

	db TACKLE, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  FLASH_CANNON, THUNDERBOLT,  THUNDER,      \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     THUNDER_WAVE, EXPLOSION,    SUBSTITUTE,   FLASH         
	; end

	db BANK(MagnemitePicFront)
	assert BANK(MagnemitePicFront) == BANK(MagnemitePicBack)
