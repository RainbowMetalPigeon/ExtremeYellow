; {stat}_(UP|DOWN)(1|2) means that the move raises the user's (or lowers the target's) corresponding stat modifier by 1 (or 2) stages
; {status condition}_SIDE_EFFECT means that the move has a side chance of causing that condition
; {status condition}_EFFECT means that the move causes the status condition every time it hits the target

; MoveEffectPointerTable indexes (see data/moves/effects_pointers.asm)
	const_def
	const NO_ADDITIONAL_EFFECT       ; $00
	const EFFECT_01                  ; $01 unused
	const POISON_SIDE_EFFECT1        ; $02
	const DRAIN_HP_EFFECT            ; $03
	const BURN_SIDE_EFFECT1          ; $04
	const FREEZE_SIDE_EFFECT         ; $05
	const PARALYZE_SIDE_EFFECT1      ; $06
	const EXPLODE_EFFECT             ; $07 Explosion, Self Destruct
	const DREAM_EATER_EFFECT         ; $08
	const MIRROR_MOVE_EFFECT         ; $09
	const ATTACK_UP1_EFFECT          ; $0A = 10
	const DEFENSE_UP1_EFFECT         ; $0B = 11
	const SPEED_UP1_EFFECT           ; $0C = 12
	const SPECIAL_UP1_EFFECT         ; $0D = 13
	const ACCURACY_UP1_EFFECT        ; $0E = 14
	const EVASION_UP1_EFFECT         ; $0F = 15
	const PAY_DAY_EFFECT             ; $10 = 16
	const SWIFT_EFFECT               ; $11 = 17
	const ATTACK_DOWN1_EFFECT        ; $12 = 18
	const DEFENSE_DOWN1_EFFECT       ; $13
	const SPEED_DOWN1_EFFECT         ; $14
	const SPECIAL_DOWN1_EFFECT       ; $15
	const ACCURACY_DOWN1_EFFECT      ; $16
	const EVASION_DOWN1_EFFECT       ; $17
	const CONVERSION_EFFECT          ; $18
	const HAZE_EFFECT                ; $19
	const BIDE_EFFECT                ; $1A
	const THRASH_PETAL_DANCE_EFFECT  ; $1B
	const SWITCH_AND_TELEPORT_EFFECT ; $1C
	const TWO_TO_FIVE_ATTACKS_EFFECT ; $1D
	const FLINCH_SIDE_EFFECT3        ; $1E repurposed, was EFFECT_1E
	const FLINCH_SIDE_EFFECT1        ; $1F
	const SLEEP_EFFECT               ; $20
	const POISON_SIDE_EFFECT2        ; $21 unused
	const BURN_SIDE_EFFECT2          ; $22
	const FLINCH_SIDE_EFFECT5        ; $23 repurposed, was UNUSED_EFFECT_23 - new
	const PARALYZE_SIDE_EFFECT2      ; $24
	const FLINCH_SIDE_EFFECT2        ; $25
	const OHKO_EFFECT                ; $26 moves like Horn Drill
	const CHARGE_EFFECT              ; $27 moves like Solar Beam
	const SUPER_FANG_EFFECT          ; $28
	const SPECIAL_DAMAGE_EFFECT      ; $29 Seismic Toss, Night Shade, Sonic Boom, Dragon Rage, Psywave
	const TRAPPING_EFFECT            ; $2A moves like Wrap
	const FLY_EFFECT                 ; $2B
	const ATTACK_TWICE_EFFECT        ; $2C
	const JUMP_KICK_EFFECT           ; $2D Jump Kick and Hi Jump Kick effect
	const MIST_EFFECT                ; $2E
	const FOCUS_ENERGY_EFFECT        ; $2F
	const RECOIL_EFFECT              ; $30 moves like Double Edge
	const CONFUSION_EFFECT           ; $31 Confuse Ray, Supersonic (not the move Confusion)
	const ATTACK_UP2_EFFECT          ; $32
	const DEFENSE_UP2_EFFECT         ; $33
	const SPEED_UP2_EFFECT           ; $34
	const SPECIAL_UP2_EFFECT         ; $35
	const ACCURACY_UP2_EFFECT        ; $36
	const EVASION_UP2_EFFECT         ; $37
	const HEAL_EFFECT                ; $38 Recover, Softboiled, Rest (Roost)
	const TRANSFORM_EFFECT           ; $39
	const ATTACK_DOWN2_EFFECT        ; $3A
	const DEFENSE_DOWN2_EFFECT       ; $3B
	const SPEED_DOWN2_EFFECT         ; $3C
	const SPECIAL_DOWN2_EFFECT       ; $3D
	const ACCURACY_DOWN2_EFFECT      ; $3E
	const EVASION_DOWN2_EFFECT       ; $3F
	const LIGHT_SCREEN_EFFECT        ; $40
	const REFLECT_EFFECT             ; $41
	const POISON_EFFECT              ; $42
	const PARALYZE_EFFECT            ; $43

	const ATTACK_DOWN_SIDE_EFFECT1   ; $44 - the position of this one is important for statModifierDownEffect!!!
	const DEFENSE_DOWN_SIDE_EFFECT1  ; $45
	const SPEED_DOWN_SIDE_EFFECT1    ; $46
	const SPECIAL_DOWN_SIDE_EFFECT1  ; $47
	const_skip                       ; $48
	const_skip                       ; $49

	const ATTACK_DOWN_SIDE_EFFECT2   ; - the position of this one is important for statModifierDownEffect!!!
	const DEFENSE_DOWN_SIDE_EFFECT2  ;
	const SPEED_DOWN_SIDE_EFFECT2    ;
	const SPECIAL_DOWN_SIDE_EFFECT2  ;
	const_skip                       ;
	const_skip                       ;

	const ATTACK_DOWN_SIDE_EFFECT3   ; - the position of this one is important for statModifierDownEffect!!!
	const DEFENSE_DOWN_SIDE_EFFECT3  ;
	const SPEED_DOWN_SIDE_EFFECT3    ;
	const SPECIAL_DOWN_SIDE_EFFECT3  ;
	const_skip                       ;
	const_skip                       ;

	const ATTACK_DOWN_SIDE_EFFECT_CERT
	const DEFENSE_DOWN_SIDE_EFFECT_CERT
	const SPEED_DOWN_SIDE_EFFECT_CERT
	const SPECIAL_DOWN_SIDE_EFFECT_CERT
	const ACCURACY_DOWN_SIDE_EFFECT_CERT
	const EVASION_DOWN_SIDE_EFFECT_CERT

	const CONFUSION_SIDE_EFFECT1     ; $4A new, was const_skip
	const CONFUSION_SIDE_EFFECT2     ; $4B new, was const_skip
	const CONFUSION_SIDE_EFFECT3     ; $4C edited, was numberless
	const TWINEEDLE_EFFECT           ; $4D
	const_skip                       ; $4E
	const SUBSTITUTE_EFFECT          ; $4F
	const HYPER_BEAM_EFFECT          ; $50
	const CURSE_EFFECT               ; $51 edited, was rage
	const MIMIC_EFFECT               ; $52
	const METRONOME_EFFECT           ; $53
	const LEECH_SEED_EFFECT          ; $54
	const SPLASH_EFFECT              ; $55
	const DISABLE_EFFECT             ; $56
	const POISON_SIDE_EFFECT3        ; $57 - brand new
	const POISON_SIDE_EFFECT4        ; $57 - brand new
	const PARALYZE_SIDE_EFFECT_CERT  ; - brand new
	const BURN_EFFECT				 ; - brand new
	const TRIATTACK_EFFECT			 ; - brand new

	const ATTACK_SPEED_UP1_EFFECT	 ; - new, to be further tested, for DRAGON_DANCE

	const ATTACK_UP_SIDE_EFF1		 ; new, to be further tested
	const DEFENSE_UP_SIDE_EFF1		 ; new, to be further tested
	const ATTACK_UP_SIDE_EFF2		 ; new, to be further tested

	const ATTACK_DEFENSE_SELFDOWN1	 ; new, testing
	const DEFENSE_SPECIAL_SELFDOWN1  ; new, testing
	const ATTACK_UP_DEFENSE_UP_SPEED_DOWN_EFFECT ; new, testing - for curse

	const ATTACK_SELFDOWN1			 ; new, testing
	const DEFENSE_SELFDOWN1			 ; new, testing
	const SPEED_SELFDOWN1			 ; new, testing - unnecessary as unused
	const SPECIAL_SELFDOWN1			 ; new, testing
	const ATTACK_SELFDOWN2			 ; new, testing - unnecessary as unused
	const DEFENSE_SELFDOWN2			 ; new, testing - unnecessary as unused
	const SPEED_SELFDOWN2			 ; new, testing - unnecessary as unused
	const SPECIAL_SELFDOWN2			 ; new, testing

; new effects -------------------------------

	const SUNNY_DAY_EFFECT
	const RAIN_DANCE_EFFECT

DEF NUM_MOVE_EFFECTS EQU const_value - 1
