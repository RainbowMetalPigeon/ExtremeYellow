LearnMove:
	call SaveScreenTilesToBuffer1
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicks
	call GetPartyMonName
	ld hl, wcd6d
	ld de, wLearnMoveMonName
	ld bc, NAME_LENGTH
	call CopyData

DontAbandonLearning:
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2Moves - wPartyMon1Moves
	ld a, [wWhichPokemon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
.findEmptyMoveSlotLoop
	ld a, [hl]
	and a
	jr z, .next
	inc hl
	dec b
	jr nz, .findEmptyMoveSlotLoop
	push de
	call TryingToLearn
	pop de
	jp c, AbandonLearning
	push hl
	push de
	ld [wd11e], a
	call GetMoveName
	ld hl, OneTwoAndText
	call PrintText
	pop de
	pop hl
.next
	ld a, [wMoveNum]
	ld [hl], a
	ld bc, wPartyMon1PP - wPartyMon1Moves
	add hl, bc
	push hl
	push de
	dec a
	ld c, a ; new
	ld de, wBuffer
	callfar MoveInfoCopier ; new
	ld a, [wBuffer + 5] ; a = move's max PP
	pop de
	pop hl
	ld [hl], a
	ld a, [wIsInBattle]
	and a
	jp z, PrintLearnedMove
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wPlayerMonNumber]
	cp b
	jp nz, PrintLearnedMove
	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyData
	ld bc, wPartyMon1PP - wPartyMon1OTID
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyData
	jp PrintLearnedMove

AbandonLearning:
	ld hl, AbandonLearningText
	call PrintText
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
	ld a, [wCurrentMenuItem]
	and a
	jp nz, DontAbandonLearning
	ld hl, DidNotLearnText
	call PrintText
	ld b, 0
	ret

PrintLearnedMove:
	ld a, [wUniQuizAnswer]  ; new, testing
	ld [wd11e], a           ; new, testing
	call GetMoveName        ; new, testing
	call CopyToStringBuffer ; new, testing
	ld hl, LearnedMove1Text
	call PrintText
	ld b, 1
	ret

TryingToLearn:
	push hl
; print dialogue box
	ld hl, TryingToLearnText
	call PrintText
; place Yes No menu
	hlcoord 14, 7
	lb bc, 8, 15
	ld a, TWO_OPTION_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID ; yes/no menu
; retrieve hl
	pop hl
; check decision
	ld a, [wCurrentMenuItem]
	rra
	ret c
; we decided to learn the new move
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wMoves
	ld bc, NUM_MOVES
	call CopyData
	callfar FormatMovesString
	pop hl
.loop
	push hl
; print dialogue text
	ld hl, WhichMoveToForgetText
	call PrintText
; print box with the 4 moves
	hlcoord 4, 8 ; 4, 7
	lb bc, 4, 14
	call TextBoxBorder
; print the 4 moves
	hlcoord 6, 9 ; 6, 8
	ld de, wMovesString
	ldh a, [hUILayoutFlags]
	set 2, a
	ldh [hUILayoutFlags], a
	call PlaceString
; new, old-move info boxes borders
	hlcoord 10, 0 ; 0, 3
	lb bc, 3, 8
	call TextBoxBorder ; draws a c×b text box at hl
; new, new-move info boxes borders
	hlcoord 10, 4 ; 10, 3
	lb bc, 3, 8
	call TextBoxBorder ; draws a c×b text box at hl
; print info for new move
	call PrintInfoNewMove
; do things about the arrow?
	ldh a, [hUILayoutFlags]
	res 2, a
	ldh [hUILayoutFlags], a
	ld hl, wTopMenuItemY
	ld a, 9 ; 8
	ld [hli], a ; wTopMenuItemY
	ld a, 5
	ld [hli], a ; wTopMenuItemX
	xor a
	ld [hli], a ; wCurrentMenuItem
	inc hl
; do things, including new declaring which buttons to watch (new, and also new is watching over START)
	ld a, [wNumMovesMinusOne]
	ld [hli], a ; wMaxMenuItem
	ld a, A_BUTTON | B_BUTTON | D_DOWN | D_UP | START
	ld [hli], a ; wMenuWatchedKeys
	ld [hl], 0 ; wLastMenuItem
; printing old move info
	call PrintInfoCurrentMove
.inputLoop
	ld hl, hUILayoutFlags
	set 1, [hl]
	call HandleMenuInput
	ld hl, hUILayoutFlags
	res 1, [hl]
; checking which button has been pressed
	bit BIT_A_BUTTON, a
	jr nz, .doTheThings
	bit BIT_B_BUTTON, a
	jr nz, .doTheThings
	bit BIT_START, a
	jr nz, ShowDetailedInfoNewMove ; testing
; not A or B or START, so is UP or DOWN
	push af
	bit BIT_D_DOWN, a
	jr nz, .updateBox
	bit BIT_D_UP, a
	jr nz, .updateBox
	pop af
	jr .inputLoop
.updateBox
	call PrintInfoCurrentMove
	pop af
	jr .inputLoop
.doTheThings
; vanilla
	push af
	call LoadScreenTilesFromBuffer1
	pop af
	pop hl
	bit BIT_B_BUTTON, a
	jr nz, .cancel
	push hl
	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl] ; move ID
	push af
	push bc
	call IsMoveHM
	pop bc
	pop de
	ld a, d
	jr c, .hm
	pop hl
	add hl, bc
	and a
	ret
.hm
	ld hl, HMCantDeleteText
	call PrintText
	pop hl
	jp .loop
.cancel
	scf
	ret

ShowDetailedInfoNewMove: ; new
	ld a, [wMoveNum]
	ld [wd11e], a
; check if we're learning the move in battle or in the party menu
	ld a, [wIsInBattle]
	and a
	jr nz, .inBattle
; in the party menu
	call SaveScreenTilesToBuffer2
	call HideSprites
	callfar ShowAttackdexData
	call LoadScreenTilesFromBuffer2
	call LoadHpBarAndStatusTilePatterns
;	ld b, SET_PAL_PARTY_MENU
;	call RunPaletteCommand
	callfar SetPartyMenuHPBarColor
;	call GBPalNormal
	jp TryingToLearn.inputLoop
.inBattle
	call SaveScreenTilesToBuffer2
	callfar ShowAttackdexData
	ld a, [wBattleMonSpecies]
	ld [wd0b5], a
	call GetMonHeader
	predef LoadMonBackPic
	call LoadScreenTilesFromBuffer2
	callfar LoadHudAndHpBarAndStatusTilePatterns
	jp TryingToLearn.inputLoop

LearnedMove1Text:
	text_far _LearnedMove1Text
	sound_get_item_1 ; plays SFX_GET_ITEM_1 in the party menu (rare candy) and plays SFX_LEVEL_UP in battle
	text_promptbutton
	text_end

WhichMoveToForgetText:
	text_far _WhichMoveToForgetText
	text_end

AbandonLearningText:
	text_far _AbandonLearningText
	text_end

DidNotLearnText:
	text_far _DidNotLearnText
	text_end

TryingToLearnText:
	text_far _TryingToLearnText
	text_end

OneTwoAndText:
; bugfix: In Red/Blue, the SFX_SWAP sound was played in the wrong bank, which played an incorrect sound
; Yellow has fixed this by swapping to the correct bank
	text_far _OneTwoAndText
	text_pause
	text_asm
	push af
	push bc
	push de
	push hl
	ld a, $1
	ld [wMuteAudioAndPauseMusic], a
	call DelayFrame
	ld a, [wAudioROMBank]
	push af
	ld a, BANK(SFX_Swap_1)
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	call WaitForSoundToFinish
	ld a, SFX_SWAP
	call PlaySound
	call WaitForSoundToFinish
	pop af
	ld [wAudioROMBank], a
	ld [wAudioSavedROMBank], a
	xor a
	ld [wMuteAudioAndPauseMusic], a
	pop hl
	pop de
	pop bc
	pop af
	ld hl, PoofText
	ret

PoofText:
	text_far _PoofText
	text_pause
ForgotAndText:
	text_far _ForgotAndText
	text_end

HMCantDeleteText:
	text_far _HMCantDeleteText
	text_end

; ==============================================================================

PrintInfoCurrentMove: ; new
	push hl
	push bc
	push de
	push af

	xor a
	ldh [hAutoBGTransferEnabled], a

; clear screen area of the old move before printing its info
	hlcoord 11, 1 ; 1, 4
	lb bc, 3, 8
	call ClearScreenArea

	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	ld a, [wWhichPokemon]
	call AddNTimes ; adds bc to hl a times ; hl points to the moves

	ld a, [wCurrentMenuItem]
	ld c, a
	ld b, $0 ; which move in the menu is the cursor pointing to? (0-3)
	add hl, bc ; points to the move in memory
	ld a, [hl] ; a should be holding the move ID
	dec a

	ld c, a ; new
	ld de, wPlayerMoveNum
	callfar MoveInfoCopier ; new

	hlcoord 11, 3 ; 1, 6
	ld de, PPText2
	call PlaceString

	hlcoord 18, 2 ; 8, 5
	ld [hl], "%"

	hlcoord 13, 2 ; 3, 5
	ld a, [wPlayerMoveEffect]
	cp OHKO_EFFECT
	jr z, .OHKOMove
	ld a, [wPlayerMovePower]
	cp 1 ; this should cover all the SPECIAL_DAMAGE_EFFECT, AND COUNTER / MIRROR_COAT / GYRO_BALL
	jr z, .specialDamage
	hlcoord 11, 2 ; 1, 5
	ld de, wPlayerMovePower
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de
	jr .afterDamagePrinting
.OHKOMove
	ld [hl], "INFINITE"
	jr .afterDamagePrinting
.specialDamage
	ld [hl], "?"
.afterDamagePrinting

	hlcoord 15, 2 ; 5, 5
	xor a
	ld b, a
	ld a, [wPlayerMoveAccuracy]
.loopAccuracy
	sub 12
	jr c, .accuracyFound
	ld c, a
	ld a, b
	add 5
	ld b, a
	ld a, c
	jr .loopAccuracy
.accuracyFound
	ld a, b
	cp 76 ; fine-tuned number because
	jr c, .noSub5
	sub 5
.noSub5
	ld [wPlayerMoveAccuracyPercent], a
	ld de, wPlayerMoveAccuracyPercent
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de

	hlcoord 17, 3 ; 7, 6
	ld de, wPlayerMoveMaxPP ; wMaxPP
	lb bc, 1, 2
	call PrintNumber

;	callfar GetCurrentMove
	hlcoord 11, 1 ; 1, 4
	predef PrintMoveType

	ld a, $1
	ldh [hAutoBGTransferEnabled], a

	pop af
	pop de
	pop bc
	pop hl

	jp Delay3

PPText2:
	db "PP:@"

; ==============================================================================

PrintInfoNewMove: ; new
	push hl
	push bc
	push de
	push af

	xor a
	ldh [hAutoBGTransferEnabled], a

	ld de, wPlayerMoveNum
	ld a, [wMoveNum]
	dec a
	ld c, a ; new
	callfar MoveInfoCopier ; new

	hlcoord 11, 7 ; 11, 6
	ld de, PPText2
	call PlaceString

	hlcoord 18, 6 ; 18, 5
	ld [hl], "%"

	hlcoord 13, 6 ; 13, 5
	ld a, [wPlayerMoveEffect]
	cp OHKO_EFFECT
	jr z, .OHKOMove
	ld a, [wPlayerMovePower]
	cp 1 ; this should cover all the SPECIAL_DAMAGE_EFFECT, AND COUNTER / MIRROR_COAT / GYRO_BALL
	jr z, .specialDamage
	hlcoord 11, 6 ; 11, 5
	ld de, wPlayerMovePower
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de
	jr .afterDamagePrinting
.OHKOMove
	ld [hl], "INFINITE"
	jr .afterDamagePrinting
.specialDamage
	ld [hl], "?"
.afterDamagePrinting

	hlcoord 15, 6 ; 15, 5
	xor a
	ld b, a
	ld a, [wPlayerMoveAccuracy]
.loopAccuracy
	sub 12
	jr c, .accuracyFound
	ld c, a
	ld a, b
	add 5
	ld b, a
	ld a, c
	jr .loopAccuracy
.accuracyFound
	ld a, b
	cp 76 ; fine-tuned number because
	jr c, .noSub5
	sub 5
.noSub5
	ld [wPlayerMoveAccuracyPercent], a
	ld de, wPlayerMoveAccuracyPercent
	lb bc, 1, 3
	call PrintNumber ; prints the c-digit, b-byte value at de

	hlcoord 17, 7 ; 17, 6
	ld de, wPlayerMoveMaxPP ; wMaxPP
	lb bc, 1, 2
	call PrintNumber

;	callfar GetCurrentMove
	hlcoord 11, 5 ; 11, 4
	predef PrintMoveType

	ld a, $1
	ldh [hAutoBGTransferEnabled], a

	pop af
	pop de
	pop bc
	pop hl

	jp Delay3
