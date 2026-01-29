	db DEX_PORYGON2 ; pokedex id

	db  85,  80,  90,  60, 105
	;   hp  atk  def  spd  spc

	db NORMAL, NORMAL ; type
	db 45 ; catch rate
	db 180 ; base exp

	INCBIN "gfx/pokemon/front/porygon2.pic", 0, 1 ; sprite dimensions
	dw Porygon2PicFront, Porygon2PicBack

	db TRI_ATTACK, SWORDS_DANCE, CONVERSION, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   \
	     THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        DOUBLE_TEAM,  \
	     REFLECT,      BIDE,         REST,         THUNDER_WAVE, PSYWAVE,      \
	     SHADOW_BALL,  SUBSTITUTE,   FLASH,        SWORDS_DANCE, CURSE         
	; end

	db BANK(Porygon2PicFront)
	assert BANK(Porygon2PicFront) == BANK(Porygon2PicBack)
