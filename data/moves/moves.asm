MACRO move
	db \1 ; animation (interchangeable with move id)
	db \2 ; effect
	db \3 ; power
	db \4 ; type
	db \5 percent ; accuracy
	db \6 ; pp
	assert \6 <= 40, "PP must be 40 or less"
ENDM

Moves:
; Characteristics of each move.
; FLINCH_SIDE_EFFECT1 = 10%, FLINCH_SIDE_EFFECT2 = 20%, FLINCH_SIDE_EFFECT3 = 30% - added a level and made number correspond more to %
; similar for confusion: CONFUSION_SIDE_EFFECT-1/2/3
; and for poison (1/2/3/4)
	table_width MOVE_LENGTH, Moves
	move POUND,        NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
	move KARATE_CHOP,  NO_ADDITIONAL_EFFECT,        50, FIGHTING,     100, 25 ; high crit rate - TYPE CHANGED
;	move DOUBLESLAP,   TWO_TO_FIVE_ATTACKS_EFFECT,  15, NORMAL,        85, 10
	move COMET_PUNCH,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, NORMAL,        85, 15
	move MEGA_PUNCH,   NO_ADDITIONAL_EFFECT,        80, NORMAL,        85, 20 ; [TM01]
	move PAY_DAY,      PAY_DAY_EFFECT,              40, NORMAL,       100, 20 ; can't give coins=LVLx5 because uses 1 byte, max=255
	move FIRE_PUNCH,   BURN_SIDE_EFFECT1,           75, FIRE,         100, 15
	move ICE_PUNCH,    FREEZE_SIDE_EFFECT,          75, ICE,          100, 15
	move THUNDERPUNCH, PARALYZE_SIDE_EFFECT1,       75, ELECTRIC,     100, 15
	move SCRATCH,      NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 35
;	move VICEGRIP,     NO_ADDITIONAL_EFFECT,        55, NORMAL,       100, 30 ; - REMOVED
	move GUILLOTINE,   OHKO_EFFECT,                  1, NORMAL,        30,  5
;	move RAZOR_WIND,   CHARGE_EFFECT,               80, NORMAL,        75, 10 ; - REMOVED
	move SWORDS_DANCE, ATTACK_UP2_EFFECT,            0, NORMAL,       100, 30 ; [TM03]
	move CUT,          NO_ADDITIONAL_EFFECT,        50, NORMAL,        95, 30
	move GUST,         NO_ADDITIONAL_EFFECT,        40, FLYING,       100, 35 ; TYPE CHANGED
	move WING_ATTACK,  NO_ADDITIONAL_EFFECT,        60, FLYING,       100, 35 ; power 35->60
;	move WHIRLWIND,    SWITCH_AND_TELEPORT_EFFECT,   0, NORMAL,        85, 20 ; - REMOVED
	move FLY,          FLY_EFFECT,                  90, FLYING,        95, 15 ; power 70->90
;	move BIND,         TRAPPING_EFFECT,             15, NORMAL,        85, 20 ; accuracy 75->85 - REMOVED
	move SLAM,         NO_ADDITIONAL_EFFECT,        80, NORMAL,        75, 20
	move VINE_WHIP,    NO_ADDITIONAL_EFFECT,        45, GRASS,        100, 25 ; power 35->45, PP 10->25
	move STOMP,        FLINCH_SIDE_EFFECT3,         65, NORMAL,       100, 20
	move DOUBLE_KICK,  ATTACK_TWICE_EFFECT,         30, FIGHTING,     100, 30
;	move MEGA_KICK,    NO_ADDITIONAL_EFFECT,       120, NORMAL,        75,  5 - REMOVED
;	move JUMP_KICK,    JUMP_KICK_EFFECT,           100, FIGHTING,      95, 25 ; power 70->100 - REMOVED
	move ROLLING_KICK, FLINCH_SIDE_EFFECT3,         60, FIGHTING,      85, 15
	move SAND_ATTACK,  ACCURACY_DOWN1_EFFECT,        0, NORMAL,       100, 15
	move HEADBUTT,     FLINCH_SIDE_EFFECT3,         70, NORMAL,       100, 15
	move HORN_ATTACK,  NO_ADDITIONAL_EFFECT,        65, NORMAL,       100, 25
	move FURY_ATTACK,  TWO_TO_FIVE_ATTACKS_EFFECT,  15, NORMAL,        85, 20
	move HORN_DRILL,   OHKO_EFFECT,                  1, NORMAL,        30,  5
	move TACKLE,       NO_ADDITIONAL_EFFECT,        50, NORMAL,       100, 35 ; power 35->50, accuracy 95->100
	move BODY_SLAM,    PARALYZE_SIDE_EFFECT2,       85, NORMAL,       100, 15 ; [TM08]
	move WRAP,         TRAPPING_EFFECT,             15, NORMAL,        90, 20 ; accuracy 85->90
	move TAKE_DOWN,    RECOIL_EFFECT,               90, NORMAL,        85, 20
	move THRASH,       THRASH_PETAL_DANCE_EFFECT,  120, NORMAL,       100, 20 ; power 90->120
	move DOUBLE_EDGE,  RECOIL_EFFECT,              120, NORMAL,       100, 15 ; [TM10] power 100->120
;	move TAIL_WHIP,    DEFENSE_DOWN1_EFFECT,         0, NORMAL,       100, 30 ; - REMOVED
	move POISON_STING, POISON_SIDE_EFFECT3,         15, POISON,       100, 35 ; 20->30% chance of poison
	move TWINEEDLE,    TWINEEDLE_EFFECT,            25, BUG,          100, 20
	move PIN_MISSILE,  TWO_TO_FIVE_ATTACKS_EFFECT,  25, BUG,           95, 20 ; power 14->25, accuracy 85->95
	move LEER,         DEFENSE_DOWN1_EFFECT,         0, NORMAL,       100, 30
	move BITE,         FLINCH_SIDE_EFFECT3,         60, DARK,         100, 25 ; TYPE CHANGED, 10%->30% flinch chance
	move GROWL,        ATTACK_DOWN1_EFFECT,          0, NORMAL,       100, 40
;	move ROAR,         SWITCH_AND_TELEPORT_EFFECT,   0, NORMAL,       100, 20 ; - REMOVED
	move SING,         SLEEP_EFFECT,                 0, NORMAL,        55, 15
	move SUPERSONIC,   CONFUSION_EFFECT,             0, NORMAL,        55, 20
	move SONICBOOM,    SPECIAL_DAMAGE_EFFECT,        1, NORMAL,        90, 20
	move DISABLE,      DISABLE_EFFECT,               0, NORMAL,        55, 20
	move ACID,         DEFENSE_DOWN_SIDE_EFFECT3,   40, POISON,       100, 30
	move EMBER,        BURN_SIDE_EFFECT1,           40, FIRE,         100, 25
	move FLAMETHROWER, BURN_SIDE_EFFECT1,           95, FIRE,         100, 15
;	move MIST,         MIST_EFFECT,                  0, ICE,          100, 30 ; - REMOVED
	move WATER_GUN,    NO_ADDITIONAL_EFFECT,        40, WATER,        100, 25
	move HYDRO_PUMP,   NO_ADDITIONAL_EFFECT,       120, WATER,         80,  5 ; [TM35]
	move SURF,         NO_ADDITIONAL_EFFECT,        95, WATER,        100, 15
	move ICE_BEAM,     FREEZE_SIDE_EFFECT,          95, ICE,          100, 10 ; [TM13]
	move BLIZZARD,     FREEZE_SIDE_EFFECT,         120, ICE,           90,  5 ; [TM14]
	move PSYBEAM,      CONFUSION_SIDE_EFFECT1,      65, PSYCHIC_TYPE, 100, 20
	move BUBBLEBEAM,   SPEED_DOWN_SIDE_EFFECT3,     65, WATER,        100, 20 ; [TM11]
	move AURORA_BEAM,  ATTACK_DOWN_SIDE_EFFECT3,    65, ICE,          100, 20
	move HYPER_BEAM,   HYPER_BEAM_EFFECT,          150, NORMAL,        90,  5 ; [TM15]
	move PECK,         NO_ADDITIONAL_EFFECT,        35, FLYING,       100, 35
	move DRILL_PECK,   NO_ADDITIONAL_EFFECT,        80, FLYING,       100, 20
	move SUBMISSION,   RECOIL_EFFECT,               80, FIGHTING,      80, 25
	move LOW_KICK,     FLINCH_SIDE_EFFECT3,         50, FIGHTING,      90, 20
	move COUNTER,      NO_ADDITIONAL_EFFECT,         1, FIGHTING,     100, 20 ; [TM04] prio -6 ; now it should(?) counter all physical moves (except STRUGGLE)
	move SEISMIC_TOSS, SPECIAL_DAMAGE_EFFECT,        1, FIGHTING,     100, 20 ; [TM19]
	move STRENGTH,     NO_ADDITIONAL_EFFECT,        80, NORMAL,       100, 15
	move ABSORB,       DRAIN_HP_EFFECT,             20, GRASS,        100, 20
	move MEGA_DRAIN,   DRAIN_HP_EFFECT,             40, GRASS,        100, 10
	move LEECH_SEED,   LEECH_SEED_EFFECT,            0, GRASS,         90, 10
	move GROWTH,       SPECIAL_UP1_EFFECT,           0, NORMAL,       100, 40
	move RAZOR_LEAF,   NO_ADDITIONAL_EFFECT,        55, GRASS,         95, 25 ; high crit rate
	move SOLARBEAM,    CHARGE_EFFECT,              120, GRASS,        100, 10
	move POISONPOWDER, POISON_EFFECT,                0, POISON,        75, 35
	move STUN_SPORE,   PARALYZE_EFFECT,              0, GRASS,         75, 30
	move SLEEP_POWDER, SLEEP_EFFECT,                 0, GRASS,         75, 15
	move PETAL_DANCE,  THRASH_PETAL_DANCE_EFFECT,  120, GRASS,        100, 10 ; power 90->120, PP 20->10
	move STRING_SHOT,  SPEED_DOWN1_EFFECT,           0, BUG,           95, 40
	move DRAGON_RAGE,  SPECIAL_DAMAGE_EFFECT,        1, DRAGON,       100, 10
	move FIRE_SPIN,    TRAPPING_EFFECT,             15, FIRE,          70, 15
	move THUNDERSHOCK, PARALYZE_SIDE_EFFECT1,       40, ELECTRIC,     100, 30
	move THUNDERBOLT,  PARALYZE_SIDE_EFFECT1,       95, ELECTRIC,     100, 15 ; [TM24]
	move THUNDER_WAVE, PARALYZE_EFFECT,              0, ELECTRIC,     100, 20 ; [TM45]
	move THUNDER,      PARALYZE_SIDE_EFFECT1,      120, ELECTRIC,      70, 10 ; [TM25]
	move ROCK_THROW,   NO_ADDITIONAL_EFFECT,        50, ROCK,          90, 15 ; accuracy increased
	move EARTHQUAKE,   NO_ADDITIONAL_EFFECT,       100, GROUND,       100, 10 ; [TM26]
	move FISSURE,      OHKO_EFFECT,                  1, GROUND,        30,  5 ; [TM27]
	move DIG,          CHARGE_EFFECT,              100, GROUND,       100, 10 ; [TM28]
	move TOXIC,        POISON_EFFECT,                0, POISON,        90, 10 ; [TM06] ; accuracy increased 85->90
	move CONFUSION,    CONFUSION_SIDE_EFFECT1,      50, PSYCHIC_TYPE, 100, 25
	move PSYCHIC_M,    SPECIAL_DOWN_SIDE_EFFECT3,   90, PSYCHIC_TYPE, 100, 10 ; [TM29]
	move HYPNOSIS,     SLEEP_EFFECT,                 0, PSYCHIC_TYPE,  70, 20
;	move MEDITATE,     ATTACK_UP1_EFFECT,            0, PSYCHIC_TYPE, 100, 40 ; - REMOVED
	move AGILITY,      SPEED_UP2_EFFECT,             0, PSYCHIC_TYPE, 100, 30
	move QUICK_ATTACK, NO_ADDITIONAL_EFFECT,        40, NORMAL,       100, 30 ; prio +1
;	move RAGE,         RAGE_EFFECT,                 20, NORMAL,       100, 20 ; - REMOVED
	move TELEPORT,     SWITCH_AND_TELEPORT_EFFECT,   0, PSYCHIC_TYPE, 100, 20
	move NIGHT_SHADE,  SPECIAL_DAMAGE_EFFECT,        0, GHOST,        100, 15
	move MIMIC,        MIMIC_EFFECT,                 0, NORMAL,       100, 10 ; [TM31]
	move SCREECH,      DEFENSE_DOWN2_EFFECT,         0, NORMAL,        85, 40
	move DOUBLE_TEAM,  EVASION_UP1_EFFECT,           0, NORMAL,       100, 15 ; [TM32]
	move RECOVER,      HEAL_EFFECT,                  0, NORMAL,       100, 20
	move HARDEN,       DEFENSE_UP1_EFFECT,           0, NORMAL,       100, 30
	move MINIMIZE,     EVASION_UP2_EFFECT,           0, NORMAL,       100, 20 ; now increases evasion by 2 instead of 1
	move SMOKESCREEN,  ACCURACY_DOWN1_EFFECT,        0, NORMAL,       100, 20
	move CONFUSE_RAY,  CONFUSION_EFFECT,             0, GHOST,        100, 10
;	move WITHDRAW,     DEFENSE_UP1_EFFECT,           0, WATER,        100, 40 ; - REMOVED
	move DEFENSE_CURL, DEFENSE_UP1_EFFECT,           0, NORMAL,       100, 40
	move BARRIER,      DEFENSE_UP2_EFFECT,           0, PSYCHIC_TYPE, 100, 30
	move LIGHT_SCREEN, LIGHT_SCREEN_EFFECT,          0, PSYCHIC_TYPE, 100, 30
	move HAZE,         HAZE_EFFECT,                  0, ICE,          100, 30
	move REFLECT,      REFLECT_EFFECT,               0, PSYCHIC_TYPE, 100, 20 ; [TM33]
	move FOCUS_ENERGY, FOCUS_ENERGY_EFFECT,          0, NORMAL,       100, 30
	move BIDE,         BIDE_EFFECT,                  0, NORMAL,       100, 10 ; now has prio +1 [TM34]
	move METRONOME,    METRONOME_EFFECT,             0, NORMAL,       100, 10 ; [TM12]
	move MIRROR_MOVE,  MIRROR_MOVE_EFFECT,           0, FLYING,       100, 20
	move SELFDESTRUCT, EXPLODE_EFFECT,             200, NORMAL,       100,  5 ; [TM36] power 130->200
;	move EGG_BOMB,     NO_ADDITIONAL_EFFECT,       100, NORMAL,        75, 10 ; - REMOVED
	move LICK,         PARALYZE_SIDE_EFFECT2,       30, GHOST,        100, 30 ; power 20->30
	move SMOG,         POISON_SIDE_EFFECT4,         30, POISON,        70, 20 ; power 20->30
	move SLUDGE,       POISON_SIDE_EFFECT4,         65, POISON,       100, 20
	move BONE_CLUB,    FLINCH_SIDE_EFFECT1,         65, GROUND,        85, 20
	move FIRE_BLAST,   BURN_SIDE_EFFECT2,          120, FIRE,          85,  5 ; [TM38]
	move WATERFALL,    FLINCH_SIDE_EFFECT2,         80, WATER,        100, 15 ; 20% chance flinch
	move CLAMP,        TRAPPING_EFFECT,             35, WATER,         75, 10
	move SWIFT,        SWIFT_EFFECT,                60, NORMAL,       100, 20
;	move SKULL_BASH,   CHARGE_EFFECT,              100, NORMAL,       100, 15
	move SPIKE_CANNON, TWO_TO_FIVE_ATTACKS_EFFECT,  20, NORMAL,       100, 15
;	move CONSTRICT,    SPEED_DOWN_SIDE_EFFECT3,      10, NORMAL,      100, 35 ; - REMOVED
	move AMNESIA,      SPECIAL_UP2_EFFECT,           0, PSYCHIC_TYPE, 100, 20
;	move KINESIS,      ACCURACY_DOWN1_EFFECT,        0, PSYCHIC_TYPE,  80, 15 ; - REMOVED
	move SOFTBOILED,   HEAL_EFFECT,                  0, NORMAL,       100, 10
	move HI_JUMP_KICK, JUMP_KICK_EFFECT,           130, FIGHTING,      90, 20 ; power 85->130
	move GLARE,        PARALYZE_EFFECT,              0, NORMAL,        75, 30
	move DREAM_EATER,  DREAM_EATER_EFFECT,         100, PSYCHIC_TYPE, 100, 15
	move POISON_GAS,   POISON_EFFECT,                0, POISON,        55, 40
;	move BARRAGE,      TWO_TO_FIVE_ATTACKS_EFFECT,  15, NORMAL,        85, 20 ; - REMOVED
	move LEECH_LIFE,   DRAIN_HP_EFFECT,             80, BUG,          100, 10 ; power 20->80, PP 15->10
	move LOVELY_KISS,  SLEEP_EFFECT,                 0, NORMAL,        75, 10
;	move SKY_ATTACK,   CHARGE_EFFECT,              140, FLYING,        90,  5
	move TRANSFORM,    TRANSFORM_EFFECT,             0, NORMAL,       100, 10
	move BUBBLE,       SPEED_DOWN_SIDE_EFFECT3,      20, WATER,       100, 30 ; keep power 20 instead raising to 40 otherwise gets just better than WATER_GUN
	move DIZZY_PUNCH,  CONFUSION_SIDE_EFFECT2,      70, NORMAL,       100, 10 ; 20% confusion
	move SPORE,        SLEEP_EFFECT,                 0, GRASS,        100, 15
	move FLASH,        ACCURACY_DOWN1_EFFECT,        0, NORMAL,       100, 20 ; 70->100% accuracy
	move PSYWAVE,      SPECIAL_DAMAGE_EFFECT,        1, PSYCHIC_TYPE, 100, 15 ; [TM46] 80->100% accuracy
	move SPLASH,       SPLASH_EFFECT,                0, NORMAL,       100, 40
	move ACID_ARMOR,   DEFENSE_UP2_EFFECT,           0, POISON,       100, 40
	move CRABHAMMER,   NO_ADDITIONAL_EFFECT,       100, WATER,         90, 10 ; high crit rate ; power 90->100, accuracy 85->90%
	move EXPLOSION,    EXPLODE_EFFECT,             250, NORMAL,       100,  5 ; power 170->250
	move FURY_SWIPES,  TWO_TO_FIVE_ATTACKS_EFFECT,  18, NORMAL,        80, 15 ; [TM47]
	move BONEMERANG,   ATTACK_TWICE_EFFECT,         50, GROUND,        90, 10
	move REST,         HEAL_EFFECT,                  0, PSYCHIC_TYPE, 100, 10 ; [TM42]
	move ROCK_SLIDE,   FLINCH_SIDE_EFFECT3,	        75, ROCK,          90, 10 ; [TM48] gained the 30% flinch chance
	move HYPER_FANG,   FLINCH_SIDE_EFFECT1,         80, NORMAL,        90, 15
;	move SHARPEN,      ATTACK_UP1_EFFECT,            0, NORMAL,       100, 30 ; - REMOVED - Porygon will get SWORDS_DANCE and AMNESIA instead :)
	move CONVERSION,   CONVERSION_EFFECT,            0, NORMAL,       100, 30
	move TRI_ATTACK,   TRIATTACK_EFFECT,	        80, NORMAL,       100, 10 ; triple effect!
	move SUPER_FANG,   SUPER_FANG_EFFECT,            1, NORMAL,        90, 10
	move SLASH,        NO_ADDITIONAL_EFFECT,        70, NORMAL,       100, 20 ; high crit rate
	move SUBSTITUTE,   SUBSTITUTE_EFFECT,            0, NORMAL,       100, 10 ; [TM50]

	move MEGAHORN,	   NO_ADDITIONAL_EFFECT,	   120,	BUG,		   85, 10 ; [TM02] done
	move X_SCISSOR,	   NO_ADDITIONAL_EFFECT,	    80,	BUG,	      100, 15 ; [TM44] done
	move INFESTATION,  TRAPPING_EFFECT,	            20,	BUG,	       80, 20 ; done

	move FEINT_ATTACK, SWIFT_EFFECT,	            60,	DARK,	      100, 20 ; [TM20] done
	move CRUNCH,	   SPECIAL_DOWN_SIDE_EFFECT2,   80,	DARK,	      100, 15 ; done, to be further tested
	move NIGHT_SLASH,  NO_ADDITIONAL_EFFECT,	    70,	DARK,	      100, 15 ; high crit rate ; done
	move DARK_PULSE,   FLINCH_SIDE_EFFECT2,	        80,	DARK,	      100, 15 ; [TM07] done

	move TWISTER,	   FLINCH_SIDE_EFFECT2,	        40,	DRAGON,	      100, 20 ; done
	move DRAGONBREATH, PARALYZE_SIDE_EFFECT2,	    60,	DRAGON,	      100, 20 ; done
	move OUTRAGE,	   THRASH_PETAL_DANCE_EFFECT,  120,	DRAGON,	      100, 10 ; [TM40] done
	move DRAGON_CLAW,  NO_ADDITIONAL_EFFECT,	    80,	DRAGON,	      100, 15 ; [TM05] done
	move DRAGON_DANCE, ATTACK_SPEED_UP1_EFFECT,	     0,	DRAGON,	      100, 20 ; done, may need more testing

	move ZAP_CANNON,   PARALYZE_SIDE_EFFECT_CERT,  120,	ELECTRIC,	   50, 5  ; done? 100% paralysis
	move SHOCK_WAVE,   SWIFT_EFFECT,	            60,	ELECTRIC,	  100, 20 ; done
	move VOLT_TACKLE,  RECOIL_EFFECT,	           120,	ELECTRIC,	  100, 15 ; done

	move CHARM,	       ATTACK_DOWN2_EFFECT,	         0,	FAIRY,	      100, 20 ; done
	move DRAININGKISS, DRAIN_HP_EFFECT,	            50,	FAIRY,	      100, 10 ; [TM17] done!
	move PLAY_ROUGH,   ATTACK_DOWN_SIDE_EFFECT1,    90,	FAIRY,	       90, 10 ; done, to be further tested
	move MOONBLAST,	   SPECIAL_DOWN_SIDE_EFFECT3,	95,	FAIRY,	      100, 15 ; [TM30] done (it should be 30% and it's 33%, doesn't matter)

	move MACH_PUNCH,   NO_ADDITIONAL_EFFECT,	    40,	FIGHTING,	  100, 30 ; prio +1 ; done
	move SUPERPOWER,   ATTACK_DEFENSE_SELFDOWN1,   120,	FIGHTING,	  100, 5  ; done, to be further tested
	move CLOSE_COMBAT, DEFENSE_SPECIAL_SELFDOWN1,  120,	FIGHTING,	  100, 5  ; [TM37] done, to be further tested
	move DRAIN_PUNCH,  DRAIN_HP_EFFECT,	            75,	FIGHTING,	  100, 10 ; done

	move WILL_O_WISP,  BURN_EFFECT,	     			 0,	FIRE,	       85, 15 ; [TM23] done
	move FLARE_BLITZ,  RECOIL_EFFECT,	           120,	FIRE,	      100, 15 ; done
	move BLAST_BURN,   HYPER_BEAM_EFFECT,	       150,	FIRE,	       90, 5  ; done
	move HEAT_WAVE,    BURN_SIDE_EFFECT1,          100, FIRE,          90, 10 ; done

	move ROOST,	       HEAL_EFFECT,	                 0,	FLYING,	      100, 5  ; done
	move AIR_CUTTER,   NO_ADDITIONAL_EFFECT,	    60,	FLYING,	       95, 25 ; high crit rate ; done
	move AERIAL_ACE,   SWIFT_EFFECT,	            60,	FLYING,	      100, 20 ; done
	move AIR_SLASH,	   FLINCH_SIDE_EFFECT3,	        75,	FLYING,	       95, 15 ; done
	move BRAVE_BIRD,   RECOIL_EFFECT,	           120,	FLYING,	      100, 15 ; [TM41] done
	move HURRICANE,	   CONFUSION_SIDE_EFFECT3,	   110,	FLYING,	       70, 10 ; done (thanks to Vortiene)

	move SHADOW_BALL,  SPECIAL_DOWN_SIDE_EFFECT2,   80,	GHOST,	      100, 15 ; [TM49], done, to be further tested
	move SHADOW_PUNCH, SWIFT_EFFECT,	            60,	GHOST,	      100, 20 ; done
	move SHADOW_SNEAK, NO_ADDITIONAL_EFFECT,	    40,	GHOST,	      100, 30 ; [TM39] prio +1 ; done
	move SHADOW_CLAW,  NO_ADDITIONAL_EFFECT,	    70,	GHOST,	      100, 15 ; high crit rate ; done

	move GIGA_DRAIN,   DRAIN_HP_EFFECT,	            75,	GRASS,        100, 10 ; [TM21] done
	move MAGICAL_LEAF, SWIFT_EFFECT,	            60,	GRASS,        100, 20 ; done
	move BULLET_SEED,  TWO_TO_FIVE_ATTACKS_EFFECT,  25,	GRASS,        100, 30 ; done
	move LEAF_STORM,   SPECIAL_SELFDOWN2,	   	   130, GRASS,         90, 5  ; done, to be further tested
	move ENERGY_BALL,  SPECIAL_DOWN_SIDE_EFFECT1,   90,	GRASS,        100, 10 ; done, to be further tested
	move FRENZY_PLANT, HYPER_BEAM_EFFECT,	       150,	GRASS,         90, 5  ; done

	move MUD_SLAP,	   ACCURACY_DOWN_SIDE_EFFECT_CERT,	20,	GROUND,   100, 10 ; done, to be further tested
	move MUD_SHOT,	   SPEED_DOWN_SIDE_EFFECT_CERT,	55,	GROUND,	       95, 15 ; done, to be further tested

	move ICICLE_SPEAR, TWO_TO_FIVE_ATTACKS_EFFECT,  25,	ICE,	      100, 30 ; done
	move ICICLE_CRASH, FLINCH_SIDE_EFFECT3,	        85,	ICE,	       90, 10 ; done

	move EXTREMESPEED, NO_ADDITIONAL_EFFECT,		80, NORMAL,		  100, 5  ; prio +2 ; done

	move GUNK_SHOT,	   POISON_SIDE_EFFECT3,		   120,	POISON,	       80, 5  ; [TM43] done
	move SLUDGE_WAVE,  POISON_SIDE_EFFECT1,		    95,	POISON,	      100, 10 ; done

	move MIRROR_COAT,  NO_ADDITIONAL_EFFECT,	     1,	PSYCHIC_TYPE, 100, 20 ; [TM16] prio -6 ; done?
	move ZEN_HEADBUTT, FLINCH_SIDE_EFFECT2,	        80,	PSYCHIC_TYPE,  90, 15 ; done
	move PSYCHO_CUT,   NO_ADDITIONAL_EFFECT,	    70,	PSYCHIC_TYPE, 100, 20 ; high crit rate ; done

	move ROCK_TOMB,	   SPEED_DOWN_SIDE_EFFECT_CERT, 60,	ROCK,	       95, 15 ; done, to be further tested
	move HEAD_SMASH,   RECOIL_EFFECT,	           150,	ROCK,	       80, 5  ; done (1/2 instead 1/3 study more the code in engine/battle/move_effects/recoil)
	move STONE_EDGE,   NO_ADDITIONAL_EFFECT,	   100,	ROCK,	       80, 5  ; [TM22] high crit rate ; done
;	move ACCELEROCK,   NO_ADDITIONAL_EFFECT,	    40,	ROCK,	      100, 20 ; prio +1 ; done

	move IRON_TAIL,    DEFENSE_DOWN_SIDE_EFFECT3,  100, STEEL,	       75, 15 ; done - it should be 30% chance rather than 33% but doesn't matter
	move STEEL_WING,   DEFENSE_UP_SIDE_EFF1,	    70,	STEEL,	       90, 25 ; done, to be further tested - self-buff, 10% def
	move METAL_CLAW,   ATTACK_UP_SIDE_EFF1,	    	50,	STEEL,	       95, 35 ; done, to be further tested - self-buff, 10% atk
	move METEOR_MASH,  ATTACK_UP_SIDE_EFF2, 	   100,	STEEL,	       85, 10 ; done, to be further tested - self-buff, 20% atk [TM09] - DOING!?
	move BULLET_PUNCH, NO_ADDITIONAL_EFFECT,	    40,	STEEL,	      100, 30 ; prio +1 ; done
	move FLASH_CANNON, SPECIAL_DOWN_SIDE_EFFECT1,	80, STEEL, 		  100, 10 ; [TM18]

	move WATER_PULSE,  CONFUSION_SIDE_EFFECT2,	    60,	WATER,	      100, 20 ; done
	move AQUA_JET,     NO_ADDITIONAL_EFFECT,	    40,	WATER,	      100, 20 ; prio +1 ; done
	move SCALD,        BURN_SIDE_EFFECT2,           80,	WATER,	      100, 15 ; done
	move HYDRO_CANNON, HYPER_BEAM_EFFECT,          150,	WATER,	       90, 5  ; done

	; peculiar new moves
	move FREEZE_DRY,   FREEZE_SIDE_EFFECT,          70,	ICE2,	      100, 20 ; testing
	move GYRO_BALL,    NO_ADDITIONAL_EFFECT,         1,	STEEL,	      100,  5 ; testing
	move PSYSTRIKE,    NO_ADDITIONAL_EFFECT,       100,	PSYCHIC_TYPE, 100, 10 ; testing

	; KAAARP!!!
	move ANCESTOR_PWR, FLINCH_SIDE_EFFECT5,        255,	WATER,	      100, 5  ; prio +3, high crit rate - meme secret easter-egg move for Magikarp :)

	; anomalies' signature moves
	move ETERNABEAM,   HYPER_BEAM_EFFECT,          160, DRAGON,        90, 5 ; done
	move DRAGONASCENT, DEFENSE_SPECIAL_SELFDOWN1,  120, FLYING,       100, 5 ; done
	move THOUSANDARROWS, NO_ADDITIONAL_EFFECT,      90, GROUND2,      100, 5 ; TBV
	move PHOTONGEYSER, NO_ADDITIONAL_EFFECT,       100, PSYCHIC_TYPE, 100, 5 ; TODO: implement effect?
	move JUDGMENT,     NO_ADDITIONAL_EFFECT,       100, NORMAL,       100, 5 ; TODO: implement effect?! Or change BP to 200? Or add a new type like Normal in def but super against all types?

	move STRUGGLE,     RECOIL_EFFECT,               50, TYPELESS,     100, 10 ; made typeless so that Magikarp can win the game alone!
	assert_table_length NUM_ATTACKS
