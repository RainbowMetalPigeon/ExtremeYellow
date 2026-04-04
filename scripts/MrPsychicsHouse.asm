MrPsychicsHouse_Script: ; edited
	call EnableAutoTextBoxDrawing
	ld de, MrPsychicsHouse_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

MrPsychicsHouse_ScriptPointers: ; new
	dw MrPsychicsHouseScript0
	dw MrPsychicsHouseSabrinaPostBattleRematch ; new, map-dependent

MrPsychicsHouseScript0: ; new
	ret

MrPsychicsHouse_TextPointers:
	dw SaffronHouse2Text1
	dw SaffronHouse2TextSabrina ; new
	; poly pidgey house
	dw SaffronHouse1Text1
	dw SaffronHouse1Text2
	dw SaffronHouse1Text3
	dw SaffronHouse1Text4
	; apartments, new
	dw SaffronNewApartmentsText1
	dw SaffronNewApartmentsText2
	dw SaffronNewApartmentsText3
	dw SaffronNewApartmentsText4
	dw SaffronNewApartmentsText5
	dw SaffronNewApartmentsText6
	; signs
	dw SaffronNewApartmentsSignText1
	; scripts texts
	dw MrPsychicsHouseTextSabrinaPostBattle ; 14, new, map-dependent

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
	ld a, 14 ; map-dependent
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_SABRINA_REMATCH_INVERSE ; map-dependent
	callfar SpawnRoute21OakWhenWonAllInverseRematches
	jp MrPsychicsHouseResetScripts

MrPsychicsHouseResetScripts: ; map-dependent
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

MrPsychicsHouseTextSabrinaPostBattle:
	text_far _GymLeaderElite4PostRematchInverseText
	text_end

; poly pidgey house -----------------------------------

SaffronHouse1Text1:
	text_far _SaffronHouse1Text1
	text_end

SaffronHouse1Text2:
	text_far _SaffronHouse1Text2
	text_asm
	ld a, PIDGEY
	call PlayCry
	jp TextScriptEnd

SaffronHouse1Text3:
	text_far _SaffronHouse1Text3
	text_end

SaffronHouse1Text4:
	text_far _SaffronHouse1Text4
	text_end

; apartments new -----------------------------------

SaffronNewApartmentsText1::
	text_far _SaffronNewApartmentsText1
	text_end

SaffronNewApartmentsText2::
	text_far _SaffronNewApartmentsText2
	text_end

SaffronNewApartmentsText3::
	text_far _SaffronNewApartmentsText3
	text_end

SaffronNewApartmentsText4::
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_DOWN
	ld hl, SaffronNewApartmentsText4_FromAbove
	jr z, .printAndEnd
	ld hl, SaffronNewApartmentsText4_NotFromAbove
.printAndEnd
	call PrintText
	jp TextScriptEnd

SaffronNewApartmentsText4_FromAbove:
	text_far _SaffronNewApartmentsText4_FromAbove
	text_end

SaffronNewApartmentsText4_NotFromAbove:
	text_far _SaffronNewApartmentsText4_NotFromAbove
	text_end

SaffronNewApartmentsText5::
	text_far _SaffronNewApartmentsText5
	text_end

SaffronNewApartmentsText6::
	text_far _SaffronNewApartmentsText6
	text_end

SaffronNewApartmentsSignText1:
	text_asm
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ld hl, SaffronNewApartmentsSignText1_FromBelow
	jr z, .printAndEnd
	ld hl, SaffronNewApartmentsSignText1_NotFromBelow
.printAndEnd
	call PrintText
	jp TextScriptEnd

SaffronNewApartmentsSignText1_FromBelow:
	text_far _SaffronNewApartmentsSignText1_FromBelow
	text_end

SaffronNewApartmentsSignText1_NotFromBelow:
	text_far _SaffronNewApartmentsSignText1_NotFromBelow
	text_end
