PokemonMansion2F_Script:
	call Mansion2Script_51fee
	call EnableAutoTextBoxDrawing
	ld hl, Mansion2TrainerHeaders
	ld de, PokemonMansion2F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

Mansion2Script_51fee:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jr nz, .asm_52016
	ld a, $e
	lb bc, 2, 4
	call Mansion2Script_5202f
	ld a, $54
	lb bc, 4, 9
	call Mansion2Script_5202f
	ld a, $5f
	lb bc, 11, 3
	call Mansion2Script_5202f
	ret
.asm_52016
	ld a, $5f
	lb bc, 2, 4
	call Mansion2Script_5202f
	ld a, $e
	lb bc, 4, 9
	call Mansion2Script_5202f
	ld a, $e
	lb bc, 11, 3
	call Mansion2Script_5202f
	ret

Mansion2Script_5202f:
	ld [wNewTileBlockID], a
	predef_jump ReplaceTileBlock

Mansion2Script_Switches::
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ldh [hJoyHeld], a
	ld a, $6 ; edited because rematch Blaine
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

PokemonMansion2F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw PokemonMansion2FBlainePostBattleRematch ; new, map-dependent

PokemonMansion2F_TextPointers:
	dw Mansion2TextBlaine ; new
	dw Mansion2Text1
	dw PickUpItemText
	dw Mansion2Text3
	dw Mansion2Text4
	dw Mansion2Text5 ; statue switch text
	dw PokemonMansion2FTextBlainePostBattle ; 7, new, map-dependent

Mansion2TrainerHeaders:
	def_trainers 2 ; edited because of rematch Blaine
Mansion2TrainerHeader0:
	trainer EVENT_BEAT_MANSION_2_TRAINER_0, 0, Mansion2BattleText1, Mansion2EndBattleText1, Mansion2AfterBattleText1
	db -1 ; end

Mansion2Text1:
	text_asm
	ld hl, Mansion2TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Mansion2BattleText1:
	text_far _Mansion2BattleText1
	text_end

Mansion2EndBattleText1:
	text_far _Mansion2EndBattleText1
	text_end

Mansion2AfterBattleText1:
	text_far _Mansion2AfterBattleText1
	text_end

Mansion2Text3:
	text_far _Mansion2Text3
	text_end

Mansion2Text4:
	text_far _Mansion2Text4
	text_end

Mansion3Text6:
Mansion2Text5:
	text_asm
	ld hl, Mansion2Text_520c2
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_520b9
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	ld hl, wCurrentMapScriptFlags
	set 5, [hl]
	ld hl, Mansion2Text_520c7
	call PrintText
	ld a, SFX_GO_INSIDE
	call PlaySound
	CheckAndSetEvent EVENT_MANSION_SWITCH_ON
	jr z, .asm_520bf
	ResetEventReuseHL EVENT_MANSION_SWITCH_ON
	jr .asm_520bf
.asm_520b9
	ld hl, Mansion2Text_520cc
	call PrintText
.asm_520bf
	jp TextScriptEnd

Mansion2Text_520c2:
	text_far _Mansion2Text_520c2
	text_end

Mansion2Text_520c7:
	text_far _Mansion2Text_520c7
	text_end

Mansion2Text_520cc:
	text_far _Mansion2Text_520cc
	text_end

; new ------------------------------------------------

Mansion2TextBlaine:
	text_asm
	ld hl, Mansion2BlaineBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	; make this an inverse battle
	ld a, 1
	ld [wInverseBattle], a

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_BLAINE
	ld [wCurOpponent], a

	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, Mansion2BlainePostBattleText
	ld de, Mansion2BlainePostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $3 ; new script, map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

Mansion2BlaineBeforeBattleText:
	text_far _Mansion2BlaineBeforeBattleText
	text_end

Mansion2BlainePostBattleText:
	text_far _Mansion2BlainePostBattleText
	text_end

PokemonMansion2FBlainePostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, PokemonMansion2FResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 7 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BLAINE_REMATCH_INVERSE ; map-dependent
	jp PokemonMansion2FResetScripts

PokemonMansion2FResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

PokemonMansion2FTextBlainePostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
