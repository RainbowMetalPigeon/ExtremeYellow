	db DEX_MRAICHUY ; pokedex id

	db  60, 100,  55, 130, 160
	;   hp  atk  def  spd  spc

	db ELECTRIC, ELECTRIC ; type
	db 75 ; catch rate
	db 151 ; base exp

	INCBIN "gfx/pokemon/front/mraichuy.pic", 0, 1 ; sprite dimensions
	dw MRaichuYPicFront, MRaichuYPicBack

	db THUNDERSHOCK, GROWL, THUNDER_WAVE, AGILITY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     HYPER_BEAM,   DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      \
	     DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      BIDE,         \
	     FIRE_BLAST,   REST,         THUNDER_WAVE, SUBSTITUTE,   FLAIL,        \
	     SURF,         STRENGTH,     FLASH,        CURSE,        ROCK_SMASH    
	; end

	db BANK(MRaichuYPicFront)
	assert BANK(MRaichuYPicFront) == BANK(MRaichuYPicBack)
