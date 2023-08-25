	db DEX_PICHU ; pokedex id

	db  20,  40,  15,  60,  35
	;   hp  atk  def  spd  spc

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 10 ; base exp

	INCBIN "gfx/pokemon/front/pichu.pic", 0, 1 ; sprite dimensions
	dw PichuPicFront, PichuPicBack

	db CHARM, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(PichuPicFront)
	assert BANK(PichuPicFront) == BANK(PichuPicBack)
