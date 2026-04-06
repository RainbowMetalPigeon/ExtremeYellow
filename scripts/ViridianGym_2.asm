PikachuMovementData_ViridianGym_TMHidden_Full:
	db $00
	db $1f ; step left
	db $1e ; step up
	db $35 ; look down
	db $3f

PikachuMovementData_ViridianGym_TMHidden_Turn:
	db $00
	db $35 ; look down
	db $3f

;PikachuMovementData_ViridianGym_TMShown:
;	db $00
;	db $1f ; step left
;	db $38 ; look right
;	db $3f

ViridianGymPikachuMovementScript::
;	CheckHideShowExtra HS_VIRIDIAN_GYM_ITEM_2 ; nz if taken
;	jr nz, .TMHidden
;; TM has not been picked up
;	ld hl, PikachuMovementData_ViridianGym_TMShown
;	jr .gotMovements
;.TMHidden

	callfar GetPikachuFacingDirectionAndReturnToE
	ld a, e
	cp SPRITE_FACING_LEFT
	jr z, .pikachuAlreadyInPosition

	ld hl, PikachuMovementData_ViridianGym_TMHidden_Full
	ld b, SPRITE_FACING_DOWN
	jr .doTheThing

.pikachuAlreadyInPosition
	ld hl, PikachuMovementData_ViridianGym_TMHidden_Turn
	ld b, SPRITE_FACING_LEFT

.doTheThing
	call TryApplyPikachuMovementData
	ret
