	db DEX_BLUESDAD ; pokedex id

	db 255,   1, 150, 255, 150
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 1 ; catch rate
	db 1 ; base exp

	INCBIN "gfx/pokemon/front/bluesdad.pic", 0, 1 ; sprite dimensions
	dw BluesDadPicFront, BluesDadPicBack

	db TACKLE, HEADBUTT, SUBMISSION, LICK ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm
	; end

	db BANK(BluesDadPicFront)
	assert BANK(BluesDadPicFront) == BANK(BluesDadPicBack)
