TrickRoomEffect_::
	CheckEvent EVENT_TRICK_ROOM
	jr nz, .removeTrickRoom

	SetEvent EVENT_TRICK_ROOM
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld a, 5
	jr z, .playersTurn
; opponent's turn
	ld [wTrickRoomCounterEnemy], a
	xor a
	ld [wTrickRoomCounterPlayer], a
	jr .conclude
.playersTurn
	ld [wTrickRoomCounterPlayer], a
	xor a
	ld [wTrickRoomCounterEnemy], a
.conclude
	callfar PlayCurrentMoveAnimation
	ld hl, TrickRoomGotSetText
	jp PrintText
	ret

.removeTrickRoom
	ResetEvent EVENT_TRICK_ROOM
	xor a
	ld [wTrickRoomCounterPlayer], a
	ld [wTrickRoomCounterEnemy], a
	callfar PlayCurrentMoveAnimation
	ld hl, TrickRoomGotRemovedText
	jp PrintText
	ret

TrickRoomGotSetText:
	text_far _TrickRoomGotSetText
	text_end

TrickRoomGotRemovedText:
	text_far _TrickRoomGotRemovedText
	text_end

; --------------------------------------------------------------------------

SpikesEffect_::
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld hl, wHazardsSpikesEnemySide
	jr z, .playersTurn
; opponent's turn
	ld hl, wHazardsSpikesPlayerSide
.playersTurn
	ld a, [hl]
	cp 3
	jr nc, .cantStackMoreLayers
; increase the number of layers
	inc a
	ld [hl], a
	callfar PlayCurrentMoveAnimation
	ld hl, SpikesScatteredOnFieldText
	jp PrintText
.cantStackMoreLayers
	ld c, 30
	call DelayFrames
	ld hl, CannotAddMoreOfThisText
	jp PrintText

SpikesScatteredOnFieldText:
	text_far _SpikesScatteredOnFieldText
	text_end

CannotAddMoreOfThisText:
	text_far _CannotAddMoreOfThisText
	text_end

; --------------------------------------------------------------------------

ToxicSpikesEffect_::
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld hl, wHazardsToxicSpikesEnemySide
	jr z, .playersTurn
; opponent's turn
	ld hl, wHazardsToxicSpikesPlayerSide
.playersTurn
	ld a, [hl]
	cp 2
	jr nc, .cantStackMoreLayers
; increase the number of layers
	inc a
	ld [hl], a
	callfar PlayCurrentMoveAnimation
	ld hl, ToxicSpikesScatteredOnFieldText
	jp PrintText
.cantStackMoreLayers
	ld c, 30
	call DelayFrames
	ld hl, CannotAddMoreOfThisText
	jp PrintText

ToxicSpikesScatteredOnFieldText:
	text_far _ToxicSpikesScatteredOnFieldText
	text_end

; --------------------------------------------------------------------------

StickyWebEffect_::
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld hl, wHazardsStickyWebEnemySide
	jr z, .playersTurn
; opponent's turn
	ld hl, wHazardsStickyWebPlayerSide
.playersTurn
	ld a, [hl]
	and a
	jr nz, .cantStackMoreLayers
; add the one layer
	inc a
	ld [hl], a
	callfar PlayCurrentMoveAnimation
	ld hl, StickyWebOnFieldText
	jp PrintText
.cantStackMoreLayers
	ld c, 30
	call DelayFrames
	ld hl, CannotAddMoreOfThisText
	jp PrintText

StickyWebOnFieldText:
	text_far _StickyWebOnFieldText
	text_end

; --------------------------------------------------------------------------

StealthRockEffect_::
	ldh a, [hWhoseTurn] ; 0 on player's turn, 1 on enemy's turn
	and a
	ld hl, wHazardsStealthRockEnemySide
	jr z, .playersTurn
; opponent's turn
	ld hl, wHazardsStealthRockPlayerSide
.playersTurn
	ld a, [hl]
	and a
	jr nz, .cantStackMoreLayers
; add the one layer
	inc a
	ld [hl], a
	callfar PlayCurrentMoveAnimation
	ld hl, FloatingRocksOnFieldText
	jp PrintText
.cantStackMoreLayers
	ld c, 30
	call DelayFrames
	ld hl, CannotAddMoreOfThisText
	jp PrintText

FloatingRocksOnFieldText:
	text_far _FloatingRocksOnFieldText
	text_end
