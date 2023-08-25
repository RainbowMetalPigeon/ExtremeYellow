	db DEX_MR_MIME ; pokedex id

	db  40,  45,  65,  90, 100
	;   hp  atk  def  spd  spc

	db PSYCHIC_TYPE, FAIRY ; type
	db 45 ; catch rate
	db 136 ; base exp

	INCBIN "gfx/pokemon/front/mrmime.pic", 0, 1 ; sprite dimensions
	dw MrMimePicFront, MrMimePicBack

	db CONFUSION, BARRIER, NO_MOVE, NO_MOVE ; level 1 learnset
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm MEGA_PUNCH,   COUNTER,      TOXIC,        BODY_SLAM,    DOUBLE_EDGE,  \
	     METRONOME,    ICE_BEAM,     BLIZZARD,     HYPER_BEAM,   MIRROR_COAT,  \
	     SEISMIC_TOSS, THUNDERBOLT,  THUNDER,      PSYCHIC_M,    MIMIC,        \
	     DOUBLE_TEAM,  REFLECT,      BIDE,         REST,         THUNDER_WAVE, \
	     PSYWAVE,      SHADOW_BALL,  SUBSTITUTE,   FLASH         
	; end

	db BANK(MrMimePicFront)
	assert BANK(MrMimePicFront) == BANK(MrMimePicBack)
