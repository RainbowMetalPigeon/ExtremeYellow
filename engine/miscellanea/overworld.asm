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

HauntedHouseFakePikachuFaintingAndRandomMessages::
	callfar IsCurrentMapHauntedHouse
	ret nz
; handle random messages
	ld a, [wStepCounter]
	and a
	jr nz, .pikachuCry
	call Random
	cp 25 ; on that one step, 10% chance of random message
	ret nc
	; pick a message at random and display it
	xor a
	ld [wJoyIgnore], a
	call EnableAutoTextBoxDrawing
	ld a, TEXT_RANDOM_MESSAGE_HAUNTED_HOUSE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret
.pikachuCry
	and 127 ; = %01111111, is the counter a multiple of 128?
	ret nz ; do nothing if not
	call Random
	cp 13 ; on that one step, 5% chance of fake Pikachu fainting
	ret nc
	ld e, $3
	callfar PlayPikachuSoundClip
	ret

; ------------------------------

DisplayHauntedHouseRandomMessage::
	call Random
	and 7 ; we are left with a random number between 0 and 7
	ld hl, HauntedHouseRandomMessage_7
	cp 7
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_6
	cp 6
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_5
	cp 5
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_4
	cp 4
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_3
	cp 3
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_2
	cp 2
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_1
	cp 1
	jr z, .printAndEnd
	ld hl, HauntedHouseRandomMessage_0
.printAndEnd
	call PrintText
	ret

HauntedHouseRandomMessage_7:
	text_far _MomWakeUpText
	text_end

HauntedHouseRandomMessage_6:
	text_far _OakAppearsText
	text_end

HauntedHouseRandomMessage_5:
	text_far _Route12TextRivalPostBattle3
	text_end

HauntedHouseRandomMessage_4:
	text_far _GiovanniPreBattleText
	text_end

HauntedHouseRandomMessage_3:
	text_far _GaryText6_RivalUnbelief ; _GiovanniPostDefeatText
	text_end

HauntedHouseRandomMessage_2:
	text_far _Route22RivalDefeatedText2
	text_end

HauntedHouseRandomMessage_1:
	text_far _GaryDefeatedText_BG
	text_end

HauntedHouseRandomMessage_0:
	text_far _GaryText6_RivalSobbing
	text_end

; ===========================================================

; z flag set if we're in a HAUNTED HOUSE map
; nz otherwise
IsCurrentMapHauntedHouse::
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	ret z
	; all other CPs
	ret
	
; ===========================================================

ForceMovementsHauntedHouse::
;	ld a, [wFlags_D733]
;	bit 3, a ; check if a trainer wants a challenge
;	ret nz
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	ret nz
	call ForceRight_HauntedHouse1
	call ForceDown_HauntedHouse1
	call ForceLeft_HauntedHouse1
	call ForceUp_HauntedHouse1
	ret

; ------------------------------

; inputs:
; b = min x, c = max x, d = min y, e = max y
; output:
; c flag = in the rectangle, nc otherwise
CheckIfInRectangle_Copy:
	inc c
	inc e
	ld a, [wXCoord]
	cp b
	jr c, .outsideRectangle ; if X<=b-1
	cp c
	jr nc, .outsideRectangle ; if X>=c+1
	ld a, [wYCoord]
	cp d
	jr c, .outsideRectangle ; if Y<=d-1
	cp e
	jr nc, .outsideRectangle ; if Y>=e+1
;insideRectangle
	scf
	ret
.outsideRectangle
	xor a
	ret

; ------------------------------

ForceRight_HauntedHouse1:
	lb bc, 18, 21
	lb de, 50, 51
	call CheckIfInRectangle_Copy
	ret nc
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_RIGHT
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceDown_HauntedHouse1:
	lb bc, 22, 23
	lb de, 50, 53
	call CheckIfInRectangle_Copy
	ret nc
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_DOWN
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceLeft_HauntedHouse1:
	lb bc, 20, 23
	lb de, 54, 55
	call CheckIfInRectangle_Copy
	ret nc
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_LEFT
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceUp_HauntedHouse1:
	lb bc, 18, 19
	lb de, 52, 55
	call CheckIfInRectangle_Copy
	ret nc
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_UP
	ldh [hJoyHeld], a
	ret

; ===========================================================

WarpIntervals_HauntedHouse1:
	db  1,  6 ; first room
	db  7, 11 ; second room
	db 16, 22 ; wide room
	db $FF

WarpIntervals_HauntedHouse2:
	db $FF

RandomizeWarpsForHauntedHouse::
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	jr z, .loadListForHauntedHouse1
; other checks for other floors
	ret nz
.loadListForHauntedHouse1
	ld hl, WarpIntervals_HauntedHouse1
	jr .checkIfRandomizable ; unnecessary right now
; load the other lists of ranges
.checkIfRandomizable
	ld a, [wDestinationWarpID]
	ld b, a ; b now contains the nominal destination warp ID
	inc b ; this is necessary because warps are indexed 1-forward for humans but 0-forward internally
.loop
	ld a, [hli] ; hl now points to the second extreme of this range, a contains the first
	cp $FF
	ret z
	inc b ; b now contains the (nominal destination warp ID + 1)
	cp b ; a - b = left range - (nominal destination warp ID + 1)
	jr nc, .nope1
	ld a, [hli] ; hl now points to the first extreme of the next range, a contains the second
	cp b ; a - b = right range - (nominal destination warp ID + 1)
	jr c, .loop
; we're in the right interval
	dec hl
	dec hl ; hl points back to the left side of the range
; now we need to generate a random value between left and right range, included
.generateRandomWarpID
	call Random ; a contains the random value
	cp [hl] ; random - left range
	jr c, .generateRandomWarpID
	inc hl
	ld b, [hl] ; b contains the right range
	inc b ; contains the right range + 1
	cp b ; random - (right range + 1)
	dec hl
	jr nc, .generateRandomWarpID
; if we're here, "a" contains a proper value
	dec a ; this is necessary because warps are indexed 1-forward for humans but 0-forward internally
	ld [wDestinationWarpID], a
	ret
.nope1
	inc hl
	jr .loop

; ===========================================================
