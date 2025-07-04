SilphCo5F_Script:
	call SilphCo5Script_19f4d
	call EnableAutoTextBoxDrawing
	ld hl, SilphCo5TrainerHeaders
	ld de, SilphCo5F_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SilphCo5Script_19f4d:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	ld hl, SilphCo5GateCoords
	call SilphCo4Script_19d5d
	call SilphCo5Script_19f9e
	CheckEvent EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .asm_19f74
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 2, 3
	predef ReplaceTileBlock
	pop af
.asm_19f74
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	jr nz, .asm_19f87
	push af
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 6, 3
	predef ReplaceTileBlock
	pop af
.asm_19f87
	CheckEventAfterBranchReuseA EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR2
	ret nz
	ld a, $5f
	ld [wNewTileBlockID], a
	lb bc, 5, 7
	predef_jump ReplaceTileBlock

SilphCo5GateCoords:
	dbmapcoord  3,  2
	dbmapcoord  3,  6
	dbmapcoord  7,  5
	db -1 ; end

SilphCo5Script_19f9e:
	EventFlagAddress hl, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ldh a, [hUnlockedSilphCoDoors]
	and a
	ret z
	cp $1
	jr nz, .next1
	SetEventReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.next1
	cp $2
	jr nz, .next2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR2, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret
.next2
	SetEventAfterBranchReuseHL EVENT_SILPH_CO_5_UNLOCKED_DOOR3, EVENT_SILPH_CO_5_UNLOCKED_DOOR1
	ret

SilphCo5F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SilphCo5F_TextPointers:
	dw SilphCo5Text1
	dw SilphCo5Text1b
	dw SilphCo5Text2
	dw SilphCo5Text3
	dw SilphCo5Text4
	dw SilphCo5Text5
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw SilphCo5Text9
	dw SilphCo5Text10
	dw SilphCo5Text11

SilphCo5TrainerHeaders:
	def_trainers 3
SilphCo5TrainerHeader0:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_0, 1, SilphCo5BattleText2, SilphCo5EndBattleText2, SilphCo5AfterBattleText2
SilphCo5TrainerHeader1:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_1, 2, SilphCo5BattleText3, SilphCo5EndBattleText3, SilphCo5AfterBattleText3
SilphCo5TrainerHeader2:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_2, 4, SilphCo5BattleText4, SilphCo5EndBattleText4, SilphCo5AfterBattleText4
SilphCo5TrainerHeader3:
	trainer EVENT_BEAT_SILPH_CO_5F_TRAINER_3, 3, SilphCo5BattleText5, SilphCo5EndBattleText5, SilphCo5AfterBattleText5
	db -1 ; end

SilphCo5Text1:
	text_asm
	ld hl, SilphCo5Text_1a010
	ld de, SilphCo5Text_1a015
	call SilphCo6Script_1a22f
	jp TextScriptEnd

SilphCo5Text_1a010:
	text_far _SilphCo5Text_1a010
	text_end

SilphCo5Text_1a015:
	text_far _SilphCo5Text_1a015
	text_end

SilphCo5Text2:
	text_asm
	ld hl, SilphCo5TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5BattleText2:
	text_far _SilphCo5BattleText2
	text_end

SilphCo5EndBattleText2:
	text_far _SilphCo5EndBattleText2
	text_end

SilphCo5AfterBattleText2:
	text_far _SilphCo5AfterBattleText2
	text_end

SilphCo5Text3:
	text_asm
	ld hl, SilphCo5TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5BattleText3:
	text_far _SilphCo5BattleText3
	text_end

SilphCo5EndBattleText3:
	text_far _SilphCo5EndBattleText3
	text_end

SilphCo5AfterBattleText3:
	text_far _SilphCo5AfterBattleText3
	text_end

SilphCo5Text4:
	text_asm
	ld hl, SilphCo5TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5BattleText4:
	text_far _SilphCo5BattleText4
	text_end

SilphCo5EndBattleText4:
	text_far _SilphCo5EndBattleText4
	text_end

SilphCo5AfterBattleText4:
	text_far _SilphCo5AfterBattleText4
	text_end

SilphCo5Text5:
	text_asm
	ld hl, SilphCo5TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

SilphCo5BattleText5:
	text_far _SilphCo5BattleText5
	text_end

SilphCo5EndBattleText5:
	text_far _SilphCo5EndBattleText5
	text_end

SilphCo5AfterBattleText5:
	text_far _SilphCo5AfterBattleText5
	text_end

SilphCo5Text9: ; new
	text_asm
	ld hl, SilphCo5Text9_1
	call PrintText
	CheckEvent EVENT_GOT_DUBIOUS_DISK
	jr nz, .done
	ld hl, SilphCo5Text9_2
	call PrintText
	lb bc, DUBIOUS_DISK, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, ObtainedDubiousDiskText
	call PrintText
	SetEvent EVENT_GOT_DUBIOUS_DISK
	jr .done
.bag_full
	ld hl, DubiousDiskNoRoomText
	call PrintText
.done
	jp TextScriptEnd

SilphCo5Text9_1:
	text_far _SilphCo5Text9_1
	text_end

SilphCo5Text9_2:
	text_far _SilphCo5Text9_2
	text_end

ObtainedDubiousDiskText:
	text_far _ObtainedDubiousDiskText
	sound_get_item_1
	text_end

DubiousDiskNoRoomText:
	text_far _DubiousDiskNoRoomText
	text_end

SilphCo5Text10:
	text_far _SilphCo5Text10
	text_end

SilphCo5Text11:
	text_far _SilphCo5Text11
	text_end

; ----------------------------------------------

SilphCo5Text1b: ; new
	text_asm
	ld a, [wd72e]
	bit 0, a ; got porygon?
	jr z, .NotGotPorygon
; --- got Poryong already
	CheckEvent EVENT_GOT_UPGRADE
	jr z, .GotPorygonNoUpgrade
    CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
    jr z, .GotPorygonYesUpgradeNoGiovanni
    ld hl, SilphCo5Text1b_GotPorygonYesUpgradeYesGiovanni
    call PrintText
    jr .done
.GotPorygonYesUpgradeNoGiovanni
    ld hl, SilphCo5Text1b_GotPorygonYesUpgradeNoGiovanni
    call PrintText
    jr .done
.GotPorygonNoUpgrade
    ld hl, SilphCo5Text1b_GotPorygonNoUpgrade
    call PrintText
    lb bc, UPGRADE, 1
    call GiveItem
    jr nc, .bagFull
    ld hl, ObtainedUpgradeText
    call PrintText
    SetEvent EVENT_GOT_UPGRADE
    jr .done
.bagFull
	ld hl, UpgradeNoRoomText
	call PrintText
; --- didn't get Porygon yet
.NotGotPorygon
    CheckEvent EVENT_BEAT_SILPH_CO_GIOVANNI
    jr z, .NotGotPorygonNoBeatGiovanni
    ld hl, SilphCo5Text1b_NoGotPorygonYesGiovanni
    call PrintText
    jr .done
.NotGotPorygonNoBeatGiovanni
    ld hl, SilphCo5Text1b_NoGotPorygonNoGiovanni
    call PrintText
.done
	jp TextScriptEnd

SilphCo5Text1b_GotPorygonYesUpgradeYesGiovanni:
    text_far _SilphCo5Text1b_GotPorygonYesUpgradeYesGiovanni
    text_end

SilphCo5Text1b_GotPorygonYesUpgradeNoGiovanni:
    text_far _SilphCo5Text1b_GotPorygonYesUpgradeNoGiovanni
    text_end

SilphCo5Text1b_GotPorygonNoUpgrade:
    text_far _SilphCo5Text1b_GotPorygonNoUpgrade
    text_end

ObtainedUpgradeText:
    text_far _ObtainedUpgradeText
	sound_get_item_1
    text_end

UpgradeNoRoomText:
    text_far _UpgradeNoRoomText
    text_end

SilphCo5Text1b_NoGotPorygonYesGiovanni:
    text_far _SilphCo5Text1b_NoGotPorygonYesGiovanni
    text_end

SilphCo5Text1b_NoGotPorygonNoGiovanni:
    text_far _SilphCo5Text1b_NoGotPorygonNoGiovanni
    text_end
