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
; new, to set up Inverse Battles more nicely
	cp COOLTRAINER
	jr nz, .continueLoadTrainer
	ld a, 1
	ld [wInverseBattle], a
	ld a, [wTrainerClass] ; get trainer class
.continueLoadTrainer
; back to vanilla
	dec a
	add a
	ld hl, TrainerDataPointers
	ld c, a
	ld b, 0
	add hl, bc ; hl points to trainer class
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call LoadTrainerNumber ; edited, was simply "ld a, [wTrainerNo]"
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
	jr z, .afterHandlingLevelScaling ; if not in level scaling mode, jump to normal routine
	cp 1 ; EXACT level scaling
	jr z, .lvlScalingExact
	cp 2 ; FLUCT level scaling
	jr z, .lvlScalingExact ; first step is to get the same base level as the EXACT case, the FLUCTuating part comes later
	cp 3 ; HARD level scaling
	jr z, .lvlScalingHardcore
;	cp 4 ; IMPOS level scaling; commented because redundant, [wLevelScaling] shouldn't have any value outisde of [0,4]; if keep, line below needs a jr z, .label
	jr .lvlScalingImpossible
.lvlScalingExact
	push hl ; gotta preserve hl
	call FindMaxLevelPlayersMons ; this should make so that d contains the max level of the player's party
	pop hl ; gotta preserve hl
	ld a, d
	ld [wCurEnemyLVL], a
	jr .afterHandlingLevelScaling
.lvlScalingHardcore
	push hl ; gotta preserve hl
	call FindMaxLevelPlayersMons ; this should make so that d contains the max level of the player's party
	pop hl ; gotta preserve hl
	ld a, d
	ldh [hDividend], a
	ld a, 10 ; 1/10th increase of level
	ldh [hDivisor], a
	ld b, $01 ; number of bytes in the dividend
	call Divide
	ldh a, [hQuotient + 3]
	add d ; add to a the original max level of player's team
	cp 100
	jr nc, .lvlScalingImpossible ; if level 100 or higher, just load 100
	ld [wCurEnemyLVL], a
	jr .afterHandlingLevelScaling
.lvlScalingImpossible
	ld a, 100
	ld [wCurEnemyLVL], a
.afterHandlingLevelScaling

	ld a, [hli]
	cp $FF ; is the trainer special?
	jr z, .SpecialTrainer ; if so, check for special moves

; new, prolly suboptimal code for level scaling
	ld b, a ; temporarily store a in b, contains vanilla hard-coded level
	ld a, [wLevelScaling]
	and a ; = cp a, 0: if z flag, then no level scaling
	jr nz, .LoopTrainerData
	ld a, b ; restore the previous a, which in vanilla code contains the hard-coded levels of the opp's mons

; new code for badge scaling
	call OmniDetermineGymTrainersLevelsWrapped ; new level in a, if it's modified at all

	ld [wCurEnemyLVL], a
.LoopTrainerData
; new code to handle FLUCT level scaling, which needs to be run mon per mon, rather than once per trainer
	ld a, [wLevelScaling]
	cp 2 ; is it FLUCT?
	jr nz, .notFluctuatingLevelScaling ; if not, continue
.loopRandom
	call Random ; now a contains a random number in [0,255]
	and 7 ; now the random number is in [0,7]
	cp 5
	jr nc, .loopRandom ; but we want the random number to be in [0,4], so we cp to 5 and if there's no carry (i.e. a>=5) we call the RNG again
	add d ; now a contains [0,4]+maxLevelPlayersMons, because d still contains maxLevelPlayersMons
	; before subtracting 2 and obtain the final result, we need to check that a is currently in [3,102], so that the final level is in [1,100]
	; currently a should possibly be only in [1,104], if the starting level was in the non-glitchy range [1,100]
	cp 103
	jr c, .notTooHigh
	ld a, 100 ; if a is 103 or 104, let's cap the level at 100 and go back to vanilla code
	ld [wCurEnemyLVL], a
	jr .notFluctuatingLevelScaling
.notTooHigh
	cp 3
	jr nc, .notTooLow
	ld a, 1 ; if a is 1 or 2, let's cap the level at 1 and go back to vanilla code
	ld [wCurEnemyLVL], a
	jr .notFluctuatingLevelScaling
.notTooLow
	sub 2 ; after all the checks, we can now safely remove the offset and bring [3,102] to [1,100]
	ld [wCurEnemyLVL], a
.notFluctuatingLevelScaling
; back to vanilla code

	ld a, [hli]
	and a ; have we reached the end of the trainer data?
	jp z, .AddAdditionalMoveData
	ld [wcf91], a ; write species somewhere (XXX why?) -> for AddPartyMon
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
	jr nz, .specialTrainerContinue
	ld a, b ; restore the previous a, which in vanilla code contains the hard-coded levels of the opp's mons

	ld [wCurEnemyLVL], a
.specialTrainerContinue ; new
	; new code to handle FLUCT level scaling, which needs to be run mon per mon, rather than once per trainer
	ld a, [wLevelScaling]
	cp 2 ; is it FLUCT?
	jr nz, .notFluctuatingLevelScaling2 ; if not, continue
;	ld a, [wCurEnemyLVL]
;	ld d, a ; now d contains the level of max mon of the player's team
.loopRandom2
	call Random ; now a contains a random number in [0,255]
	and 7 ; now the random number is in [0,7]
	cp 5
	jr nc, .loopRandom2 ; but we want the random number to be in [0,4], so we cp to 5 and if there's no carry (i.e. a>=5) we call the RNG again
	add d ; now a contains [0,4]+maxLevelPlayersMons, because d still contains maxLevelPlayersMons
	; before subtracting 2 and obtain the final result, we need to check that a is currently in [3,102], so that the final level is in [1,100]
	; currently a should possibly be only in [1,104], if the starting level was in the non-glitchy range [1,100]
	cp 103
	jr c, .notTooHigh2
	ld a, 100 ; if a is 103 or 104, let's cap the level at 100 and go back to vanilla code
	ld [wCurEnemyLVL], a
	jr .notFluctuatingLevelScaling2
.notTooHigh2
	cp 3
	jr nc, .notTooLow2
	ld a, 1 ; if a is 1 or 2, let's cap the level at 1 and go back to vanilla code
	ld [wCurEnemyLVL], a
	jr .notFluctuatingLevelScaling2
.notTooLow2
	sub 2 ; after all the checks, we can now safely remove the offset and bring [3,102] to [1,100]
	ld [wCurEnemyLVL], a
.notFluctuatingLevelScaling2
	; back to vanilla code

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
; new, to handle randomization of trainers' teams
	ld a, [wRandomizationTrainersTeams] ; 0=NO, 1=YES
	and a
	jr nz, .FinishUp
; back to vanilla
	ld a, [wTrainerClass]
	ld b, a
	call LoadTrainerNumber ; edited, was simply "ld a, [wTrainerNo]"
	ld c, a
	ld hl, SpecialTrainerMoves
.loopAdditionalMoveData
	ld a, [hli]
	cp $ff
	jr z, .FinishUp
	cp b
	jr nz, .checkIfTerminator
	ld a, [hli]
	cp c
	jr nz, .checkIfTerminator
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop
	ld a, [de]
	inc de
	cp $FE ; edited, it was "and a", to avoid bugs with NO_MOVE in the special_moves file
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
.checkIfTerminator
	ld a, [hli]
	cp $FE ; edited, it was "and a", to avoid bugs with NO_MOVE in the special_moves file
	jr nz, .checkIfTerminator
	jr .loopAdditionalMoveData
.FinishUp

; new, for physical special split
; this overwrites the new moves only

	ld a, [wPersonalizationPhySpeSplit] ; 0=NO, 1=YES
	and a
	jr z, .FinishUp2

	ld a, [wTrainerClass]
	ld b, a
	call LoadTrainerNumber ; cooler "ld a, [wTrainerNo]"
	ld c, a
	ld hl, SpecialTrainerMoves_PhysicalSpecialSplit
.loopAdditionalMoveData2
	ld a, [hli]
	cp $ff
	jr z, .FinishUp2
	cp b
	jr nz, .checkIfTerminator2
	ld a, [hli]
	cp c
	jr nz, .checkIfTerminator2
	ld d, h
	ld e, l
.writeAdditionalMoveDataLoop2
	ld a, [de]
	inc de
	cp $FE
	jp z, .FinishUp2
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
	jr .writeAdditionalMoveDataLoop2
.checkIfTerminator2
	ld a, [hli]
	cp $FE
	jr nz, .checkIfTerminator2
	jr .loopAdditionalMoveData2

; back to vanilla, end of physical special split
.FinishUp2 ; changed label name
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
	ld c, 3 ; wAmountMoneyWon is a 3-byte number ; edited, there was a 2 instead of a 3
	push bc
	predef AddBCDPredef
	pop bc
	inc de
	inc de
	inc de ; new, for bigger money
	dec b
	jr nz, .LastLoop ; repeat wCurEnemyLVL times
	ret

; new ==========================================================================

; function to handle level scaling
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

ReadTrainer_CopyPlayersTeam::
	ld hl, wPartyCount
	ld de, wEnemyPartyCount
	ld bc, wPartyMon6Nick - wPartyCount
	call CopyData ; copies bc bytes from hl to de
; all stuff about money, copied from the main function
	xor a
	ld de, wAmountMoneyWon
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Level
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes ; add bc to hl a times
	ld a, [hl]
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

CountHowManyBadgesWrapped: ; a contains the # badges
	push hl
	push bc
	push de
	callfar CountHowManyBadges ; d=#badges
	ld a, d
	pop de
	pop bc
	pop hl
	ret

CheckIfWeAreInAGym: ; z flag if we are, nz otherwise
	CheckEvent EVENT_IN_SEVII
	ret nz ; no gyms in Sevii
	ld a, [wCurMap]
	cp PEWTER_GYM
	ret z
	cp CERULEAN_GYM
	ret z
	cp VERMILION_GYM
	ret z
	cp CELADON_GYM
	ret z
	cp OCHRE_GYM
	ret z
	cp FUCHSIA_GYM
	ret z
	cp SAFFRON_GYM
	ret z
	cp CINNABAR_GYM
	ret ; except Viridian, because Giovanni's gym doesn't scale

DetermineGymTrainersLevels: ; returns in a the level of basic gym trainers
	call CountHowManyBadgesWrapped
	cp 0
	jr z, .badges0
	cp 1
	jr z, .badges1
	cp 2
	jr z, .badges2
	cp 3
	jr z, .badges3
	cp 4
	jr z, .badges4
	cp 5
	jr z, .badges5
	cp 6
	jr z, .badges6
;.badges7
	ld a, 52
	ret
.badges6
	ld a, 51
	ret
.badges5
	ld a, 47
	ret
.badges4
	ld a, 40
	ret
.badges3
	ld a, 29
	ret
.badges2
	ld a, 25
	ret
.badges1
	ld a, 18
	ret
.badges0
	ld a, 8
	ret

CheckIfOpponentIsAGymLeader: ; z flag if they are
	ld a, [wTrainerClass]
	cp BROCK
	ret z
	cp MISTY
	ret z
	cp LT_SURGE
	ret z
	cp ERIKA
	ret z
	cp ORAGE
	ret z
	cp KOGA
	ret z
	cp SABRINA
	ret z
	cp BLAINE
	ret

; is called if we are not doing level-scaling
; input: b and a hold the hard-coded levels
; output: b and a hold the level, badge-scaled if we are in a gym
OmniDetermineGymTrainersLevelsWrapped:
	push af
	call CheckIfWeAreInAGym ; z flag if we are in a gym, except Viridian's, which doesn't scale
	jr nz, .popAndConclude
	call CheckIfOpponentIsAGymLeader ; z flag if they are, and they scale differently
	jr z, .popAndConclude
; if we are here: we are in a gym, but not vs the leader
	pop af ; we need to pop af, but we don't need the value, so here is fine
	call DetermineGymTrainersLevels ; returns the level of basic trainers in a, needs +1 for COOLTRAINER
	ld b, a ; save level in b
	ld a, [wTrainerClass]
	cp COOLTRAINER
	ld a, b ; retrieve level from b
	ret nz
	inc a ; if a cool trainer, +1 to the levels
	ret
.popAndConclude
	pop af
	ret

LoadTrainerNumber: ; simply loads [wTrainerNo] in a for normal trainers, and adds the #badges for COOLTRAINERs
	call CheckIfWeAreInAGym ; z if we're
	jr nz, .normalLoading
; we're in a gym, are we facing a cool trainer?
	ld a, [wTrainerClass]
	cp COOLTRAINER
	jr nz, .normalLoading
; we're facing a cool trainer; are they the right hands of the leader?
	ld a, [wTrainerNo]
	cp 58 ; first non-right-hand of the gym leader: trainerNo-58 is <0, so c flag, for all the right hands, and is >=0, so nc, for all the others
	jr nc, .normalLoading
; we're facing a right hand of a gym leader
	call CountHowManyBadgesWrapped ; a contains the # badges
	push bc ; why?
	cp 8 ; do we have 8 badges already? So we're rematching the cooltrainers in the gyms?
	ld b, 7 ; let's load the last team
	jr z, .indeed8Badges
; if not 8 badges, let's load a=#badges in b rather than 8
	ld b, a
.indeed8Badges
	ld a, [wTrainerNo]
	add b ; adds b to a
	pop bc
	ret
.normalLoading
	ld a, [wTrainerNo]
	ret

INCLUDE "data/trainers/special_moves.asm" ; new

INCLUDE "data/trainers/special_moves_physicalspecialsplit.asm" ; new, testing
