	db DEX_ANNIHILAPE ; pokedex id

	db 110, 115,  80,  90,  70
	;   hp  atk  def  spd  spc

	db FIGHTING, GHOST ; type
	db 42 ; catch rate
	db 210 ; base exp

	INCBIN "gfx/pokemon/front/annihilape.pic", 0, 1 ; sprite dimensions
	dw AnnihilapePicFront, AnnihilapePicBack

	db SCRATCH, LEER, COUNTER, FOCUS_ENERGY ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    HYPER_BEAM,   SEISMIC_TOSS, STONE_EDGE,   THUNDERBOLT,  \
	     THUNDER,      EARTHQUAKE,   DIG,          MIMIC,        DOUBLE_TEAM,  \
	     BIDE,         CLOSE_COMBAT, OUTRAGE,      REST,         ROCK_SLIDE,   \
	     SUBSTITUTE,   STRENGTH,     GUNK_SHOT,    SHADOW_BALL,  CURSE,        \
	     ROCK_SMASH,   ROCK_CLIMB    
	; end

	db BANK(AnnihilapePicFront)
	assert BANK(AnnihilapePicFront) == BANK(AnnihilapePicBack)
