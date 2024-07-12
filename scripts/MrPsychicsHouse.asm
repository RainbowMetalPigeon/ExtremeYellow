MrPsychicsHouse_Script: ; edited
	call EnableAutoTextBoxDrawing
	ld de, MrPsychicsHouse_ScriptPointers
	ld a, [wMrPsychicsHouseCurScript]
	call ExecuteCurMapScriptInTable
	ld [wMrPsychicsHouseCurScript], a
	ret

MrPsychicsHouse_ScriptPointers: ; new
	dw MrPsychicsHouseScript0
	dw MrPsychicsHouseSabrinaPostBattleRematch ; new, map-dependent

MrPsychicsHouseScript0: ; new
	ret

MrPsychicsHouse_TextPointers:
	dw SaffronHouse2Text1
	dw SaffronHouse2TextSabrina ; new
	dw MrPsychicsHouseTextSabrinaPostBattle ; 10, new, map-dependent

SaffronHouse2Text1:
	text_asm
	CheckEvent EVENT_GOT_TM29
	jr nz, .got_item
	ld hl, TM29PreReceiveText
	call PrintText
	lb bc, TM_PSYCHIC_M, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ReceivedTM29Text
	call PrintText
	SetEvent EVENT_GOT_TM29
	jr .done
.bag_full
	ld hl, TM29NoRoomText
	call PrintText
	jr .done
.got_item
	ld hl, TM29ExplanationText
	call PrintText
.done
	jp TextScriptEnd

TM29PreReceiveText:
	text_far _TM29PreReceiveText
	text_end

ReceivedTM29Text:
	text_far _ReceivedTM29Text
	sound_get_item_1
	text_end

TM29ExplanationText:
	text_far _TM29ExplanationText
	text_end

TM29NoRoomText:
	text_far _TM29NoRoomText
	text_end

; new ------------------------------------------------

SaffronHouse2TextSabrina:
	text_asm
	ld hl, SaffronHouse2SabrinaBeforeBattleText
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
	ld a, OPP_SABRINA
	ld [wCurOpponent], a

	ld a, 9
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200

	ld hl, SaffronHouse2SabrinaPostBattleText
	ld de, SaffronHouse2SabrinaPostBattleText
	call SaveEndBattleTextPointers

; script handling
	ld a, $1 ; new script, map-dependent
	ld [wMrPsychicsHouseCurScript], a ; map-dependent
	ld [wCurMapScript], a
	jp TextScriptEnd

SaffronHouse2SabrinaBeforeBattleText:
	text_far _SaffronHouse2SabrinaBeforeBattleText
	text_end

SaffronHouse2SabrinaPostBattleText:
	text_far _SaffronHouse2SabrinaPostBattleText
	text_end

MrPsychicsHouseSabrinaPostBattleRematch: ; script, map-dependent
	ld a, [wIsInBattle]
	cp $ff
	jp z, MrPsychicsHouseResetScripts ; map-dependent
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 3 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA_REMATCH_INVERSE ; map-dependent
	jp MrPsychicsHouseResetScripts

MrPsychicsHouseResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wMrPsychicsHouseCurScript], a ; map-dependent
	ld [wCurMapScript], a
	ret

MrPsychicsHouseTextSabrinaPostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end
