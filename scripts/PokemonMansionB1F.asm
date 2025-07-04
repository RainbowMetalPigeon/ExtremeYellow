PokemonMansionB1F_Script:
	call Mansion4Script_523cf
	call EnableAutoTextBoxDrawing
	ld hl, Mansion4TrainerHeaders
	ld de, PokemonMansionB1F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Mansion4Script_523cf:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jr nz, .asm_523ff
	ld a, $e
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $54
	ld bc, $808
	call Mansion2Script_5202f
	ret
.asm_523ff
	ld a, $2d
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $808
	call Mansion2Script_5202f
	ret

Mansion4Script_Switches::
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, 10 ; edited because rival
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

PokemonMansionB1F_ScriptPointers:
	dw Mansion4Script0 ; new
;	dw CheckFightingMapTrainers ; edited, commented out
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
	ld a, 9 ; index of Rival's sprite
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
	ld a, 9 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld a, OPP_RIVAL2
	ld [wCurOpponent], a
; to setup the appropriate end-of-battle text and team
	CheckEvent EVENT_BEAT_MT_MOON_1_RIVAL
	jr nz, .bothBattles
	ld hl, Mansion4RivalText_Win_FirstBattle ; text if player wins
	ld de, Mansion4RivalText_Lose_FirstBattle ; text if player loses
	call SaveEndBattleTextPointers
	ld a, 6
	jr .postSetupEndBattleTexts
.bothBattles
	ld hl, Mansion4RivalText_Win_BothBattles ; text if player wins
	ld de, Mansion4RivalText_Lose_BothBattles ; text if player loses
	call SaveEndBattleTextPointers
	ld a, 7
.postSetupEndBattleTexts
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
	ld a, 9 ; Rival's text (and sprite) index
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
	call StopAllMusic
	farcall Music_RivalAlternateStart
	ld a, 9 ; Rival's text (and sprite) index
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
;	ld a, HS_MT_MOON_1F_RIVAL
;	ld [wMissableObjectIndex], a
;	predef_jump HideObject

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
	ld a, 9
	ldh [hSpriteIndex], a
	ld a, SPRITE_FACING_RIGHT
	ldh [hSpriteFacingDirection], a
	jp SetSpriteFacingDirectionAndDelay ; face object

; ==============================================

PokemonMansionB1F_TextPointers:
	dw Mansion4Text1
	dw Mansion4Text2
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw Mansion4Text7
	dw PickUpItemText
	dw Mansion4TextRival ; new, 9
	dw Mansion3Text6 ; 10

Mansion4TrainerHeaders:
	def_trainers
Mansion4TrainerHeader0:
	trainer EVENT_BEAT_MANSION_4_TRAINER_0, 0, Mansion4BattleText1, Mansion4EndBattleText1, Mansion4AfterBattleText1
Mansion4TrainerHeader1:
	trainer EVENT_BEAT_MANSION_4_TRAINER_1, 3, Mansion4BattleText2, Mansion4EndBattleText2, Mansion4AfterBattleText2
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

Mansion4Text7:
	text_far _Mansion4Text7
	text_end

; ------------

Mansion4TextRival: ; new
	text_asm
	CheckEvent EVENT_BEAT_MANSION_RIVAL
	jr z, .PreBattleText
; check which text to print
	CheckEvent EVENT_BEAT_MT_MOON_1_RIVAL
	jr nz, .postBattle_BothBattles
	ld hl, Mansion4RivalText_PostBattle_FirstBattle
	call PrintText
	jr .end
.postBattle_BothBattles
	ld hl, Mansion4RivalText_PostBattle_BothBattles
	call PrintText
	jr .end
.PreBattleText
; check which text to print
	CheckEvent EVENT_BEAT_MT_MOON_1_RIVAL
	jr nz, .preBattle_BothBattles
	ld hl, Mansion4RivalText_PreBattle_FirstBattle
	call PrintText
	jr .end
.preBattle_BothBattles
	ld hl, Mansion4RivalText_PreBattle_BothBattles
	call PrintText
.end
	jp TextScriptEnd

Mansion4RivalText_PreBattle_FirstBattle:
	text_far _Mansion4RivalText_PreBattle_FirstBattle
	text_end

Mansion4RivalText_PreBattle_BothBattles:
	text_far _Mansion4RivalText_PreBattle_BothBattles
	text_end

Mansion4RivalText_PostBattle_FirstBattle:
	text_far _Mansion4RivalText_PostBattle_FirstBattle
	text_end

Mansion4RivalText_PostBattle_BothBattles:
	text_far _Mansion4RivalText_PostBattle_BothBattles
	text_end

Mansion4RivalText_Win_FirstBattle:
	text_far _Mansion4RivalText_Win_FirstBattle
	text_end

Mansion4RivalText_Win_BothBattles:
	text_far _Mansion4RivalText_Win_BothBattles
	text_end

Mansion4RivalText_Lose_FirstBattle:
	text_far _Mansion4RivalText_Lose_FirstBattle
	text_end

Mansion4RivalText_Lose_BothBattles:
	text_far _Mansion4RivalText_Lose_BothBattles
	text_end
