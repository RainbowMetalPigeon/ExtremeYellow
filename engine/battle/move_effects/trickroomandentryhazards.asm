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
