	db DEX_MRAICHUX ; pokedex id

	db  60, 135,  95, 110,  95
	;   hp  atk  def  spd  spc

	db ELECTRIC, ELECTRIC ; type
	db 75 ; catch rate
	db 151 ; base exp

	INCBIN "gfx/pokemon/front/mraichux.pic", 0, 1 ; sprite dimensions
	dw MRaichuXPicFront, MRaichuXPicBack

	db THUNDERSHOCK, GROWL, THUNDER_WAVE, BODY_SLAM ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    METEOR_MASH,  \
	     DOUBLE_EDGE,  HYPER_BEAM,   DRAININGKISS, SEISMIC_TOSS, THUNDERBOLT,  \
	     THUNDER,      DIG,          MIMIC,        DOUBLE_TEAM,  REFLECT,      \
	     BIDE,         REST,         THUNDER_WAVE, SUBSTITUTE,   FLAIL,        \
	     SURF,         STRENGTH,     FLASH,        CURSE,        ROCK_SMASH    
	; end

	db BANK(MRaichuXPicFront)
	assert BANK(MRaichuXPicFront) == BANK(MRaichuXPicBack)
