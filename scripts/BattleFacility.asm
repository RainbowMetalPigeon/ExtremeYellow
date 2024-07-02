BattleFacility_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, BattleFacilityTrainerHeaders
	ld de, BattleFacility_ScriptPointers
	ld a, [wBattleFacilityCurScript]
	call ExecuteCurMapScriptInTable
	ld [wBattleFacilityCurScript], a
	ret

; =====================================

BattleFacility_ScriptPointers:
	dw BattleFacilityScript0                      ; 0
	dw BattleFacilityScript1_PostBattle           ; 1
	dw BattleFacilityScript2_MoveGuide            ; 2
	dw BattleFacilityScript3_PostMoveGuide        ; 3
	dw BattleFacilityScript4_MovePlayer1          ; 4
	dw BattleFacilityScript5_PostMovePlayer1      ; 5
	dw BattleFacilityScript6_MovePlayer2          ; 6
	dw BattleFacilityScript7_PostMovePlayer2      ; 7
	dw BattleFacilityScript8_MoveOpponent         ; 8
	dw BattleFacilityScript9_PostMoveOpponent     ; 9
	dw BattleFacilityScript10_MoveOpponentOut     ; 10
	dw BattleFacilityScript11_PostMoveOpponentOut ; 11
	dw BattleFacilityScript12_AfterWarpVictory    ; 12
	dw BattleFacilityScript13_AfterWarpDefeat     ; 13

; -------------------------------------

BattleFacilityScript0:
; is the player standing on the entrance of the Arena room?
	ld a, [wXCoord]
	cp 21
	ret nz
	ld a, [wYCoord]
	cp 7
	ret nz
; if yes, load the script that moves them up
	ld a, 6
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript1_PostBattle:
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, [wBattleFacilityBattleMode] ; 0 for STANDARD, 1 for HARDCORE
	cp 1
	jr z, .hardcoreMode1 ; skip healing
	predef HealParty
.hardcoreMode1
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
; we have been defeated --------------------------
	ld a, [wLevelScalingBackup] ; reset level scaling as chosen by the player, TBV
	ld [wLevelScaling], a
	ld a, 13
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
; do all the other things we need to do if we lost, like reset the streak
	ld a, [wBattleFacilityBattleMode] ; 0 for STANDARD, 1 for HARDCORE
	and a
	jr z, .notHardcoreMode
	ld a, [wBattleFacilityWinningStreak]
	ld [wBattleFacilityHardcoreCurrentStreak], a ; save current streak if in hardcore mode
.notHardcoreMode
	xor a
	ld [wBattleFacilityWinningStreak], a
	ld [wIsInBattle], a ; maybe unnecessary but shouldn't hurt
	; more? TBV
.warpToEntrance
	predef HealParty ; heal the team, now or just after, why not now
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, BATTLE_FACILITY
	ldh [hWarpDestinationMap], a
	ld a, 4 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
;	ld a, VERMILION_CITY
;	ld [wLastMap], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret
.notDefeated ; we won -----------------------
; increase win streak
	ld a, [wBattleFacilityWinningStreak]
	inc a
	ld [wBattleFacilityWinningStreak], a
	inc a
	ld [wBattleFacilityWinningStreakNext], a
; check if we are in standard mode or hardcore
	ld a, [wBattleFacilityBattleMode] ; 0 for STANDARD, 1 for HARDCORE
	cp 1
	jr z, .hardcoreMode2 ; if we are in hardcore mode, don't stop regardless of how many victories
; here we are in standard mode
; print dialogue (depends if we finished the block or not)
	ld a, [wBattleFacilityWinningStreak]
	cp 7 ; 2 for testing
	jr nz, .notFinishedBlock
; we finished a block in standard mode
	ld a, 15 ; BattleFacilityText_FinishedBlock
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 12 ; we finished the session
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	jr .warpToEntrance
.notFinishedBlock
	ld a, 16 ; BattleFacilityText_HealAndSmolPrize
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; try to reward the PP UP
	ld c, 1
	ld b, PP_UP
	call GiveItem
	jr nc, .bagFullPPUP
; we successfully rewarded the PP UP
	ld a, 17 ; BattleFacilityText_ReceivedItem
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jr .hardcoreMode2
.bagFullPPUP
	ld a, 18 ; BattleFacilityText_BagFull
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; bag is full, we add it to the backlog stack
	ld hl, wBattleFacilityBacklogPPUPs
	inc [hl]
	jr nz, .hardcoreMode2
; the backlog of PP UPs is full, let's cap it at 255
	ld [hl], 255
.hardcoreMode2
	ld a, 12 ; BattleFacilityText_NextBattle
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.scriptHandling ; continue with the next battle
	ld a, 10
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript2_MoveGuide:
; prepare guide for movement?
	ld a, $1
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
; move guide
	ld de, BattleFacility_GuideMovements
	ld a, $1
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 3
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

BattleFacility_GuideMovements: ; just two steps, no need to be fast
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_LEFT
	db -1 ; end

; -------------------------------------

BattleFacilityScript3_PostMoveGuide:
	ld a, [wd730] ; check if NPC is being moved by script
	bit 0, a
	ret nz
;; make guide face right
;	ld a, $1
;	ldh [hSpriteIndex], a
;	ld a, SPRITE_FACING_RIGHT
;	ldh [hSpriteFacingDirection], a
;	call SetSpriteFacingDirectionAndDelay
; make guide face right, 2
	ld a, $2
	ld [wSprite01StateData1MovementStatus], a
	ld a, SPRITE_FACING_RIGHT
	ld [wSprite01StateData1FacingDirection], a
; script handling
	ld a, 4
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript4_MovePlayer1:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkToArena_RLEMovment
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; script handling
	ld a, 0
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

WalkToArena_RLEMovment:
	db D_UP, 4
	db -1 ; end

; -------------------------------------

BattleFacilityScript5_PostMovePlayer1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; script handling
	ld a, 0 ; unusual, for whatever reason I can't move after a warp
	        ; so I do the trick of moving to script 0 and checking there where I am
			; "morally" (functionally) we are going to script 6
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript6_MovePlayer2:
	ld a, $ff
	ld [wJoyIgnore], a
	ld hl, wSimulatedJoypadStatesEnd
	ld de, WalkInsideArena_RLEMovment
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
; script handling
	ld a, 7
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

WalkInsideArena_RLEMovment:
	db D_RIGHT, 2
	db D_UP, 3
	db -1 ; end

; -------------------------------------

BattleFacilityScript7_PostMovePlayer2:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
; script handling
	ld a, 8
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript8_MoveOpponent:
; show random opponent, later I also need to hide them, TBV
	call Random
	and 3 ; = %00000111, which is perfect because we have 4 options, now a is randomly in [0,3]
	ld [wBattleFacilityOpponentTrainerSprite], a
	cp 0
	jr z, .randomNumber0
	cp 1
	jr z, .randomNumber1
	cp 2
	jr z, .randomNumber2
	; cp 3 is redundant
	ld a, HS_BATTLE_FACILITY_OPP_GREEN
	jp .showBFTrainer
.randomNumber0
	ld a, HS_BATTLE_FACILITY_OPP_BLUE
	jp .showBFTrainer
.randomNumber1
	ld a, HS_BATTLE_FACILITY_OPP_RED
	jp .showBFTrainer
.randomNumber2
	ld a, HS_BATTLE_FACILITY_OPP_YELLOW
.showBFTrainer
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; prepare opponent for movement?
	ld a, [wBattleFacilityOpponentTrainerSprite]
	inc a
	inc a ; these two increases are to align the random index, [0,3], to the sprite index, [2,5]
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
; move opponent
	ld de, BattleFacility_OpponentMovements
	ld a, [wBattleFacilityOpponentTrainerSprite]
	inc a
	inc a ; these two increases are to align the random index, [0,3], to the sprite index, [2,5]
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 9
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

BattleFacility_OpponentMovements:
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_DOWN
	db NPC_FAST_MOVEMENT_LEFT
	db NPC_FAST_MOVEMENT_LEFT
	db -1 ; end

; -------------------------------------

BattleFacilityScript9_PostMoveOpponent:
	ld a, [wd730] ; check if NPC is being moved by script
	bit 0, a
	ret nz
; make opponent face left
	ld a, [wBattleFacilityOpponentTrainerSprite]
	cp 0
	jr z, .randomNumber0
	cp 1
	jr z, .randomNumber1
	cp 2
	jr z, .randomNumber2
	; cp 3 is redundant
	ld a, $2
	ld [wSprite05StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite05StateData1FacingDirection], a
	jr .postFacing
.randomNumber0
	ld a, $2
	ld [wSprite02StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite02StateData1FacingDirection], a
	jr .postFacing
.randomNumber1
	ld a, $2
	ld [wSprite03StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite03StateData1FacingDirection], a
	jr .postFacing
.randomNumber2
	ld a, $2
	ld [wSprite04StateData1MovementStatus], a
	ld a, SPRITE_FACING_LEFT
	ld [wSprite04StateData1FacingDirection], a
.postFacing
; trigger the battle
	xor a
	ld [wJoyIgnore], a
	ld a, $2 ; this dialogue also handles the script change
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

; -------------------------------------

BattleFacilityScript10_MoveOpponentOut:
; prepare opponent for movement?
	ld a, [wBattleFacilityOpponentTrainerSprite]
	inc a
	inc a ; these two increases are to align the random index, [0,3], to the sprite index, [2,5]
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
; move opponent out
	ld de, BattleFacility_OpponentMovementsOut
	ld a, [wBattleFacilityOpponentTrainerSprite]
	inc a
	inc a ; these two increases are to align the random index, [0,3], to the sprite index, [2,5]
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 11
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

BattleFacility_OpponentMovementsOut:
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db NPC_FAST_MOVEMENT_UP
	db -1 ; end

; -------------------------------------

BattleFacilityScript11_PostMoveOpponentOut:
	ld a, [wd730] ; check if NPC is being moved by script
	bit 0, a
	ret nz
; hide the defeated opponent
	ld a, [wBattleFacilityOpponentTrainerSprite]
	cp 0
	jr z, .randomNumber0
	cp 1
	jr z, .randomNumber1
	cp 2
	jr z, .randomNumber2
	; cp 3 is redundant
	ld a, HS_BATTLE_FACILITY_OPP_GREEN
	jp .hideBFTrainer
.randomNumber0
	ld a, HS_BATTLE_FACILITY_OPP_BLUE
	jp .hideBFTrainer
.randomNumber1
	ld a, HS_BATTLE_FACILITY_OPP_RED
	jp .hideBFTrainer
.randomNumber2
	ld a, HS_BATTLE_FACILITY_OPP_YELLOW
.hideBFTrainer
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
; wait a moment before the next opponent
	ld c, 30 ; 30 = half a second
	call DelayFrames
; is this needed? maybe if I print something?
;	xor a
;	ld [wJoyIgnore], a
;; print something?
;	ld a, $2
;	ldh [hSpriteIndexOrTextID], a
;	call DisplayTextID
; script handling
	ld a, 8 ; TBV
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript12_AfterWarpVictory:
	ld a, 13 ; BattleFacilityText_AfterWarpVictory
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide all opponents just to be safe
	ld a, HS_BATTLE_FACILITY_OPP_GREEN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_RED
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_YELLOW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
; handle records: if hardcore mode, we cannot exit the Arena by winning, so we can skip this check entirely
; standard
	ld a, [wBattleFacilityInverseBattle] ; 0 for Normal battle, 1 for Inverse Battle
	and a
	jr nz, .standard_inverse
; standard_normal
	ld a, [wBattleFacilityStandardCurrentStreakNormal]
	inc a
	ld [wBattleFacilityStandardCurrentStreakNormal], a
	ld hl, wBattleFacilityStandardRecordNormal
	cp [hl] ; = a-[hl] = current vs record streak; if <0 (aka c flag), we do nothing, otherwise we update
	jr c, .givePrizes
	ld [wBattleFacilityStandardRecordNormal], a ; "useless" in case we achieve the same record as last time
												; otherwise it updates the record
	jr .givePrizes
.standard_inverse
	ld a, [wBattleFacilityStandardCurrentStreakInverse]
	inc a
	ld [wBattleFacilityStandardCurrentStreakInverse], a
	ld hl, wBattleFacilityStandardRecordInverse
	cp [hl] ; = a-[hl] = current vs record streak; if <0 (aka c flag), we do nothing, otherwise we update
	jr c, .givePrizes
	ld [wBattleFacilityStandardRecordInverse], a ; "useless" in case we achieve the same record as last time
												 ; otherwise it updates the record
.givePrizes ; a still holds wBattleFacilityStandardCurrentStreakX (normal or inverse, doesn't matter)
; check which prize to give: PERFECTER normally, CHROMOGENE if streak is multiple of 7 (some weirdnesses when we go beyond 255 but oh well)
	call CheckIfMultipleOf7 ; z flag if multiple
	ld b, CHROMOGENE
	ld hl, wBattleFacilityBacklogChromogenes
	jr z, .giveChromogene
	ld b, PERFECTER
	ld hl, wBattleFacilityBacklogPerfecters
.giveChromogene
	push hl ; to preserve the backlog wram address
; shared code to reward perfecter or chromogene
    ld c, 1
    call GiveItem
    jr nc, .bagFullItem
; we successfully rewarded the prize
    ld a, 17 ; BattleFacilityText_ReceivedItem
    ldh [hSpriteIndexOrTextID], a
    call DisplayTextID
    jr .justToDoThePop
.bagFullItem
    ld a, 18 ; BattleFacilityText_BagFull
    ldh [hSpriteIndexOrTextID], a
    call DisplayTextID
; bag is full, we add it to the backlog stack
	pop hl ; to retrieve the backlog wram address
    inc [hl]
    jr nz, .scriptHandling
; the backlog of this prize is full, let's cap it at 255
    ld [hl], 255
	jr .scriptHandling
.justToDoThePop
	pop hl ; to preserve the push-pops in case we gave the prize right away
.scriptHandling
	ld a, 0
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; -------------------------------------

BattleFacilityScript13_AfterWarpDefeat:
	ld a, 14 ; BattleFacilityText_AfterWarpDefeat
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide all opponents just to be safe
	ld a, HS_BATTLE_FACILITY_OPP_GREEN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_BLUE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_RED
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_BATTLE_FACILITY_OPP_YELLOW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
; handle records
	ld a, [wBattleFacilityBattleMode] ; 0 for STANDARD, 1 for HARDCORE
	and a
	jr nz, .hardcore
; standard
	ld a, [wBattleFacilityInverseBattle] ; 0 for Normal battle, 1 for Inverse Battle
	and a
	jr nz, .standard_inverse
; standard_normal
	xor a
	ld [wBattleFacilityStandardCurrentStreakNormal], a
	jr .scriptHandling
.standard_inverse
	xor a
	ld [wBattleFacilityStandardCurrentStreakInverse], a
	jr .scriptHandling
.hardcore
	ld a, [wBattleFacilityInverseBattle] ; 0 for Normal battle, 1 for Inverse Battle
	and a
	jr nz, .hardcore_inverse
; hardcore_normal
	ld a, [wBattleFacilityHardcoreCurrentStreak]
	ld hl, wBattleFacilityHardcoreRecordNormal
	cp [hl] ; = a-[hl] = current vs record streak; if <0 (aka c flag), we do nothing, otherwise we update
	jr c, .scriptHandling
	ld [wBattleFacilityHardcoreRecordNormal], a
	jr .scriptHandling
.hardcore_inverse
	ld a, [wBattleFacilityHardcoreCurrentStreak]
	ld hl, wBattleFacilityHardcoreRecordInverse
	cp [hl] ; = a-[hl] = current vs record streak; if <0 (aka c flag), we do nothing, otherwise we update
	jr c, .scriptHandling
	ld [wBattleFacilityHardcoreRecordInverse], a
.scriptHandling
	ld a, 0
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	ret

; =====================================

BattleFacility_TextPointers:
	dw BattleFacilityTextGuide    ; 1, guide
	dw BattleFacilityTextOpponent ; 2, opponent(s)
	dw BattleFacilityTextOpponent ; 3, opponent(s)
	dw BattleFacilityTextOpponent ; 4, opponent(s)
	dw BattleFacilityTextOpponent ; 5, opponent(s)
	; other NPCs' texts
	dw BattleFacilityTextPerson1 ; 6, person
	dw BattleFacilityTextPerson2 ; 7, person
	dw BattleFacilityTextPerson3 ; 8, person
	; signs
	dw BattleFacilityTextSignRecordsNormal ; 9, tabellone segnapunti
	dw BattleFacilityTextSignRecordsInverse ; 10, tabellone segnapunti
	dw BattleFacilityTextGuide_Info ; 11, full rules
; non-NPCs texts
	dw BattleFacilityText_NextBattle       ; 12
	dw BattleFacilityText_AfterWarpVictory ; 13
	dw BattleFacilityText_AfterWarpDefeat  ; 14
	dw BattleFacilityText_FinishedBlock    ; 15
	dw BattleFacilityText_HealAndSmolPrize ; 16
	dw BattleFacilityText_ReceivedItem     ; 17
	dw BattleFacilityText_BagFull          ; 18

; NPCs texts --------------------------

BattleFacilityTextGuide:
	text_asm
; print intro text
	ld hl, BattleFacilityTextGuide_Intro
	call PrintText
; ask how they can help us
	call WhichInfoMenuToShow
	jp nz, .backlogPrizes
; basic menu, without prizes to claim
	call AskHowTheyCanHelp
	ld a, [wCurrentMenuItem] ; 0 for INFO, 1 for BATTLE, 2 for EXIT
	cp 2 ; EXIT
	jp z, .exit
	cp 1 ; BATTLE
	jp z, .battle
; else, INFO
.info
	CheckEvent EVENT_ALREADY_GOT_INFO_BATTLE_FACILITY
	jr z, .infoLong
	ld hl, BattleFacilityTextGuide_InfoShort
	jr .infoPrint
.infoLong
	SetEvent EVENT_ALREADY_GOT_INFO_BATTLE_FACILITY
	ld hl, BattleFacilityTextGuide_InfoFull
.infoPrint
	call PrintText
	jp TextScriptEnd
.prizes
	ld hl, BattleFacilityTextGuide_Prizes
	call PrintText
; try giving the PPUPs
	ld a, [wBattleFacilityBacklogPPUPs]
	and a
	jr z, .tryGivingPerfecters
	ld c, a
	ld b, PP_UP
	call GiveItem
	jr nc, .bagFull_PPUPs
	ld hl, BattleFacilityTextGuide_Prizes_PPUPs_Given
	call PrintText
	xor a
	ld [wBattleFacilityBacklogPPUPs], a
	jr .tryGivingPerfecters
.bagFull_PPUPs
	ld hl, BattleFacilityTextGuide_Prizes_PPUPs_Failed
	call PrintText
.tryGivingPerfecters
	ld a, [wBattleFacilityBacklogPerfecters]
	and a
	jr z, .tryGivingChromogenes
	ld c, a
	ld b, PERFECTER
	call GiveItem
	jr nc, .bagFull_Perfecters
	ld hl, BattleFacilityTextGuide_Prizes_Perfecters_Given
	call PrintText
	xor a
	ld [wBattleFacilityBacklogPerfecters], a
	jr .tryGivingChromogenes
.bagFull_Perfecters
	ld hl, BattleFacilityTextGuide_Prizes_Perfecters_Failed
	call PrintText
.tryGivingChromogenes
	ld a, [wBattleFacilityBacklogChromogenes]
	and a
	jr z, .doneWithPrizes
	ld c, a
	ld b, CHROMOGENE
	call GiveItem
	jr nc, .bagFull_Chromogenes
	ld hl, BattleFacilityTextGuide_Prizes_Chromogenes_Given
	call PrintText
	xor a
	ld [wBattleFacilityBacklogChromogenes], a
	jr .doneWithPrizes
.bagFull_Chromogenes
	ld hl, BattleFacilityTextGuide_Prizes_Chromogenes_Failed
	call PrintText
.doneWithPrizes
	ld hl, BattleFacilityTextGuide_Prizes_Ender
	call PrintText
	jp TextScriptEnd
.exit
	ld hl, BattleFacilityTextGuide_Exit
	call PrintText
	jp TextScriptEnd
.battle
	ld hl, BattleFacilityTextGuide_Battle1
	call PrintText
; ask what battle mode
	call WhatBattleFacilityMode
	ld a, [wCurrentMenuItem] ; 0 for STANDARD, 1 for HARDCORE, 2 for EXIT
	cp 2 ; EXIT
	jr z, .exit
	ld [wBattleFacilityBattleMode], a ; 0 for STANDARD, 1 for HARDCORE
; ask if normal or inverse battle
	ld hl, BattleFacilityTextGuide_Battle2
	call PrintText
	callfar NormalInverseChoice
	ld a, [wCurrentMenuItem]
	ld [wBattleFacilityInverseBattle], a ; 0 for Normal battle, 1 for Inverse Battle
	ld hl, BattleFacilityTextGuide_Battle3
	call PrintText
; reset the "internal" winning streak for standard mode, here is good enough
	xor a
	ld [wBattleFacilityWinningStreak], a
; set the battle style as Set (not Shift)
	ld hl, wOptions ; bit 6 = battle style: 0 Shift, 1 Set
	set 6, [hl]
; script handling
	ld a, 2 ; BattleFacilityScript_MoveGuide
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd
; if we have a backlog of unclaimed prizes
.backlogPrizes
	call AskHowTheyCanHelp
	ld a, [wCurrentMenuItem] ; 0 for INFO, 1 for BATTLE, 2 for PRIZES, 3 for EXIT
	cp 3 ; EXIT
	jr z, .exit
	cp 2 ; PRIZES
	jp z, .prizes
	cp 1 ; BATTLE
	jr z, .battle
	jp .info

BattleFacilityTextGuide_Intro:
	text_far _BattleFacilityTextGuide_Intro
	text_end

BattleFacilityTextGuide_Prizes:
	text_far _BattleFacilityTextGuide_Prizes
	text_end

BattleFacilityTextGuide_Prizes_PPUPs_Given:
	text_far _BattleFacilityTextGuide_Prizes_PPUPs_Given
	sound_get_item_1
	text_end

BattleFacilityTextGuide_Prizes_Perfecters_Given:
	text_far _BattleFacilityTextGuide_Prizes_Perfecters_Given
	sound_get_item_1
	text_end

BattleFacilityTextGuide_Prizes_Chromogenes_Given:
	text_far _BattleFacilityTextGuide_Prizes_Chromogenes_Given
	sound_get_item_1
	text_end

BattleFacilityTextGuide_Prizes_PPUPs_Failed:
	text_far _BattleFacilityTextGuide_Prizes_PPUPs_Failed
	text_end

BattleFacilityTextGuide_Prizes_Perfecters_Failed:
	text_far _BattleFacilityTextGuide_Prizes_Perfecters_Failed
	text_end

BattleFacilityTextGuide_Prizes_Chromogenes_Failed:
	text_far _BattleFacilityTextGuide_Prizes_Chromogenes_Failed
	text_end

BattleFacilityTextGuide_Prizes_Ender:
	text_far _BattleFacilityTextGuide_Prizes_Ender
	text_end

BattleFacilityTextGuide_Exit:
	text_far _BattleFacilityTextGuide_Exit
	text_end

BattleFacilityTextGuide_Battle1:
	text_far _BattleFacilityTextGuide_Battle1
	text_end

BattleFacilityTextGuide_Battle2:
	text_far _BattleFacilityTextGuide_Battle2
	text_end

BattleFacilityTextGuide_Battle3:
	text_far _BattleFacilityTextGuide_Battle3
	text_end

BattleFacilityTextGuide_Info:
	text_far _BattleFacilityTextGuide_Info
	text_end

BattleFacilityTextGuide_InfoShort:
	text_far _BattleFacilityTextGuide_InfoShort
	text_end

BattleFacilityTextGuide_InfoFull:
	text_far _BattleFacilityTextGuide_InfoFull
	text_end

; -------------------------------------

BattleFacilityTextOpponent:
	text_asm
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
; print intro text
	ld hl, BattleFacilityTextOpponent_Intro
	call PrintText
; they seem to do nothing?
.proxyLabel
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
; handle all wram variables needed for randomization
	xor a
	ld [wBattleFacilityWhichMonIsRandomized], a
	ld [wBattleFacilityMonNumber1], a
	ld [wBattleFacilityMonNumber2], a
	ld [wBattleFacilityMonNumber3], a
	ld [wBattleFacilityMonNumber4], a
	ld [wBattleFacilityMonNumber5], a
; randomize the shiny-ness of opp's mons
	callfar AssignShinyToBattleFacilityTrainers
; backup the current Level Scaling option choice to restore it after the battle, and set up the level scaling
	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 1 ; 0 for testing
	ld [wLevelScaling], a
; set up normal or inverse battle
	ld a, [wBattleFacilityInverseBattle] ; loaded when talking with the guide at the entrance
	ld [wInverseBattle], a ; necessary because this wram variable gets reset at the end of every battle
; set opponent
	call Delay3
	ld a, OPP_BF_TRAINER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; end-of-battle text
	ld hl, BattleFacilityTextOpponent_PostBattleWin ; text if player wins
	ld de, BattleFacilityTextOpponent_PostBattleLoss ; text if player loses
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; BattleFacilityScript1_PostBattle, number TBV
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

BattleFacilityTextOpponent_Intro:
	text_far _BattleFacilityTextOpponent_Intro
	text_end

BattleFacilityTextOpponent_PostBattleWin:
	text_far _BattleFacilityTextOpponent_PostBattleWin
	text_end

BattleFacilityTextOpponent_PostBattleLoss:
	text_far _BattleFacilityTextOpponent_PostBattleLoss
	text_end

; -------------------------------------

BattleFacilityTextPerson1:
	text_far _BattleFacilityTextPerson1
	text_end

BattleFacilityTextPerson2:
	text_far _BattleFacilityTextPerson2
	text_end

BattleFacilityTextPerson3:
	text_far _BattleFacilityTextPerson3
	text_end

; -------------------------------------

BattleFacilityTextSignRecordsNormal:
	text_asm
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a ; ? what does this do?
	ld hl, BattleFacilitySignIntroNormal
	call PrintText
	call PrintBattleFacilityRecords ; the wrapper for the main function
	jp TextScriptEnd

BattleFacilitySignIntroNormal:
	text_far _BattleFacilitySignIntroNormal
	text_waitbutton
	text_end

BattleFacilityTextSignRecordsInverse:
	text_asm
	ld a, 1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a ; ? what does this do?
	ld hl, BattleFacilitySignIntroInverse
	call PrintText
	call PrintBattleFacilityRecords ; the wrapper for the main function
	jp TextScriptEnd

BattleFacilitySignIntroInverse:
	text_far _BattleFacilitySignIntroInverse
	text_waitbutton
	text_end

PrintBattleFacilityRecords:
	call SaveScreenTilesToBuffer2
	ld hl, wd730
	set 6, [hl] ; bit 6: print text with no delay between each letter
	xor a
	ld [wUpdateSpritesEnabled], a
	callfar Printer_PrintBattleFacilityRecords ; the beefy function, the rest is to set up the graphic
	call WaitForTextScrollButtonPress
	ld hl, wd730
	res 6, [hl] ; bit 6: print text with no delay between each letter
	call GBPalWhiteOutWithDelay3
	call ReloadTilesetTilePatterns
	call RestoreScreenTilesAndReloadTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call GBPalNormal
	ld a, 1
	ld [wUpdateSpritesEnabled], a
	ret

; non-NPCs texts ----------------------

BattleFacilityText_NextBattle:
	text_far _BattleFacilityText_NextBattle
	text_end

BattleFacilityText_FinishedBlock:
	text_far _BattleFacilityText_FinishedBlock
	text_end

BattleFacilityText_HealAndSmolPrize:
	text_far _BattleFacilityText_HealAndSmolPrize
	text_end

BattleFacilityText_ReceivedItem:
	text_far _BattleFacilityText_ReceivedItem
	text_end

BattleFacilityText_BagFull:
	text_far _BattleFacilityText_BagFull
	text_end

BattleFacilityText_AfterWarpVictory:
	text_far _BattleFacilityText_AfterWarpVictory
	text_end

BattleFacilityText_AfterWarpDefeat:
	text_far _BattleFacilityText_AfterWarpDefeat
	text_end

; Extra functions =====================

WhichInfoMenuToShow: ; nz for the reward-including one, z for the basic one
	ld a, [wBattleFacilityBacklogPPUPs]
	and a
	ret nz
	ld a, [wBattleFacilityBacklogPerfecters]
	and a
	ret nz
	ld a, [wBattleFacilityBacklogChromogenes]
	and a
	ret

; -------------------------------------

AskHowTheyCanHelp:
	call WhichInfoMenuToShow
	jr nz, .backlogPrizes
; no backlog of unclaimed prizes
	call SaveScreenTilesToBuffer1
	ld a, BF_MENU_INFO_BATTLE_EXIT ; AAA
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 7 ; AAA
	ld [hli], a ; top menu item Y
	ld a, 12 ; AAA
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, $2 ; AAA
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .defaultOption ; if B was pressed, exit
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.defaultOption
	ld a, $02
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1
.backlogPrizes ; we do have a backlog of unclaimed prizes, show more options
	call SaveScreenTilesToBuffer1
	ld a, BF_MENU_INFO_BATTLE_PRIZES_EXIT ; AAA
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5 ; AAA
	ld [hli], a ; top menu item Y
	ld a, 12 ; AAA
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, $3 ; AAA
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .defaultOption2 ; if B was pressed, exit
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.defaultOption2
	ld a, $03
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; -------------------------------------

WhatBattleFacilityMode:
	call SaveScreenTilesToBuffer1
	ld a, BF_MENU_STANDARD_HARDCORE_EXIT
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 7
	ld [hli], a ; top menu item Y
	ld a, 12 ; AAA
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, $2
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .defaultOption ; if B was pressed, assign enby
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.defaultOption
	ld a, $02
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

; -------------------------------------

CheckIfMultipleOf7: ; input: a, output: z flag for multiple, nz if not multiple
.loop
	sub 7 ; 2 for testing
	ret z
	jr nc, .loop ; c flag is "Set if borrow (set if n8 > A)"
	ret
