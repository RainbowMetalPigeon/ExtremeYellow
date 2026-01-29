	db DEX_THU_FI_ZER ; pokedex id

	db 105, 116, 116, 116, 145
	;   hp  atk  def  spd  spc

	db FLYING, FLYING ; type
	db 3 ; catch rate
	db 254 ; base exp

	INCBIN "gfx/pokemon/front/thufizer.pic", 0, 1 ; sprite dimensions
	dw ThuFiZerPicFront, ThuFiZerPicBack

	db ICE_BEAM, THUNDERSHOCK, FIRE_SPIN, DRILL_PECK ; level 1 learnset
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  BUBBLEBEAM,   ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   MIRROR_COAT,  MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         BRAVE_BIRD,   REST,         SUBSTITUTE,   FREEZE_DRY,   \
	     FLY,          CURSE,        THUNDERBOLT,  THUNDER,      THUNDER_WAVE, \
	     FLASH,        WILL_O_WISP,  FIRE_BLAST,   ROCK_SMASH    
	; end

	db BANK(ThuFiZerPicFront)
	assert BANK(ThuFiZerPicFront) == BANK(ThuFiZerPicBack)
