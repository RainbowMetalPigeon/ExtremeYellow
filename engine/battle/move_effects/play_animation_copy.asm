PlayCurrentMoveAnimation2Copy::
; animation at MOVENUM will be played unless MOVENUM is 0
; plays wAnimationType 3 or 6
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimation2Copy::
; play animation ID at a and animation type 6 or 3
	ld [wAnimationID], a
; new: zero out the alternative animation
	xor a 
	ld [wAltAnimationID], a
GotAnimationIDCopy:
; BTV
	ldh a, [hWhoseTurn]
	and a
	ld a, $6
	jr z, .storeAnimationType
	ld a, $3
.storeAnimationType
	ld [wAnimationType], a
	jp PlayBattleAnimationGotIDCopy

; new
PlayAlternativeAnimation2Copy:
	ld [wAltAnimationID], a
	jr GotAnimationIDCopy

PlayCurrentMoveAnimationCopy::
; animation at MOVENUM will be played unless MOVENUM is 0
; resets wAnimationType
	xor a
	ld [wAnimationType], a
; new: check for which type of animation to play
	ld a, [wAltAnimationID]
	and a
	jr nz, PlayAlternativeAnimationCopy
; BTV
	ldh a, [hWhoseTurn]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z
; fallthrough

PlayBattleAnimationCopy::
; play animation ID at a and predefined animation type
	ld [wAnimationID], a
; new: zero out the alternative animation
	xor a 
	ld [wAltAnimationID], a
; BTV

PlayBattleAnimationGotIDCopy::
; play animation at wAnimationID
	push hl
	push de
	push bc
	predef MoveAnimation
	callfar Func_78e98
	pop bc
	pop de
	pop hl
	ret

; new
PlayAlternativeAnimationCopy:
	ld [wAltAnimationID], a
	jp PlayBattleAnimationGotID
