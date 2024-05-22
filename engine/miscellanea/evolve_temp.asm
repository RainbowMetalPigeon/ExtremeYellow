; from Porygondolier

EvolveTemp_:
	ld de, wBattleMonSpecies
	ld hl, wPartyMon1;start of party data
	ld bc, wPartyMon2 - wPartyMon1;gap between each party mon data into bc
	ld a, [wPlayerMonNumber]
	call AddNTimes; add bc to hl a times
	;hl is now the start of the data for the mon to transform into (evolved form of BattleMon)

;copy species and HP
	ld bc, $3;1 byte for Species, 2 bytes for HP
	call CopyData; Copy bc bytes from hl to de.

;move pointers to type
	inc hl
	inc hl
	inc de
	inc de

;copy types
	ld bc, $2;two bytes for types
	call CopyData; Copy bc bytes from hl to de.

;align pointers for stats and HP
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	inc hl
	inc hl
	inc hl
	inc hl
	inc hl

	inc hl
	inc hl

	inc de
	inc de
	inc de

	inc de
	inc de
	inc de
	inc de
	inc de

;copy stats
	ld bc, 10
	call CopyData; Copy bc bytes from hl to de.

;other stuff

	ld a, [wBattleMonSpecies]
	ld [wd0b5], a
	ld [wcf91], a;quite possibly unnecessary
	ld [wBattleMonSpecies2], a;this MUST be set for GetMonHeader to function properly
	ret
