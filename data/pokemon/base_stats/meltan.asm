	db DEX_MELTAN ; pokedex id

	db  46,  65,  65,  34,  55
	;   hp  atk  def  spd  spc

	db STEEL, STEEL ; type
	db 3 ; catch rate
	db 135 ; base exp

	INCBIN "gfx/pokemon/front/meltan.pic", 0, 1 ; sprite dimensions
	dw MeltanPicFront, MeltanPicBack

	db HARDEN, HEADBUTT, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        FLASH_CANNON, THUNDERBOLT,  REST,         THUNDER_WAVE, \
	     SUBSTITUTE    
	; end

	db BANK(MeltanPicFront)
	assert BANK(MeltanPicFront) == BANK(MeltanPicBack)
