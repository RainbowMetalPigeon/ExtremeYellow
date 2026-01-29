	db DEX_PIKACHU ; pokedex id

	db  35,  55,  40,  90,  50
	;   hp  atk  def  spd  spc

	db ELECTRIC, ELECTRIC ; type
	db 190 ; catch rate
	db 82 ; base exp

	INCBIN "gfx/pokemon/front/pikachu.pic", 0, 1 ; sprite dimensions
	dw PikachuPicFront, PikachuPicBack

	db THUNDERSHOCK, GROWL, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      DIG,          \
	     MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         \
	     THUNDER_WAVE, SUBSTITUTE,   FLAIL,        FLY,          SURF,         \
	     STRENGTH,     FLASH,        CURSE,        ROCK_SMASH    
	; end

	db BANK(PikachuPicFront)
	assert BANK(PikachuPicFront) == BANK(PikachuPicBack)
