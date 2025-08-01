; move ids
; indexes for:
; - Moves (see data/moves/moves.asm)
; - MoveNames (see data/moves/names.asm)
; - AttackAnimationPointers (see data/moves/animations.asm)
; - MoveSoundTable (see data/moves/sfx.asm)
	const_def
	const NO_MOVE      ; 00
	const POUND        ; 01
	const KARATE_CHOP  ; 02
;	const DOUBLESLAP   ; 03
	const COMET_PUNCH  ; 04-1
	const MEGA_PUNCH   ; 05
	const PAY_DAY      ; 06
	const FIRE_PUNCH   ; 07
	const ICE_PUNCH    ; 08
	const THUNDERPUNCH ; 09
	const SCRATCH      ; 0a
;	const VICEGRIP     ; 0b
	const GUILLOTINE   ; 0c-2
;	const RAZOR_WIND   ; 0d - REMOVED
	const SWORDS_DANCE ; 0e-3
	const CUT          ; 0f
	const GUST         ; 10
	const WING_ATTACK  ; 11
;	const WHIRLWIND    ; 12
	const FLY          ; 13-4
;	const BIND         ; 14 - REMOVED
	const SLAM         ; 15
	const VINE_WHIP    ; 16
	const STOMP        ; 17
	const DOUBLE_KICK  ; 18
;	const MEGA_KICK    ; 19
;	const JUMP_KICK    ; 1a - REMOVED
	const ROLLING_KICK ; 1b
	const SAND_ATTACK  ; 1c
	const HEADBUTT     ; 1d
	const HORN_ATTACK  ; 1e
	const FURY_ATTACK  ; 1f
	const HORN_DRILL   ; 20
	const TACKLE       ; 21
	const BODY_SLAM    ; 22
	const WRAP         ; 23
	const TAKE_DOWN    ; 24
	const THRASH       ; 25
	const DOUBLE_EDGE  ; 26
;	const TAIL_WHIP    ; 27
	const POISON_STING ; 28-5
	const TWINEEDLE    ; 29
	const PIN_MISSILE  ; 2a
	const LEER         ; 2b
	const BITE         ; 2c
	const GROWL        ; 2d
;	const ROAR         ; 2e
	const SING         ; 2f-6
	const SUPERSONIC   ; 30
	const SONICBOOM    ; 31
	const DISABLE      ; 32
	const ACID         ; 33
	const EMBER        ; 34
	const FLAMETHROWER ; 35
;	const MIST         ; 36 - REMOVED
	const WATER_GUN    ; 37
	const HYDRO_PUMP   ; 38
	const SURF         ; 39
	const ICE_BEAM     ; 3a
	const BLIZZARD     ; 3b
	const PSYBEAM      ; 3c
	const BUBBLEBEAM   ; 3d
	const AURORA_BEAM  ; 3e
	const HYPER_BEAM   ; 3f
	const PECK         ; 40
	const DRILL_PECK   ; 41
	const SUBMISSION   ; 42
	const LOW_KICK     ; 43
	const COUNTER      ; 44
	const SEISMIC_TOSS ; 45
	const STRENGTH     ; 46
	const ABSORB       ; 47
	const MEGA_DRAIN   ; 48
	const LEECH_SEED   ; 49
	const GROWTH       ; 4a
	const RAZOR_LEAF   ; 4b
	const SOLARBEAM    ; 4c
	const POISONPOWDER ; 4d
	const STUN_SPORE   ; 4e
	const SLEEP_POWDER ; 4f
	const PETAL_DANCE  ; 50
	const STRING_SHOT  ; 51
	const DRAGON_RAGE  ; 52
	const FIRE_SPIN    ; 53
	const THUNDERSHOCK ; 54
	const THUNDERBOLT  ; 55
	const THUNDER_WAVE ; 56
	const THUNDER      ; 57
	const ROCK_THROW   ; 58
	const EARTHQUAKE   ; 59
	const FISSURE      ; 5a
	const DIG          ; 5b
	const TOXIC        ; 5c
	const CONFUSION    ; 5d
	const PSYCHIC_M    ; 5e
	const HYPNOSIS     ; 5f
;	const MEDITATE     ; 60 - REMOVED
	const AGILITY      ; 61
	const QUICK_ATTACK ; 62
;	const RAGE         ; 63-7
	const TELEPORT     ; 64
	const NIGHT_SHADE  ; 65
	const MIMIC        ; 66
	const SCREECH      ; 67
	const DOUBLE_TEAM  ; 68
	const RECOVER      ; 69
	const HARDEN       ; 6a
	const MINIMIZE     ; 6b
	const SMOKESCREEN  ; 6c
	const CONFUSE_RAY  ; 6d
;	const WITHDRAW     ; 6e
	const DEFENSE_CURL ; 6f-8
	const BARRIER      ; 70
	const LIGHT_SCREEN ; 71
	const HAZE         ; 72
	const REFLECT      ; 73
	const FOCUS_ENERGY ; 74
	const BIDE         ; 75
	const METRONOME    ; 76
	const MIRROR_MOVE  ; 77
	const SELFDESTRUCT ; 78
;	const EGG_BOMB     ; 79 - REMOVED
	const LICK         ; 7a-9
	const SMOG         ; 7b
	const SLUDGE       ; 7c
	const BONE_CLUB    ; 7d
	const FIRE_BLAST   ; 7e
	const WATERFALL    ; 7f
	const CLAMP        ; 80
	const SWIFT        ; 81
;	const SKULL_BASH   ; 82
	const SPIKE_CANNON ; 83
;	const CONSTRICT    ; 84 - REMOVED
	const AMNESIA      ; 85-a
;	const KINESIS      ; 86
	const SOFTBOILED   ; 87-b
	const HI_JUMP_KICK ; 88
	const GLARE        ; 89
	const DREAM_EATER  ; 8a
	const POISON_GAS   ; 8b
;	const BARRAGE      ; 8c - REMOVED
	const LEECH_LIFE   ; 8d
	const LOVELY_KISS  ; 8e
;	const SKY_ATTACK   ; 8f
	const TRANSFORM    ; 90
	const BUBBLE       ; 91
	const DIZZY_PUNCH  ; 92
	const SPORE        ; 93
	const FLASH        ; 94
	const PSYWAVE      ; 95
	const SPLASH       ; 96
	const ACID_ARMOR   ; 97
	const CRABHAMMER   ; 98
	const EXPLOSION    ; 99
	const FURY_SWIPES  ; 9a
	const BONEMERANG   ; 9b
	const REST         ; 9c
	const ROCK_SLIDE   ; 9d
	const HYPER_FANG   ; 9e
;	const SHARPEN      ; 9f
	const CONVERSION   ; a0-c
	const TRI_ATTACK   ; a1
	const SUPER_FANG   ; a2
	const SLASH        ; a3
	const SUBSTITUTE   ; a4-c=98

	const	MEGAHORN		;99
	const	X_SCISSOR		;9a
	const	INFESTATION		;9b

	const	FEINT_ATTACK	;9c
	const	CRUNCH			;9d
	const	NIGHT_SLASH		;9e
	const	DARK_PULSE		;9f

	const	TWISTER			;a0
	const	DRAGONBREATH	;a1
	const	OUTRAGE			;a2
	const	DRAGON_CLAW		;a3
	const	DRAGON_DANCE	;a4

	const	ZAP_CANNON		;a5
	const	SHOCK_WAVE		;a6
	const	VOLT_TACKLE		;a7

	const	CHARM			;a8
	const	DRAININGKISS	;a9
	const	PLAY_ROUGH
	const	MOONBLAST

	const	MACH_PUNCH
	const	SUPERPOWER
	const	CLOSE_COMBAT
	const	DRAIN_PUNCH

	const	WILL_O_WISP
	const	FLARE_BLITZ
	const	BLAST_BURN
	const	HEAT_WAVE

	const	ROOST
	const	AIR_CUTTER
	const	AERIAL_ACE
	const	AIR_SLASH
	const	BRAVE_BIRD
	const	HURRICANE

	const	SHADOW_BALL
	const	SHADOW_PUNCH
	const	SHADOW_SNEAK
	const	SHADOW_CLAW

	const	GIGA_DRAIN
	const	MAGICAL_LEAF
	const	BULLET_SEED
	const	LEAF_STORM
	const	ENERGY_BALL
	const	FRENZY_PLANT

	const	MUD_SLAP
	const	MUD_SHOT

	const	ICICLE_SPEAR
	const	ICICLE_CRASH

	const	EXTREMESPEED

	const	GUNK_SHOT
	const	SLUDGE_WAVE

	const	MIRROR_COAT
	const	ZEN_HEADBUTT
	const	PSYCHO_CUT

	const	ROCK_TOMB
	const	HEAD_SMASH
	const	STONE_EDGE
;	const	ACCELEROCK

	const	IRON_TAIL
	const	STEEL_WING
	const	METAL_CLAW
	const	METEOR_MASH
	const	BULLET_PUNCH
	const	FLASH_CANNON

	const	WATER_PULSE
	const	AQUA_JET
	const	SCALD
	const	HYDRO_CANNON

	; peculiar new moves
	const   FREEZE_DRY
	const   GYRO_BALL
	const   PSYSTRIKE
	const   BODY_PRESS
	const   FLAIL
	const   CURSE

	; V2.0 moves
	const ROCK_SMASH
	const SUNNY_DAY
	const RAIN_DANCE
	const SANDSTORM
	const HAIL
	const WEATHER_BALL
	const GRASSY_TERRAIN
	const ELECTRIC_TERRAIN
	const MISTY_TERRAIN
	const PSYCHIC_TERRAIN
	const TERRAIN_PULSE
	const TRICK_ROOM

	; KAAARP!
	const	ANCESTOR_PWR

	; anomalies' signature moves
	const	ETERNABEAM
	const	DRAGONASCENT
	const	THOUSANDARROWS
	const	PHOTONGEYSER
	const	JUDGMENT

	const STRUGGLE     ; formerly a5
DEF NUM_ATTACKS EQU const_value - 1

	; edited: moves NOT LONGER do double duty as animation identifiers: NOW separate other battle animations
	const_def
	const NO_ANIM

	const SHOWPIC_ANIM
	const STATUS_AFFECTED_ANIM
	const ANIM_A8
	const ANIM_A9
	const TRADE_BALL_DROP_ANIM
	const TRADE_BALL_SHAKE_ANIM
	const TRADE_BALL_TILT_ANIM
	const TRADE_BALL_POOF_ANIM
	const XSTATITEM_ANIM ; use X Attack/Defense/Speed/Special
;	const ANIM_AF
	const ANIM_B0
;	const ANIM_B1
;	const ANIM_B2 ; unused?
;	const ANIM_B3 ; unused?
;	const ANIM_B4 ; unused?
;	const ANIM_B5
	const PARALYSIS_ANIM ; unused, for paralysis, I could re-implement it
;	const ANIM_B9
	const BURN_PSN_ANIM ; Plays when a monster is burned or poisoned
;	const ANIM_BB
	const ANIM_BC
	const SLP_ANIM ; sleeping monster
	const ANIM_BE
	const CONF_ANIM ; confused monster
	const ANIM_C0
	const TOSS_ANIM ; toss Poké Ball
	const SHAKE_ANIM ; shaking Poké Ball when catching monster
	const POOF_ANIM ; puff of smoke
	const BLOCKBALL_ANIM ; trainer knocks away Poké Ball
	const GREATTOSS_ANIM ; toss Great Ball
	const ULTRATOSS_ANIM ; toss Ultra Ball or Master Ball
	const ANIM_C7
	const HIDEPIC_ANIM ; monster disappears
	const ROCK_ANIM ; throw rock
	const BAIT_ANIM ; throw bait
	const VANISHBALL_ANIM ; new, for Haunted House
	const SHINY_PLAYER_ANIM ; new, for the shiny
	const SHINY_ENEMY_ANIM ; new, for the shiny
	const BLINK_POKEMON ; new, for the damaging weathers

;DEF NUM_ATTACK_ANIMS EQU const_value - 1
DEF NUM_ALTERNATIVE_ANIMS EQU const_value - 1 ; edited
