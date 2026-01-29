	db DEX_MVICTREBEL ; pokedex id

	db  80, 125,  85,  70, 135
	;   hp  atk  def  spd  spc

	db GRASS, POISON ; type
	db 45 ; catch rate
	db 220 ; base exp

	INCBIN "gfx/pokemon/front/mvictrebel.pic", 0, 1 ; sprite dimensions
	dw MVictrebelPicFront, MVictrebelPicBack

	db SLEEP_POWDER, STUN_SPORE, GUNK_SHOT, RAZOR_LEAF ; level 1 learnset
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm SWORDS_DANCE, TOXIC,        DARK_PULSE,   BODY_SLAM,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   GIGA_DRAIN,   EARTHQUAKE,   MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         GUNK_SHOT,    SHADOW_BALL,  \
	     SUBSTITUTE,   CUT,          FLASH,        CURSE         
	; end

	db BANK(MVictrebelPicFront)
	assert BANK(MVictrebelPicFront) == BANK(MVictrebelPicBack)
