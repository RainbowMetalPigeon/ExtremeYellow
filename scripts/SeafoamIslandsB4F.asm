SeafoamIslandsB4F_Script:
	call EnableAutoTextBoxDrawing
	ld a, [wSeafoamIslandsB4FCurScript]
	ld hl, SeafoamIslandsB4F_ScriptPointers
	jp CallFunctionInTable

SeafoamIslands5Script_467a5:
	xor a
	ld [wJoyIgnore], a
	ld [wSeafoamIslandsB4FCurScript], a
	ld [wCurMapScript], a
	ret

SeafoamIslandsB4F_ScriptPointers:
	dw SeafoamIslands5Script0
	dw SeafoamIslands5Script1
	dw SeafoamIslands5Script2
	dw SeafoamIslands5Script3
	dw SeafoamIslands5Script4
	dw SeafoamIslandB4FLoreleiPostBattleRematch ; new, map-dependent

SeafoamIslands5Script4:
	ld a, [wIsInBattle]
	cp $ff
	jr z, SeafoamIslands5Script_467a5
	call EndTrainerBattle
	ld a, $0
	ld [wSeafoamIslandsB4FCurScript], a
	ret

SeafoamIslands5Script0:
	CheckBothEventsSet EVENT_SEAFOAM3_BOULDER1_DOWN_HOLE, EVENT_SEAFOAM3_BOULDER2_DOWN_HOLE
	ret z
	ld hl, .Coords
	call ArePlayerCoordsInArray
	ret nc
	ld a, [wCoordIndex]
	cp $3
	jr nc, .asm_467e6
	ld a, NPC_MOVEMENT_UP
	ld [wSimulatedJoypadStatesEnd + 1], a
	ld a, 2
	jr .asm_467e8
.asm_467e6
	ld a, 1
.asm_467e8
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_UP
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	ld hl, wFlags_D733
	res 2, [hl]
	ld a, $1
	ld [wSeafoamIslandsB4FCurScript], a
	ret

.Coords
	dbmapcoord 20, 17
	dbmapcoord 21, 17
	dbmapcoord 20, 16
	dbmapcoord 21, 16
	db -1 ; end

SeafoamIslands5Script1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, $0
	ld [wSeafoamIslandsB4FCurScript], a
	ret

SeafoamIslands5Script2:
	CheckBothEventsSet EVENT_SEAFOAM4_BOULDER1_DOWN_HOLE, EVENT_SEAFOAM4_BOULDER2_DOWN_HOLE
	ld a, $0
	jr z, .asm_46849
	ld hl, .Coords
	call ArePlayerCoordsInArray
	ld a, $0
	jr nc, .asm_46849
	ld a, [wCoordIndex]
	cp $1
	jr nz, .asm_46837
	ld de, RLEMovementData_46859
	jr .asm_4683a
.asm_46837
	ld de, RLEMovementData_46852
.asm_4683a
	ld hl, wSimulatedJoypadStatesEnd
	call DecodeRLEList
	dec a
	ld [wSimulatedJoypadStatesIndex], a
	call StartSimulatingJoypadStates
	ld a, $3
.asm_46849
	ld [wSeafoamIslandsB4FCurScript], a
	ret

.Coords
	dbmapcoord  4, 14
	dbmapcoord  5, 14
	db -1 ; end

RLEMovementData_46852:
	db D_UP, 3
	db D_RIGHT, 2
	db D_UP, 1
	db -1 ; end

RLEMovementData_46859:
	db D_UP, 3
	db D_RIGHT, 3
	db D_UP, 1
	db -1 ; end

SeafoamIslands5Script3:
	ld a, [wSimulatedJoypadStatesIndex]
	ld b, a
	cp $1
	call z, SeaFoamIslands5Script_46872
	ld a, b
	and a
	ret nz
	ld a, $0
	ld [wSeafoamIslandsB4FCurScript], a
	ret

SeaFoamIslands5Script_46872:
	xor a
	ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	jp ForceBikeOrSurf

SeafoamIslandsB4F_TextPointers:
	dw SeafoamIslandB4FTextLorelei ; new
	dw BoulderText
	dw BoulderText
	dw ArticunoText
	dw SeafoamIslands5Text4
	dw SeafoamIslands5Text5
	dw SeafoamIslandB4FTextLoreleiPostBattle ; 7, new, map-dependent

; Articuno is object 3, but its event flag is bit 2.
; This is not a problem because its sight range is 0, and
; trainer headers were not stored by ExecuteCurMapScriptInTable.
	def_trainers 2
ArticunoTrainerHeader:
	trainer EVENT_BEAT_ARTICUNO, 0, ArticunoBattleText, ArticunoBattleText, ArticunoBattleText
	db -1 ; end

ArticunoText:
	text_asm
	ld hl, ArticunoTrainerHeader
	call TalkToTrainer
	ld a, $4
	ld [wSeafoamIslandsB4FCurScript], a
	jp TextScriptEnd

ArticunoBattleText:
	text_far _ArticunoBattleText
	text_asm
	ld a, ARTICUNO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

SeafoamIslands5Text4:
	text_far _SeafoamIslands5Text4
	text_end

SeafoamIslands5Text5:
	text_far _SeafoamIslands5Text5
	text_end

; new ------------------------------------------------

SeafoamIslandB4FTextLorelei:
	text_asm
	ld hl, SeafoamIslandB4FLoreleiBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic

	; make this an inverse battle
	ld a, 1
	ld [wInverseBattle], a

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_LORELEI
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, SeafoamIslandB4FLoreleiPostBattleText
	ld de, SeafoamIslandB4FLoreleiPostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $5 ; new script, map-dependent
	ld [wSeafoamIslandsB4FCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

SeafoamIslandB4FLoreleiBeforeBattleText:
	text_far _SeafoamIslandB4FLoreleiBeforeBattleText
	text_end

SeafoamIslandB4FLoreleiPostBattleText:
	text_far _SeafoamIslandB4FLoreleiPostBattleText
	text_end

SeafoamIslandB4FLoreleiPostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeafoamIslandB4FResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 7 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LORELEI_REMATCH_INVERSE ; map-dependent
	jp SeafoamIslandB4FResetScripts

SeafoamIslandB4FResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wSeafoamIslandsB4FCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

SeafoamIslandB4FTextLoreleiPostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
