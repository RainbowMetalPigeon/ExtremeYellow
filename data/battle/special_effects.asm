SpecialEffects:
; Effects from arrays 2, 4, and 5B, minus Twineedle and Rage.
; Includes all effects that do not need to be called at the end of
; ExecutePlayerMove (or ExecuteEnemyMove), because they have already been handled
	db DRAIN_HP_EFFECT
	db EXPLODE_EFFECT
	db DREAM_EATER_EFFECT
	db PAY_DAY_EFFECT
	db SWIFT_EFFECT
	db TWO_TO_FIVE_ATTACKS_EFFECT
;	db EFFECT_1E ; REMOVED because never used?
	db CHARGE_EFFECT
	db SUPER_FANG_EFFECT
	db SPECIAL_DAMAGE_EFFECT
	db FLY_EFFECT
	db ATTACK_TWICE_EFFECT
	db JUMP_KICK_EFFECT
	db RECOIL_EFFECT
	db ATTACK_UP_SIDE_EFF1	; new, testing
	db DEFENSE_UP_SIDE_EFF1	; new, testing
	db ATTACK_UP_SIDE_EFF2	; new, testing
	db ATTACK_SELFDOWN1		; new, proxy testing
	db DEFENSE_SELFDOWN1		; new, proxy testing
	db SPEED_SELFDOWN1		; new, proxy testing
	db SPECIAL_SELFDOWN1		; new, proxy testing
	db ATTACK_SELFDOWN2		; new, proxy testing
	db DEFENSE_SELFDOWN2		; new, proxy testing
	db SPEED_SELFDOWN2		; new, proxy testing
	db SPECIAL_SELFDOWN2		; new, proxy testing
	db ATTACK_DEFENSE_SELFDOWN1	; new, proxy testing
	db DEFENSE_SPECIAL_SELFDOWN1	; new, proxy testing
	; fallthrough
SpecialEffectsCont:
; damaging moves whose effect is executed prior to damage calculation
	db THRASH_PETAL_DANCE_EFFECT
	db TRAPPING_EFFECT
	db -1 ; end
