CheckIfDirectionalButtonIsPressed::
	jr .vanilla ; countercomment this line when created ready
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	jr z, .anomalousMovements
	jr nz, .vanilla ; redundant for now

.anomalousMovements
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

; ===========================================================

HauntedHouseFakeOutOfBattlePoisonDamage::
	CheckEvent EVENT_HAUNTED_HOUSE_FAKE_POISON
	ret z
	ld a, [wStepCounter]
	and $3 ; is the counter a multiple of 4?
	ret nz
	predef ChangeBGPalColor0_4Frames ; change BG white to dark grey for 4 frames
	ld a, SFX_POISONED
	call PlaySound
	ret

; ===========================================================

; % 0000 0000 =   0
; % 0000 0001 =   1
; % 0000 0011 =   3
; % 0000 0111 =   7
; % 0000 1111 =  15
; % 0001 1111 =  31
; % 0011 1111 =  63
; % 0111 1111 = 127
; % 1111 1111 = 255

HauntedHouseFakePikachuFainting::
	ld a, [wStepCounter]
	and 63 ; = %00111111, is the counter a multiple of 64?
	ret nz ; do nothing if not
	call Random
	cp 64 ; on that one step, 25% chance of fake Pikachu fainting
	ret nc
	ld e, $3
	callfar PlayPikachuSoundClip
	ret
