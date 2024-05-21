	db DEX_VILEPLUME ; pokedex id

	db  75,  80,  85,  50, 110
	;   hp  atk  def  spd  spc

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 184 ; base exp

	INCBIN "gfx/pokemon/front/vileplume.pic", 0, 1 ; sprite dimensions
	dw VileplumePicFront, VileplumePicBack

	db STUN_SPORE, SLEEP_POWDER, ACID, PETAL_DANCE ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  HYPER_BEAM,   \
	     GIGA_DRAIN,   MOONBLAST,    MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         REST,         SUBSTITUTE,   FLAIL,        CUT,          \
	     FLASH,        GUNK_SHOT,    CURSE         
	; end

	db BANK(VileplumePicFront)
	assert BANK(VileplumePicFront) == BANK(VileplumePicBack)
