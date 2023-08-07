ReadTrainer:

; don't change any moves in a link battle
	ld a, [wLinkState]
	and a
	ret nz

; set [wEnemyPartyCount] to 0, [wEnemyPartySpecies] to FF
; XXX first is total enemy pokemon?
; XXX second is species of first pokemon?
	ld hl, wEnemyPartyCount
	xor a
	ld [hli], a
	dec a
	ld [hl], a

; get the pointer to trainer data for this class
	ld a, [wTrainerClass] ; get trainer class
	dec a
	add a
	ld hl, TrainerDataPointers
	ld c, a
	ld b, 0
	add hl, bc ; hl points to trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wTrainerNo]
	ld b, a
; At this point b contains the trainer number,
; and hl points to the trainer class.
; Our next task is to iterate through the trainers,
; decrementing b each time, until we get to the right one.
.outer
	dec b
	jr z, .IterateTrainer
.inner
	ld a, [hli]
	and a
	jr nz, .inner
	jr .outer

; if the first byte of trainer data is FF,
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
; else the first byte is the level of every pokemon on the team
.IterateTrainer

	; new block of code to handle level scaling
	ld a, [wLevelScaling]
	and a ; faster, lighter cp 0
	jr z, .continueNoLevelScaling ; if not in level scaling mode, jump to normal routine
	push hl ; gotta preserve hl
	call FindMaxLevelPlayersMons ; this should make so that d contains the max level of the player's party
	ld a, d
	ld [wCurEnemyLVL], a
	pop hl ; gotta preserve hl
.continueNoLevelScaling

	ld a, [hli]
	cp $FF ; is the trainer special?
	jr z, .SpecialTrainer ; if so, check for special moves

	; new, prolly suboptimal code, but oh well, it'd just be fitting :D
	ld b, a ; temporarily store a in b
	ld a, [wLevelScaling]
	and a ; = cp a, 0: if z flag, then no level scaling
	jr nz, .LoopTrainerData
	ld a, b ; restore the previous a

	ld [wCurEnemyLVL], a
.LoopTrainerData
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jp z, .AddAdditionalMoveData
	ld [wcf91], a ; write species somewhere (XXX why?)
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .LoopTrainerData
.SpecialTrainer
; if this code is being run:
; - each pokemon has a specific level
;      (as opposed to the whole team being of the same level)
; - if [wLoneAttackNo] != 0, one pokemon on the team has a special move
	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jr z, .AddAdditionalMoveData

	; new, prolly suboptimal code, but oh well, it'd just be fitting :D
	ld b, a ; temporarily store a in b
	ld a, [wLevelScaling]
	and a ; if z flag, then no level scaling
	jr nz, .LoopTrainerData
	ld a, b ; restore the previous a

	ld [wCurEnemyLVL], a
	ld a, [hli]
	ld [wcf91], a
	ld a, ENEMY_PARTY_DATA
	ld [wMonDataLocation], a
	push hl
	call AddPartyMon
	pop hl
	jr .SpecialTrainer
.AddAdditionalMoveData
; does the trainer have additional move data?
	ld a, [wTrainerClass]
	ld b, a
	ld a, [wTrainerNo]
	ld c, a
	ld hl, SpecialTrainerMoves
.loopAdditionalMoveData
	ld a, [hli]
	cp $ff
	jr z, .FinishUp
	cp b
	jr nz, .asm_39c46
	ld a, [hli]
	cp c
	jr nz, .asm_39c46
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop
	ld a, [de]
	inc de
	and a
	jp z, .FinishUp
	dec a
	ld hl, wEnemyMon1Moves
	ld bc, wEnemyMon2 - wEnemyMon1
	call AddNTimes
	ld a, [de]
	inc de
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	jr .writeAdditionalMoveDataLoop
.asm_39c46
	ld a, [hli]
	and a
	jr nz, .asm_39c46
	jr .loopAdditionalMoveData
.FinishUp
; clear wAmountMoneyWon addresses
	xor a
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wCurEnemyLVL]
	ld b, a
.LastLoop
; update wAmountMoneyWon addresses (money to win) based on enemy's level
	ld hl, wTrainerBaseMoney + 1
	ld c, 2 ; wAmountMoneyWon is a 3-byte number
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	dec b
	jr nz, .LastLoop ; repeat wCurEnemyLVL times
	ret

; new, function to handle level scaling
FindMaxLevelPlayersMons:
    ld e, 0 ; which pokemon we're on in the party
    ld hl, wPartyMon1Level
    ld d, 0 ; temp max
.loop
    ld a, [hl]
    cp d ; a-d, c flag set if a<d
    jr c, .levelNotHigherThanTempMaximum
    ld d, a

.levelNotHigherThanTempMaximum
    inc e
    ld a, e
    cp PARTY_LENGTH

    jr z, .done
    ld hl, wPartyMon1Level
    ld bc, wPartyMon2 - wPartyMon1
    call AddNTimes
    jr .loop
.done
    ret
