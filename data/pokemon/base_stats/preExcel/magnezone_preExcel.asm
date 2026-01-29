	db DEX_MAGNEZONE ; pokedex id

	db  70,  70, 115,  60, 130
	;   hp  atk  def  spd  spc

	db ELECTRIC, STEEL ; type
	db 65 ; catch rate
	db 211 ; base exp

	INCBIN "gfx/pokemon/front/magnezone.pic", 0, 1 ; sprite dimensions
	dw MagnezonePicFront, MagnezonePicBack

	db TACKLE, SONICBOOM, ZAP_CANNON, FLASH_CANNON ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm TOXIC,        DOUBLE_EDGE,  HYPER_BEAM,   FLASH_CANNON, THUNDERBOLT,  \
	     THUNDER,      MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     REST,         THUNDER_WAVE, EXPLOSION,    SUBSTITUTE,   GYRO_BALL,    \
	     BODY_PRESS,   FLASH,        CURSE         
	; end

	db BANK(MagnezonePicFront)
	assert BANK(MagnezonePicFront) == BANK(MagnezonePicBack)
