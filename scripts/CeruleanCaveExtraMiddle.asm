CeruleanCaveExtraMiddle_Script:
	call EnableAutoTextBoxDrawing
	ld de, CeruleanCaveExtraMiddle_ScriptPointers
	ld a, [wCeruleanCaveExtraMiddleCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMrPsychicsHouseCurScript], a
	ret

CeruleanCaveExtraMiddle_ScriptPointers:
	dw CeruleanCaveExtraMiddleScript0
	dw CeruleanCaveExtraMiddleLancePostBattleRematch ; new, map-dependent

CeruleanCaveExtraMiddleScript0:
	ld a, CERULEAN_CAVE_EXTRA_BOTTOM
	ld [wDungeonWarpDestinationMap], a
	ld hl, CeruleanCaveExtraMiddleHolesCoords
	jp IsPlayerOnDungeonWarp

CeruleanCaveExtraMiddleHolesCoords:
	dbmapcoord  7,  7
	dbmapcoord 39, 39
	db -1 ; end

CeruleanCaveExtraMiddle_TextPointers:
	dw CeruleanCaveExtraMiddleTextLance
	dw CeruleanCaveExtraMiddleTextLancePostBattle ; 2, new, map-dependent

; new ------------------------------------------------

CeruleanCaveExtraMiddleTextLance:
	text_asm
	ld hl, CeruleanCaveExtraMiddleLanceBeforeBattleText
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
	ld a, OPP_LANCE
	ld [wCurOpponent], a

	ld a, 2
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, CeruleanCaveExtraMiddleLancePostBattleText
	ld de, CeruleanCaveExtraMiddleLancePostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $1 ; new script, map-dependent
	ld [wCeruleanCaveExtraMiddleCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

CeruleanCaveExtraMiddleLanceBeforeBattleText:
	text_far _CeruleanCaveExtraMiddleLanceBeforeBattleText
	text_end

CeruleanCaveExtraMiddleLancePostBattleText:
	text_far _CeruleanCaveExtraMiddleLancePostBattleText
	text_end

CeruleanCaveExtraMiddleLancePostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, CeruleanCaveExtraMiddleResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 2 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_LANCE_REMATCH_INVERSE ; map-dependent
	jp CeruleanCaveExtraMiddleResetScripts

CeruleanCaveExtraMiddleResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wCeruleanCaveExtraMiddleCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

CeruleanCaveExtraMiddleTextLancePostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
