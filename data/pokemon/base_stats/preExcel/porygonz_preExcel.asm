	db DEX_PORYGONZ ; pokedex id

	db  85,  80,  70,  90, 135
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 241 ; base exp

	INCBIN "gfx/pokemon/front/porygonz.pic", 0, 1 ; sprite dimensions
	dw PorygonZPicFront, PorygonZPicBack

	db TRI_ATTACK, SWORDS_DANCE, CONVERSION, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DARK_PULSE,   DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     \
	     HYPER_BEAM,   THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         THUNDER_WAVE, \
	     PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   FLASH,        SWORDS_DANCE, \
	     CURSE         
	; end

	db BANK(PorygonZPicFront)
	assert BANK(PorygonZPicFront) == BANK(PorygonZPicBack)
