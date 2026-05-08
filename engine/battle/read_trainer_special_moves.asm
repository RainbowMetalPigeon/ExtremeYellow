ReadTrainerSpecialMoves::

; does the trainer have additional move data?
; new, to handle randomization of trainers' teams

	ld a, [wRandomizationTrainersTeams] ; 0=NO, 1=YES
	and a
	jr nz, .FinishUp
; back to vanilla
	ld a, [wTrainerClass]
	ld b, a
	push bc
	callfar LoadTrainerNumber ; edited, was simply "ld a, [wTrainerNo]"
	ld a, d
	pop bc
	ld c, a
	ld hl, SpecialTrainerMoves
.loopAdditionalMoveData
	ld a, [hli]
	cp $ff
	jr z, .FinishUp
	cp b
	jr nz, .checkIfTerminator
	ld a, [hli]
	cp c
	jr nz, .checkIfTerminator
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop
	ld a, [de]
	inc de
	cp $FE ; edited, it was "and a", to avoid bugs with NO_MOVE in the special_moves file
	jp z, .FinishUp
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [de]
	inc de
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	jr .writeAdditionalMoveDataLoop
.checkIfTerminator
	ld a, [hli]
	cp $FE ; edited, it was "and a", to avoid bugs with NO_MOVE in the special_moves file
	jr nz, .checkIfTerminator
	jr .loopAdditionalMoveData
.FinishUp

; new, for physical special split
; this overwrites the new moves only

	ld a, [wPersonalizationPhySpeSplit] ; 0=NO, 1=YES
	and a
	jr z, .FinishUp2

	ld a, [wTrainerClass]
	ld b, a
	push bc
	callfar LoadTrainerNumber ; cooler "ld a, [wTrainerNo]"
	ld a, d
	pop bc
	ld c, a
	ld hl, SpecialTrainerMoves_PhysicalSpecialSplit
.loopAdditionalMoveData2
	ld a, [hli]
	cp $ff
	jr z, .FinishUp2
	cp b
	jr nz, .checkIfTerminator2
	ld a, [hli]
	cp c
	jr nz, .checkIfTerminator2
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop2
	ld a, [de]
	inc de
	cp $FE
	jp z, .FinishUp2
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [de]
	inc de
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	jr .writeAdditionalMoveDataLoop2
.checkIfTerminator2
	ld a, [hli]
	cp $FE
	jr nz, .checkIfTerminator2
	jr .loopAdditionalMoveData2

; back to vanilla, end of physical special split
.FinishUp2 ; changed label name

	ret

INCLUDE "data/trainers/special_moves.asm" ; new

INCLUDE "data/trainers/special_moves_physicalspecialsplit.asm" ; new, testing
