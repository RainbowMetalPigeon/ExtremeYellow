GrassyTerrainEffect_:

	SetEvent EVENT_TERRAIN_GRASSY
	ResetEvent EVENT_TERRAIN_ELECTRIC
	ResetEvent EVENT_TERRAIN_MISTY
	ResetEvent EVENT_TERRAIN_PSYCHIC

	call TerrainCommonEffect

	callfar PlayCurrentMoveAnimation
	ld hl, TheTerrainTurnedGrassyText
	jp PrintText
	ret

TheTerrainTurnedGrassyText:
	text_far _TheTerrainTurnedGrassyText
	text_end

; --------------------------------------------------------------------------

ElectricTerrainEffect_:

	ResetEvent EVENT_TERRAIN_GRASSY
	SetEvent EVENT_TERRAIN_ELECTRIC
	ResetEvent EVENT_TERRAIN_MISTY
	ResetEvent EVENT_TERRAIN_PSYCHIC

	call TerrainCommonEffect

	callfar PlayCurrentMoveAnimation
	ld hl, TheTerrainTurnedElectricText
	jp PrintText
	ret

TheTerrainTurnedElectricText:
	text_far _TheTerrainTurnedElectricText
	text_end

; --------------------------------------------------------------------------

MistyTerrainEffect_:

	ResetEvent EVENT_TERRAIN_GRASSY
	ResetEvent EVENT_TERRAIN_ELECTRIC
	SetEvent EVENT_TERRAIN_MISTY
	ResetEvent EVENT_TERRAIN_PSYCHIC

	call TerrainCommonEffect

	callfar PlayCurrentMoveAnimation
	ld hl, TheTerrainTurnedMistyText
	jp PrintText
	ret

TheTerrainTurnedMistyText:
	text_far _TheTerrainTurnedMistyText
	text_end

; --------------------------------------------------------------------------

PsychicTerrainEffect_:

	ResetEvent EVENT_TERRAIN_GRASSY
	ResetEvent EVENT_TERRAIN_ELECTRIC
	ResetEvent EVENT_TERRAIN_MISTY
	SetEvent EVENT_TERRAIN_PSYCHIC

	call TerrainCommonEffect

	callfar PlayCurrentMoveAnimation
	ld hl, TheTerrainTurnedPsychicText
	jp PrintText
	ret

TheTerrainTurnedPsychicText:
	text_far _TheTerrainTurnedPsychicText
	text_end

; --------------------------------------------------------------------------

TerrainCommonEffect:
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld a, 5
	jr z, .playersTurn
; opponent's turn
	ld [wTerrainCounterEnemy], a
	xor a
	ld [wTerrainCounterPlayer], a
	ret
.playersTurn
	ld [wTerrainCounterPlayer], a
	xor a
	ld [wTerrainCounterEnemy], a
	ret
