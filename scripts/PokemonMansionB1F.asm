PokemonMansionB1F_Script:
	call Mansion4Script_HandleDoors
	call EnableAutoTextBoxDrawing
	ld hl, Mansion4TrainerHeaders
	ld de, PokemonMansionB1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Mansion4Script_HandleDoors: ; edited
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jp nz, .Mansion4SwitchOn

; Switch off
; change only some doors for speed's sake
	ld a, [wXCoord]
	cp 75
	jp nc, Mansion4F_SwitchOff_B3F
	cp 33
	jp nc, Mansion4F_SwitchOff_B2F
	; otherwise
	jp Mansion4F_SwitchOff_B1F

.Mansion4SwitchOn ; it's ON when we first arrive on this floor and when we reach the top-left room
; change only some doors for speed's sake
	ld a, [wXCoord]
	cp 75
	jp nc, Mansion4F_SwitchOn_B3F
	cp 33
	jp nc, Mansion4F_SwitchOn_B2F
	; otherwise
	jp Mansion4F_SwitchOn_B1F

Mansion4Script_Switches::
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, 11 ; edited because rival and Magikarp Burglar ; Mansion3Text6: Set/Reset EVENT_MANSION_SWITCH_ON
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

Mansion4F_SwitchOff_B1F:
	ld a, $e ; CLEAR FLOOR
	ld bc, $80d
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $b06
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $304
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $808
	jp Mansion2Script_ReplaceBlockWrapper

Mansion4F_SwitchOff_B2F:
	; open
	ld a, $e ; CLEAR FLOOR
	ld bc, $316
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $71A
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $B14
	call Mansion2Script_ReplaceBlockWrapper
	; close
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $716
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $A16
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $921
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $119
	jp Mansion2Script_ReplaceBlockWrapper

Mansion4F_SwitchOff_B3F:
	lb bc, 105, 115
	lb de,   0,  16
	call CheckIfInRectangle_PM ; b = min x, c = max x, d = min y, e = max y
	jr c, .topRow
	lb bc,  78, 105
	lb de,   0,  10
	call CheckIfInRectangle_PM ; b = min x, c = max x, d = min y, e = max y
	jr c, .topRow
; bottom row
	ld a, $e ; CLEAR FLOOR
	ld bc, $62A
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $A29
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $B30
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $2d ; DOOR HORIZONTAL (low)
	ld bc, $829
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $831
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $72D
	jp Mansion2Script_ReplaceBlockWrapper
.topRow
	ld a, $e ; CLEAR FLOOR
	ld bc, $12B
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $131
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $538
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $32B
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $331
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $536
	jp Mansion2Script_ReplaceBlockWrapper

Mansion4F_SwitchOn_B1F:
	ld a, $2d ; DOOR HORIZONTAL (low)
	ld bc, $80d
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $b06
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $304
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $808
	jp Mansion2Script_ReplaceBlockWrapper

Mansion4F_SwitchOn_B2F:
	; open
	ld a, $e ; CLEAR FLOOR
	ld bc, $716
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $A16
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $921
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $119
	call Mansion2Script_ReplaceBlockWrapper
	; close
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $316
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $71A
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $B14
	jp Mansion2Script_ReplaceBlockWrapper

Mansion4F_SwitchOn_B3F:
	lb bc, 105, 115
	lb de,   0,  16
	call CheckIfInRectangle_PM ; b = min x, c = max x, d = min y, e = max y
	jr c, .topRow
	lb bc,  78, 105
	lb de,   0,  10
	call CheckIfInRectangle_PM ; b = min x, c = max x, d = min y, e = max y
	jr c, .topRow
; bottom row
	ld a, $e ; CLEAR FLOOR
	ld bc, $829
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $831
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $72D
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $62A
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $A29
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $B30
	jp Mansion2Script_ReplaceBlockWrapper
.topRow
	ld a, $e ; CLEAR FLOOR
	ld bc, $32B
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $331
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $e ; CLEAR FLOOR
	ld bc, $536
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $12B
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $5f ; DOOR VERTICAL (right)
	ld bc, $131
	call Mansion2Script_ReplaceBlockWrapper
	ld a, $54 ; DOOR HORIZONTAL (high)
	ld bc, $538
	jp Mansion2Script_ReplaceBlockWrapper

; inputs:
; b = min x, c = max x, d = min y, e = max y
; output:
; c flag = in the rectangle, nc otherwise
CheckIfInRectangle_PM:
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

PokemonMansionB1F_ScriptPointers:
	dw Mansion4Script0 ; new
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Mansion4Script3 ; new
	dw Mansion4Script4 ; new
	dw Mansion4Script5 ; new

; ==============================================

Mansion4Script0: ; new
	CheckEvent EVENT_BEAT_MANSION_RIVAL
	jp nz, CheckFightingMapTrainers
	ld hl, MansionB1FCoords
	call ArePlayerCoordsInArray
	jp nc, CheckFightingMapTrainers
	ld a, [wWalkBikeSurfState]
	and a
	jr z, .walking
	call StopAllMusic
.walking
	ld c, BANK(Music_MeetRival)
	ld a, MUSIC_MEET_RIVAL
	call PlayMusic
	xor a
	ldh [hJoyHeld], a
	ld a, $f0
	ld [wJoyIgnore], a
	; no need to keep the sprite hidden and show it later, it's anyhow not visible from anywhere
	ld a, [wYCoord]
	cp 6 ; top part of entrance
	jr z, .playerOnTopPart
	ld de, MansionB1FMovements1_Bottom
	jr .continue
.playerOnTopPart
	ld de, MansionB1FMovements1
.continue
	ld a, 10 ; index of Rival's sprite
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, $3 ; testing
	ld [wCurMapScript], a
	ret

Mansion4Script3: ; new
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, 10 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
	ld hl, Mansion4RivalText_Win_FirstBattle ; text if player wins
	ld de, Mansion4RivalText_Lose_FirstBattle ; text if player loses
	call SaveEndBattleTextPointers
	ld a, 6
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	call Mansion4Script_RivalFacingRight
	ld a, 4
	ld [wCurMapScript], a
	ret

Mansion4Script4: ; new
	ld a, [wIsInBattle]
	cp $ff
	jp z, Mansion4Script_ResetIfLoseVsRival
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	call Mansion4Script_RivalFacingRight
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_BEAT_MANSION_RIVAL
	ld a, 10 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 10 ; Rival's text (and sprite) index
	ldh [hSpriteIndex], a
	call SetSpriteMovementBytesToFF
	ld a, [wYCoord]
	cp 6 ; top part of entrance
	jr z, .playerOnTopPart
	ld de, MansionB1FMovements2_Bottom
	jr .continue
.playerOnTopPart
	ld de, MansionB1FMovements2
.continue
	call MoveSprite
	ld a, $5
	ld [wCurMapScript], a
	ret

Mansion4Script5: ; new
	ld a, [wd730]
	bit 0, a
	ret nz
	ld a, HS_POKEMON_MANSION_B1F_RIVAL
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	xor a
	ld [wJoyIgnore], a
	call PlayDefaultMusic
	ld a, $0
	ld [wCurMapScript], a
	ret

; -------------------------------

MansionB1FCoords:
	dbmapcoord  8,  6
	dbmapcoord  8,  7
	db -1 ; end

MansionB1FMovements1_Bottom:
	db NPC_MOVEMENT_DOWN
MansionB1FMovements1:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Mansion4Script_ResetIfLoseVsRival:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

MansionB1FMovements2:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

MansionB1FMovements2_Bottom:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

Mansion4Script_RivalFacingRight:
	ld a, 10
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay ; face object

; ==============================================

PokemonMansionB1F_TextPointers:
	dw Mansion4Text1
	dw Mansion4Text2
	dw Mansion4Text3 ; new
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw Mansion4Text7
	dw PickUpItemText
	dw Mansion4TextRival ; new, 10
	; scripts
	dw Mansion3Text6 ; 11

Mansion4TrainerHeaders:
	def_trainers
Mansion4TrainerHeader0:
	trainer EVENT_BEAT_MANSION_4_TRAINER_0, 0, Mansion4BattleText1, Mansion4EndBattleText1, Mansion4AfterBattleText1
Mansion4TrainerHeader1:
	trainer EVENT_BEAT_MANSION_4_TRAINER_1, 3, Mansion4BattleText2, Mansion4EndBattleText2, Mansion4AfterBattleText2
Mansion4TrainerHeader2: ; new
	trainer EVENT_BEAT_MANSION_4_TRAINER_2, 0, Mansion4BattleText3, Mansion4EndBattleText3, Mansion4AfterBattleText3 ; new
	db -1 ; end

Mansion4Text1:
	text_asm
	ld hl, Mansion4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Mansion4Text2:
	text_asm
	ld hl, Mansion4TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Mansion4Text3:
	text_asm
	ld hl, Mansion4TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Mansion4BattleText1:
	text_far _Mansion4BattleText1
	text_end

Mansion4EndBattleText1:
	text_far _Mansion4EndBattleText1
	text_end

Mansion4AfterBattleText1:
	text_far _Mansion4AfterBattleText1
	text_end

Mansion4BattleText2:
	text_far _Mansion4BattleText2
	text_end

Mansion4EndBattleText2:
	text_far _Mansion4EndBattleText2
	text_end

Mansion4AfterBattleText2:
	text_far _Mansion4AfterBattleText2
	text_end

Mansion4BattleText3: ; new
	text_far _Mansion4BattleText3
	text_end

Mansion4EndBattleText3: ; new
	text_far _Mansion4EndBattleText3
	text_end

Mansion4AfterBattleText3: ; new
	text_far _Mansion4AfterBattleText3
	text_end

Mansion4Text7:
	text_far _Mansion4Text7
	text_end

; ------------

Mansion4TextRival: ; new
	text_asm
	CheckEvent EVENT_BEAT_MANSION_RIVAL
	jr z, .PreBattleText
	ld hl, Mansion4RivalText_PostBattle_FirstBattle
	call PrintText
	jr .end
.PreBattleText
	ld hl, Mansion4RivalText_PreBattle_FirstBattle
	call PrintText
.end
	jp TextScriptEnd

/*
Mansion4RivalText_PreBattle_BothBattles:
	text_far _Mansion4RivalText_PreBattle_BothBattles
	text_end

Mansion4RivalText_PostBattle_BothBattles:
	text_far _Mansion4RivalText_PostBattle_BothBattles
	text_end

Mansion4RivalText_Win_BothBattles:
	text_far _Mansion4RivalText_Win_BothBattles
	text_end

Mansion4RivalText_Lose_BothBattles:
	text_far _Mansion4RivalText_Lose_BothBattles
	text_end
*/

Mansion4RivalText_PreBattle_FirstBattle:
	text_far _Mansion4RivalText_PreBattle_FirstBattle
	text_end

Mansion4RivalText_PostBattle_FirstBattle:
	text_far _Mansion4RivalText_PostBattle_FirstBattle
	text_end

Mansion4RivalText_Win_FirstBattle:
	text_far _Mansion4RivalText_Win_FirstBattle
	text_end

Mansion4RivalText_Lose_FirstBattle:
	text_far _Mansion4RivalText_Lose_FirstBattle
	text_end
