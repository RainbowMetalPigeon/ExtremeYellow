CeruleanCaveExtraMiddle_Script:
	call EnableAutoTextBoxDrawing
;	SetEvent EVENT_IN_SEAFOAM_ISLANDS
;	ld hl, wFlags_0xcd60
;	bit 7, [hl]
;	res 7, [hl]
	ld a, CERULEAN_CAVE_EXTRA_BOTTOM
	ld [wDungeonWarpDestinationMap], a
	ld hl, CeruleanCaveExtraMiddleHolesCoords
	jp IsPlayerOnDungeonWarp

CeruleanCaveExtraMiddleHolesCoords:
	dbmapcoord  7,  7
	dbmapcoord 39, 39
	db -1 ; end

CeruleanCaveExtraMiddle_TextPointers:
	dw CeruleanCaveExtraMiddleTextLance ; new

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
	jp TextScriptEnd

CeruleanCaveExtraMiddleLanceBeforeBattleText:
	text_far _CeruleanCaveExtraMiddleLanceBeforeBattleText
	text_end

CeruleanCaveExtraMiddleLancePostBattleText:
	text_far _CeruleanCaveExtraMiddleLancePostBattleText
	text_end
