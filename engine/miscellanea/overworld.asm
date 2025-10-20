CheckIfDirectionalButtonIsPressed::
;	jr .vanilla ; countercomment this line when created ready
	CheckEvent EVENT_IN_SEVII
	jr z, .kanto
; in Sevii
	ld a, [wCurMap]
	cp SEVII_FOUR_ISLAND_HAZARD_ROOM
	jr nz, .vanilla
	CheckEvent EVENT_SCRAMBLE_INPUTS
	jr nz, .anomalousMovements
	jr .vanilla
.kanto
	ld a, [wCurMap]
	call IsCurrentMapHauntedHouse_AlsoIsland
	jr nz, .vanilla

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

HauntedHouseHandleRandomGlitchyBehaviours::

; handle fake poison
	call Random
	cp 25 ; 10% chance of fake poison ; TBE
	jr c, .setFakePoison
	ResetEvent EVENT_HAUNTED_HOUSE_FAKE_POISON
	jr .handleLowHealthAlarm
.setFakePoison
	SetEvent EVENT_HAUNTED_HOUSE_FAKE_POISON

.handleLowHealthAlarm
	call Random
	cp 25 ; 10% chance of low-health alarm ; TBE
	jr c, .lowHealthAlarm
	call PlayDefaultMusic
	ld hl, wLowHealthAlarm
	res 7, [hl] ; disable low health alarm
	jr .handleSpinning
.lowHealthAlarm
	call StopAllMusic
	ld hl, wLowHealthAlarm
	set 7, [hl] ; enable low health alarm

.handleSpinning
	call Random
	cp 25 ; 10% chance of moving by spinning ; TBE
	ld hl, wd736 ; bit 7: spinning; bit 6: jumping, but requires much more work
	jr c, .spinning
	res 7, [hl]
	jr .handlePlayerSprite
.spinning
	set 7, [hl]

.handlePlayerSprite
	call Random
	cp 25 ; 10% chance of glitchy sprite ; TBE
	jr c, .setGlitchySprite
	jp LoadWalkingPlayerSpriteGraphics ; needed?
.setGlitchySprite
	jp LoadGlitchyPlayerSpriteGraphics ; LoadTransparentPlayerSpriteGraphics

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

HauntedPalletTownHandlePalettes::
; check if we ran out of palettes
	ld a, [wHauntedPalletTownPaletteCounter]
	cp 15
	ret z
; if we haven't ran out of palettes
	ld a, [wStepCounter]
	and $7 ; is the counter a multiple of 8?
	ret nz
; if the counter is indeed a multiple of 8
	ld a, [wHauntedPalletTownPaletteCounter]
	inc a
	ld [wHauntedPalletTownPaletteCounter], a ; increase the counter, initially 0
	                                         ; and to be reset to 0 when we leave the Haunted House, either by winning or losing vs MISSINGNO
	ld b, SET_PAL_OVERWORLD
	call RunPaletteCommand
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
	call IsCurrentMapHauntedHouse ; no need for it to be a callfar?
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
	cp HAUNTED_HOUSE_2
	ret z
	cp HAUNTED_HOUSE_3
	ret z
	cp HAUNTED_HOUSE_4
	ret

; z flag set if we're in a HAUNTED HOUSE map, including HAUNTED ISLAND OF NUMBERS
; nz otherwise
IsCurrentMapHauntedHouse_AlsoIsland::
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	ret z
	cp HAUNTED_HOUSE_2
	ret z
	cp HAUNTED_HOUSE_3
	ret z
	cp HAUNTED_HOUSE_4
	ret z
	cp HAUNTED_ISLAND_OF_NUMBERS
	ret

; z flag set if we're in a HAUNTED HOUSE map, including HAUNTED ISLAND OF NUMBERS and HAUNTED REDS HOUSE and PALLET TOWN
; nz otherwise
IsCurrentMapHauntedHouse_AlsoIslandAndPallet::
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	ret z
	cp HAUNTED_HOUSE_2
	ret z
	cp HAUNTED_HOUSE_3
	ret z
	cp HAUNTED_HOUSE_4
	ret z
	cp HAUNTED_ISLAND_OF_NUMBERS
	ret z
	cp HAUNTED_REDS_HOUSE
	ret z
	cp HAUNTED_PALLET_TOWN
	ret

; ===========================================================

ForceMovementsHauntedHouse::
	ld a, [wCurMap]
	cp HAUNTED_HOUSE_1
	jr nz, .checkHH4
	call ForceRight_HauntedHouse1
	call ForceDown_HauntedHouse1
	call ForceLeft_HauntedHouse1
	call ForceUp_HauntedHouse1
.checkHH4
	cp HAUNTED_HOUSE_4
	ret nz
	call ForceRight_HauntedHouse4
	call ForceDown_HauntedHouse4
	call ForceLeft_HauntedHouse4
	call ForceUp_HauntedHouse4
	ret

; ------------------------------

; inputs:
; b = min x, c = max x, d = min y, e = max y
; output:
; c flag = in the rectangle, nc otherwise
CheckIfInRectangle_OW:
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
	call CheckIfInRectangle_OW
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
	call CheckIfInRectangle_OW
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
	call CheckIfInRectangle_OW
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
	call CheckIfInRectangle_OW
	ret nc
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_UP
	ldh [hJoyHeld], a
	ret

; ------------------------------ HH 4

ForceRight_HauntedHouse4:
	lb bc,  0,  1
	lb de, 20, 37
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  2,  3
	lb de, 22, 35
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  4, 15
	lb de, 22, 23
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  6, 13
	lb de, 24, 25
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  8, 11
	lb de, 26, 27
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	ret nc

.doThePush
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_RIGHT
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceDown_HauntedHouse4:
	lb bc,  2, 19
	lb de, 18, 19
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  4, 17
	lb de, 20, 21
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc, 16, 17
	lb de, 22, 31
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc, 14, 15
	lb de, 24, 29
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc, 12, 13
	lb de, 26, 29
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	ret nc

.doThePush
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_DOWN
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceLeft_HauntedHouse4:
	lb bc, 20, 21
	lb de, 20, 37
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc, 18, 19
	lb de, 22, 35
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  6, 17
	lb de, 34, 35
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  8, 17
	lb de, 32, 33
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc, 10, 15
	lb de, 30, 31
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	ret nc

.doThePush
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_LEFT
	ldh [hJoyHeld], a
	ret

; ------------------------------

ForceUp_HauntedHouse4:
	lb bc,  2, 19
	lb de, 38, 39
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  4, 17
	lb de, 36, 37
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  4,  5
	lb de, 24, 35
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  6,  7
	lb de, 26, 33
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	jr c, .doThePush

	lb bc,  8,  9
	lb de, 28, 31
	call CheckIfInRectangle_OW ; b = min x, c = max x, d = min y, e = max y
	ret nc

.doThePush
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_UP
	ldh [hJoyHeld], a
	ret

; ===========================================================

WarpIntervals_HauntedHouse1:
	db  1,  5 ; first room
	db  6, 10 ; second room
	db 15, 19 ; wide room
	db $FF

WarpIntervals_HauntedHouse2:
	db  1,  4 ; room 1
	db  5,  8 ; room 2
	db  9, 10 ; room 3
	db 11, 14 ; room 4
	db 15, 18 ; room 5
	db 19, 20 ; room 6
	db 21, 24 ; room 7
	db 25, 26 ; room 8
	db 27, 29 ; room 9
	db 30, 31 ; room 10
	db 32, 33 ; room 11
	db 34, 36 ; room 12
	db $FF

WarpIntervals_HauntedHouse3:
	db 21, 25 ; door madness room
	db $FF

WarpIntervals_HauntedHouse4:
	db 24, 26 ; small dark room
	db $FF

RandomizeWarpsForHauntedHouse::
	call IsCurrentMapHauntedHouse
	ret nz
	ld a, [hWarpDestinationMap]
	cp HAUNTED_HOUSE_1
	jr z, .loadListForHauntedHouse1
	cp HAUNTED_HOUSE_2
	jr z, .loadListForHauntedHouse2
	cp HAUNTED_HOUSE_3
	jr z, .loadListForHauntedHouse3
	cp HAUNTED_HOUSE_4
	jr z, .loadListForHauntedHouse4
	ret nz ; this should never be hit if I do things right

.loadListForHauntedHouse1
	ld hl, WarpIntervals_HauntedHouse1
	jr .checkIfRandomizable
.loadListForHauntedHouse2
	ld hl, WarpIntervals_HauntedHouse2
	jr .checkIfRandomizable
.loadListForHauntedHouse3
	ld hl, WarpIntervals_HauntedHouse3
	jr .checkIfRandomizable
.loadListForHauntedHouse4
	ld hl, WarpIntervals_HauntedHouse4

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
	dec b ; restore b as nominal destination warp ID
	jr nc, .nope1
	ld a, [hli] ; hl now points to the first extreme of the next range, a contains the second
	inc b ; b now contains the (nominal destination warp ID + 1)
	cp b ; a - b = right range - (nominal destination warp ID + 1)
	dec b ; restore b as nominal destination warp ID
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

ForceBikeDown:: ; moved from home/overworld
	ld a, [wFlags_D733]
	bit 3, a ; check if a trainer wants a challenge
	ret nz
	CheckEvent EVENT_IN_SEVII ; new
	ret nz ; new
	ld a, [wCurMap]
	cp ROUTE_17 ; Cycling Road
	ret nz
	ldh a, [hJoyHeld]
	and D_DOWN | D_UP | D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON
	ret nz
	ld a, D_DOWN
	ldh [hJoyHeld], a ; on the cycling road, if there isn't a trainer and the player isn't pressing buttons, simulate a down press
	ret

; ===========================================================

RespawnAllRockSmashableRocks::
	CheckEvent EVENT_IN_SEVII
	jr z, .handleKanto

	ld hl, RockSmashableRocks_Sevii
.showLoopSevii
	ld a, [hli]
	cp $ff ; have we run out of rocks to respawn?
	ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	pop hl
	jr .showLoopSevii
	
.handleKanto

.kantoBase
	ld hl, RockSmashableRocks_KantoBase
.showLoopKantoBase
	ld a, [hli]
	cp $ff ; have we run out of rocks to respawn?
	jr z, .kantoExtra ; ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .showLoopKantoBase
	
.kantoExtra
	ld hl, RockSmashableRocks_KantoExtra
.showLoopKantoExtra
	ld a, [hli]
	cp $ff ; have we run out of rocks to respawn?
	ret z ; if so, we're done here
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	pop hl
	jr .showLoopKantoExtra
	
RockSmashableRocks_Sevii:
; 1-island
	db HS_SEVII_ROUTE_31_ROCK_1
; 2-island
	db HS_SEVII_TWO_ISLAND_CITY_ROCK_1
	db HS_SEVII_ROUTE_33_ROCK_1
	db HS_SEVII_ROUTE_33_ROCK_2
; 3-island
; 4-island
	db HS_SEVII_FOUR_ISLAND_CITY_ROCK_1
	db HS_SEVII_ICEFALL_CAVE_1F_ROCK_1
; 5-island
	db HS_SEVII_FIVE_ISLAND_CITY_ROCK_1
; 6-island
	db HS_SEVII_ROUTE_37_ROCK_1
	db HS_SEVII_ROUTE_38_ROCK_1
	db HS_SEVII_ROUTE_38_ROCK_2
	db HS_SEVII_ROUTE_38_ROCK_3
	db HS_SEVII_ROUTE_38_ROCK_4
	db HS_SEVII_ROUTE_40_ROCK_1
; 7-island
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ROCK_1
	db HS_SEVII_SEVEN_ISLAND_GYM_2_ROCK_2
	db HS_SEVII_ROUTE_43_ROCK_1
	db HS_SEVII_ROUTE_43_ROCK_2
	db $FF

RockSmashableRocks_KantoBase:
	db $FF

RockSmashableRocks_KantoExtra:
	db $FF

; ===========================================================

ForceSlidingOnIce::
	call AreWeOnSlidingIce ; z if we are on ice
	jr z, .weAreOnIce
	ResetEvent EVENT_SLIDING_ON_ICE
	ret

; we're in a cave and we're standing on ice
.weAreOnIce

; stop simulating inputs if there's a barrier in front of us
	call CollisionCheckOnLand ; sets the carry flag if there is a collision, and unsets it if there isn't a collision
	jr nc, .doTheSliding
; we bumped or exit the ice
	ResetEvent EVENT_SLIDING_ON_ICE
	ret

.doTheSliding
	SetEvent EVENT_SLIDING_ON_ICE
	ResetEvent EVENT_PLAYED_COLLISION_SOUND_WHILE_SLIDING_ALREADY_ONCE

; check which direction we're facing, and fake the movement accordingly
	ld a, [wPlayerDirection]
	cp PLAYER_DIR_RIGHT
	jr z, .right
	cp PLAYER_DIR_LEFT
	jr z, .left
	cp PLAYER_DIR_DOWN
	jr z, .down
; up
	ld a, D_UP
	jr .end
.right
	ld a, D_RIGHT
	jr .end
.left
	ld a, D_LEFT
	jr .end
.down
	ld a, D_DOWN
.end
	ldh [hJoyHeld], a
	ret

; inputs: none
; outputs: z flag if we are on sliding ice
AreWeOnSlidingIce::
	ld a, [wCurMapTileset]
	cp CAVERN
	ret nz
; we're in a cave, let's check the tile we're standing on
	lda_coord 8, 9 ; tile the player is on
	ld [wTilePlayerStandingOn], a
	cp $56 ; bottom-left ice tile
	ret

; ===========================================================

DiveCheckSteps::
	ld a, [wWalkBikeSurfState]
	cp 3
	ret nz
; we're diving
	ld a, [wDiveSteps]
	ld b, a
	ld a, [wDiveSteps + 1]
	ld c, a
	or b
	jr z, DiveStepsOver
	dec bc
	ld a, b
	ld [wDiveSteps], a
	ld a, c
	ld [wDiveSteps + 1], a
	ret

DiveStepsOver:
	ld a, TEXT_DIVE_STEPS_OVER
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.postPrinting
    SetEvent EVENT_DIVE_GO_ABOVE
    ld a, $FE ; TBE
    ld [wDestinationWarpID], a ; TBE

	ld a, [wDiveFromWhichMap]
	ld [hWarpDestinationMap], a

	ld a, [wDiveFromWhichX]
	ld [wXCoord], a

	ld a, [wDiveFromWhichY]
	ld [wYCoord], a
	
    jp WarpFound2

PrintDiveStepsOverText::
	xor a
	ld [wJoyIgnore], a
	ld hl, OxygenIsOverText
	jp PrintText

OxygenIsOverText:
	text_far _OxygenIsOverText
	text_end

; ===========================================================

PrintDiveSteps::
	ld a, [wWalkBikeSurfState]
	cp 3
	ret nz
; we're diving
	hlcoord 0, 0
	lb bc, 2, 7 ; height, width
	call TextBoxBorder
	hlcoord 1, 2
	ld de, wDiveSteps
	lb bc, 2, 3
	call PrintNumber
	hlcoord 1, 1
	ld de, OxygenTitle
	call PlaceString
	hlcoord 4, 2
	ld de, DiveSteps
	jp PlaceString

OxygenTitle: ; new
	db "OXYGEN:@"

DiveSteps: ; new
	db "/200@"

; ===========================================================

LoadFontTilePatternsBraille:: ; new
	ldh a, [rLCDC]
	bit 7, a ; is the LCD enabled?
	jr nz, .on
.off
	ld hl, FontGraphicsBraille
	ld de, vFont
	ld bc, FontGraphicsBrailleEnd - FontGraphicsBraille
	ld a, BANK(FontGraphics)
	jp FarCopyDataDouble ; if LCD is off, transfer all at once
.on
	ld de, FontGraphicsBraille
	ld hl, vFont
	lb bc, BANK(FontGraphicsBraille), (FontGraphicsBrailleEnd - FontGraphicsBraille) / $8
	jp CopyVideoDataDouble ; if LCD is on, transfer during V-blank
