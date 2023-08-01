MoveEffectPointerTable:
; entries correspond to *_EFFECT constants
	table_width 2, MoveEffectPointerTable
	dw SleepEffect               ; EFFECT_01
	dw PoisonEffect              ; POISON_SIDE_EFFECT1
	dw DrainHPEffect             ; DRAIN_HP_EFFECT
	dw FreezeBurnParalyzeEffect  ; BURN_SIDE_EFFECT1
	dw FreezeBurnParalyzeEffect  ; FREEZE_SIDE_EFFECT
	dw FreezeBurnParalyzeEffect  ; PARALYZE_SIDE_EFFECT1
	dw ExplodeEffect             ; EXPLODE_EFFECT
	dw DrainHPEffect             ; DREAM_EATER_EFFECT
	dw NULL                      ; MIRROR_MOVE_EFFECT
	dw StatModifierUpEffect      ; ATTACK_UP1_EFFECT
	dw StatModifierUpEffect      ; DEFENSE_UP1_EFFECT
	dw StatModifierUpEffect      ; SPEED_UP1_EFFECT
	dw StatModifierUpEffect      ; SPECIAL_UP1_EFFECT
	dw StatModifierUpEffect      ; ACCURACY_UP1_EFFECT
	dw StatModifierUpEffect      ; EVASION_UP1_EFFECT
	dw PayDayEffect              ; PAY_DAY_EFFECT
	dw NULL                      ; SWIFT_EFFECT
	dw StatModifierDownEffect    ; ATTACK_DOWN1_EFFECT
	dw StatModifierDownEffect    ; DEFENSE_DOWN1_EFFECT
	dw StatModifierDownEffect    ; SPEED_DOWN1_EFFECT
	dw StatModifierDownEffect    ; SPECIAL_DOWN1_EFFECT
	dw StatModifierDownEffect    ; ACCURACY_DOWN1_EFFECT
	dw StatModifierDownEffect    ; EVASION_DOWN1_EFFECT
	dw ConversionEffect          ; CONVERSION_EFFECT
	dw HazeEffect                ; HAZE_EFFECT
	dw BideEffect                ; BIDE_EFFECT
	dw ThrashPetalDanceEffect    ; THRASH_PETAL_DANCE_EFFECT
	dw SwitchAndTeleportEffect   ; SWITCH_AND_TELEPORT_EFFECT
	dw TwoToFiveAttacksEffect    ; TWO_TO_FIVE_ATTACKS_EFFECT
	dw FlinchSideEffect          ; FLINCH_SIDE_EFFECT3 - new
	dw FlinchSideEffect          ; FLINCH_SIDE_EFFECT1
	dw SleepEffect               ; SLEEP_EFFECT
	dw PoisonEffect              ; POISON_SIDE_EFFECT2
	dw FreezeBurnParalyzeEffect  ; BURN_SIDE_EFFECT2
	dw FlinchSideEffect		     ; FLINCH_SIDE_EFFECT5 - new
	dw FreezeBurnParalyzeEffect  ; PARALYZE_SIDE_EFFECT2
	dw FlinchSideEffect          ; FLINCH_SIDE_EFFECT2
	dw OneHitKOEffect            ; OHKO_EFFECT
	dw ChargeEffect              ; CHARGE_EFFECT
	dw NULL                      ; SUPER_FANG_EFFECT
	dw NULL                      ; SPECIAL_DAMAGE_EFFECT
	dw TrappingEffect            ; TRAPPING_EFFECT
	dw ChargeEffect              ; FLY_EFFECT
	dw TwoToFiveAttacksEffect    ; ATTACK_TWICE_EFFECT
	dw NULL                      ; JUMP_KICK_EFFECT
	dw MistEffect                ; MIST_EFFECT
	dw FocusEnergyEffect         ; FOCUS_ENERGY_EFFECT
	dw RecoilEffect              ; RECOIL_EFFECT
	dw ConfusionEffect           ; CONFUSION_EFFECT
	dw StatModifierUpEffect      ; ATTACK_UP2_EFFECT
	dw StatModifierUpEffect      ; DEFENSE_UP2_EFFECT
	dw StatModifierUpEffect      ; SPEED_UP2_EFFECT
	dw StatModifierUpEffect      ; SPECIAL_UP2_EFFECT
	dw StatModifierUpEffect      ; ACCURACY_UP2_EFFECT
	dw StatModifierUpEffect      ; EVASION_UP2_EFFECT
	dw HealEffect                ; HEAL_EFFECT
	dw TransformEffect           ; TRANSFORM_EFFECT
	dw StatModifierDownEffect    ; ATTACK_DOWN2_EFFECT
	dw StatModifierDownEffect    ; DEFENSE_DOWN2_EFFECT
	dw StatModifierDownEffect    ; SPEED_DOWN2_EFFECT
	dw StatModifierDownEffect    ; SPECIAL_DOWN2_EFFECT
	dw StatModifierDownEffect    ; ACCURACY_DOWN2_EFFECT
	dw StatModifierDownEffect    ; EVASION_DOWN2_EFFECT
	dw ReflectLightScreenEffect  ; LIGHT_SCREEN_EFFECT
	dw ReflectLightScreenEffect  ; REFLECT_EFFECT
	dw PoisonEffect              ; POISON_EFFECT
	dw ParalyzeEffect            ; PARALYZE_EFFECT

	dw StatModifierDownEffect    ; ATTACK_DOWN_SIDE_EFFECT1
	dw StatModifierDownEffect    ; DEFENSE_DOWN_SIDE_EFFECT1
	dw StatModifierDownEffect    ; SPEED_DOWN_SIDE_EFFECT1
	dw StatModifierDownEffect    ; SPECIAL_DOWN_SIDE_EFFECT1
	dw StatModifierDownEffect    ; unused effect - would this be accuracy?
	dw StatModifierDownEffect    ; unused effect - would this be evasion?

	dw StatModifierDownEffect    ; ATTACK_DOWN_SIDE_EFFECT2
	dw StatModifierDownEffect    ; DEFENSE_DOWN_SIDE_EFFECT2
	dw StatModifierDownEffect    ; SPEED_DOWN_SIDE_EFFECT2
	dw StatModifierDownEffect    ; SPECIAL_DOWN_SIDE_EFFECT2
	dw StatModifierDownEffect    ; unused effect - would this be accuracy?
	dw StatModifierDownEffect    ; unused effect - would this be evasion?

	dw StatModifierDownEffect    ; ATTACK_DOWN_SIDE_EFFECT3
	dw StatModifierDownEffect    ; DEFENSE_DOWN_SIDE_EFFECT3
	dw StatModifierDownEffect    ; SPEED_DOWN_SIDE_EFFECT3
	dw StatModifierDownEffect    ; SPECIAL_DOWN_SIDE_EFFECT3
	dw StatModifierDownEffect    ; unused effect - would this be accuracy?
	dw StatModifierDownEffect    ; unused effect - would this be evasion?

	dw StatModifierDownEffect    ; ATTACK_DOWN_SIDE_EFFECT_CERT
	dw StatModifierDownEffect    ; DEFENSE_DOWN_SIDE_EFFECT_CERT
	dw StatModifierDownEffect    ; SPEED_DOWN_SIDE_EFFECT_CERT
	dw StatModifierDownEffect    ; SPECIAL_DOWN_SIDE_EFFECT_CERT
	dw StatModifierDownEffect    ; ACCURACY_DOWN_SIDE_EFFECT_CERT
	dw StatModifierDownEffect    ; EVASION_DOWN_SIDE_EFFECT_CERT

	dw Confusion10SideEffect     ; CONFUSION_SIDE_EFFECT1
	dw Confusion20SideEffect     ; CONFUSION_SIDE_EFFECT2
	dw Confusion30SideEffect     ; CONFUSION_SIDE_EFFECT3
	dw TwoToFiveAttacksEffect    ; TWINEEDLE_EFFECT
	dw NULL                      ; unused effect
	dw SubstituteEffect          ; SUBSTITUTE_EFFECT
	dw HyperBeamEffect           ; HYPER_BEAM_EFFECT
;	dw RageEffect                ; RAGE_EFFECT
	dw MimicEffect               ; MIMIC_EFFECT
	dw NULL                      ; METRONOME_EFFECT
	dw LeechSeedEffect           ; LEECH_SEED_EFFECT
	dw SplashEffect              ; SPLASH_EFFECT
	dw DisableEffect             ; DISABLE_EFFECT
	dw PoisonEffect              ; POISON_SIDE_EFFECT3 - brand new
	dw PoisonEffect              ; POISON_SIDE_EFFECT4 - brand new
	dw FreezeBurnParalyzeEffect  ; PARALYZE_SIDE_EFFECT_CERT - brand new
	dw BurnEffect	             ; BURN_EFFECT
	dw TriAttackEffect			 ; TRIATTACK_EFFECT

	dw AttackSpeedUpEffect 		 ; ATTACK_SPEED_UP1_EFFECT - new for DRAGON_DANCE

	dw SelfBuff10Percent		 ; ATTACK_UP_SIDE_EFF1, new
	dw SelfBuff10Percent		 ; DEFENSE_UP_SIDE_EFF1, new
	dw SelfBuff20Percent		 ; ATTACK_UP_SIDE_EFF2, new

	dw AttackDefenseSelfDownEffect  ; ATTACK_DEFENSE_SELFDOWN1 - new for SUPERPOWER
	dw DefenseSpecialSelfDownEffect ; DEFENSE_SPECIAL_SELFDOWN1 - new for CLOSE_COMBAT

	dw StatModifierSelfDownEffect ; ATTACK_SELFDOWN1, new
	dw StatModifierSelfDownEffect ; DEFENSE_SELFDOWN1, new
	dw StatModifierSelfDownEffect ; SPEED_SELFDOWN1, new
	dw StatModifierSelfDownEffect ; SPECIAL_SELFDOWN1, new
	dw StatModifierSelfDownEffect ; ATTACK_SELFDOWN2, new
	dw StatModifierSelfDownEffect ; DEFENSE_SELFDOWN2, new
	dw StatModifierSelfDownEffect ; SPEED_SELFDOWN2, new
	dw StatModifierSelfDownEffect ; SPECIAL_SELFDOWN2, new

	assert_table_length NUM_MOVE_EFFECTS
