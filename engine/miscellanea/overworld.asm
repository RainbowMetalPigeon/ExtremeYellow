CheckIfDirectionalButtonIsPressed::
	jr .vanilla ; countercomment these lines when created HAUNTED_HOUSE
;	ld a, [wCurMap]
;	cp HAUNTED_HOUSE
;	jr nz, .vanilla

; anomalous movements
	ldh a, [hJoyHeld] ; current joypad state
	bit BIT_D_DOWN, a
	jr z, .checkIfUpButtonIsPressedAnomalous
	ld a, -1
	ld [wSpritePlayerStateData1XStepVector], a
	ld a, PLAYER_DIR_LEFT
	jr .handleDirectionButtonPress2

.checkIfUpButtonIsPressedAnomalous
	bit BIT_D_UP, a
	jr z, .checkIfLeftButtonIsPressedAnomalous
	ld a, 1
	ld [wSpritePlayerStateData1XStepVector], a
	ld a, PLAYER_DIR_RIGHT
	jr .handleDirectionButtonPress2

.checkIfLeftButtonIsPressedAnomalous
	bit BIT_D_LEFT, a
	jr z, .checkIfRightButtonIsPressedAnomalous
	ld a, -1
	ld [wSpritePlayerStateData1YStepVector], a
	ld a, PLAYER_DIR_UP
	jr .handleDirectionButtonPress2

.checkIfRightButtonIsPressedAnomalous
	bit BIT_D_RIGHT, a
	ret z
	ld a, 1
	ld [wSpritePlayerStateData1YStepVector], a
	ld a, PLAYER_DIR_DOWN
	jr .handleDirectionButtonPress2

.vanilla ; edited, was .checkIfDownButtonIsPressed
	ldh a, [hJoyHeld] ; current joypad state
	bit BIT_D_DOWN, a
	jr z, .checkIfUpButtonIsPressed
	ld a, 1
	ld [wSpritePlayerStateData1YStepVector], a
	ld a, PLAYER_DIR_DOWN
	jr .handleDirectionButtonPress2

.checkIfUpButtonIsPressed
	bit BIT_D_UP, a
	jr z, .checkIfLeftButtonIsPressed
	ld a, -1
	ld [wSpritePlayerStateData1YStepVector], a
	ld a, PLAYER_DIR_UP
	jr .handleDirectionButtonPress2

.checkIfLeftButtonIsPressed
	bit BIT_D_LEFT, a
	jr z, .checkIfRightButtonIsPressed
	ld a, -1
	ld [wSpritePlayerStateData1XStepVector], a
	ld a, PLAYER_DIR_LEFT
	jr .handleDirectionButtonPress2

.checkIfRightButtonIsPressed
	bit BIT_D_RIGHT, a
	ret z ; edited, was "jr z, .noDirectionButtonsPressed"
	ld a, 1
	ld [wSpritePlayerStateData1XStepVector], a
	ld a, PLAYER_DIR_RIGHT ; edited, was simply 1

.handleDirectionButtonPress2
	ld e, a
	ret
