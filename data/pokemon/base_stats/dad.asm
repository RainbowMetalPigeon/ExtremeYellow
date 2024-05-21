	db DEX_DAD ; pokedex id

	db 150,   1, 150, 255, 255
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 1 ; catch rate
	db 1 ; base exp

	INCBIN "gfx/pokemon/front/dad.pic", 0, 1 ; sprite dimensions
	dw DadPicFront, DadPicBack

	db LOVELY_KISS, NO_MOVE, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(DadPicFront)
	assert BANK(DadPicFront) == BANK(DadPicBack)
