SeviiRoute40_Script:
	call HideOrShowDottedHoleDoor
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute40TrainerHeaders
	ld de, SeviiRoute40_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; scripts =========================================

HideOrShowDottedHoleDoor:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .changeBlock
	ld hl, wCurrentMapScriptFlags
	bit 4, [hl]
	res 4, [hl]
	ret z
.changeBlock:
	CheckEvent EVENT_SEVII_DOTTED_HOLE_OPENED
	ret nz
; replace block
	ld a, $25 ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc, 10, 12
	predef_jump ReplaceTileBlock

SeviiRoute40_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiRoute40Script_CheckDoor ; 3

SeviiRoute40Script_CheckDoor:
; check if have Topaz and/or Tiger's Eye
	ld b, TOPAZ
	call IsItemInBag ; nz if in bag
	jr z, .checkTigersEye
; insert Topaz
	ld a, TOPAZ
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_DOTTED_HOLE_INSERTED_TOPAZ
	ld a, 17
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_SEVII_DOTTED_HOLE_INSERTED_TIGERS_EYE
	jr nz, .openDoor
	; TBE
.checkTigersEye
	ld b, TIGERS_EYE
	call IsItemInBag ; nz if in bag
	jr z, .scriptHandling
; insert Tiger's Eye
	ld a, TIGERS_EYE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_DOTTED_HOLE_INSERTED_TIGERS_EYE
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_SEVII_DOTTED_HOLE_INSERTED_TOPAZ
	jr z, .scriptHandling
.openDoor
	SetEvent EVENT_SEVII_DOTTED_HOLE_OPENED
	callfar ShakeScreen
	call PlayDefaultMusic
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $70 ; yes-entrance block
	ld [wNewTileBlockID], a
	lb bc, 10, 12
	predef ReplaceTileBlock
	ld a, SFX_GO_INSIDE
	call PlaySound
.scriptHandling
	xor a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiRoute40_TextPointers:
	dw SeviiRoute40Text1  ;  1 person
	dw SeviiRoute40Text2  ;  2 trainer
	dw SeviiRoute40Text3  ;  3 trainer
	dw SeviiRoute40Text4  ;  4 trainer
	dw SeviiRoute40Text5  ;  5 trainer
	dw SeviiRoute40Text6  ;  6 trainer
	dw SeviiRoute40Text7  ;  7 trainer
	dw SeviiRoute40Text8  ;  8 trainer
	dw SeviiRoute40Text9  ;  9 trainer
	dw RockSmashText ; 10
	dw PickUpItemText ; 11
	dw PickUpItemText ; 12
	dw PickUpItemText ; 13
	dw PickUpItemText ; 14
	; signs
	dw SeviiRoute40SignText1 ; 15
	dw SeviiRoute40SignText2 ; 16
	; scripts
	dw SeviiRoute40SignText2_InsertTopaz ; 17
	dw SeviiRoute40SignText2_InsertTigersEye ; 18
	dw SeviiRoute40SignText2_DoorOpens ; 19

SeviiRoute40Text1:
	text_far _SeviiRoute40Text1
	text_end

SeviiRoute40TrainerHeaders:
	def_trainers 2
SeviiRoute40TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_1, 4, SeviiRoute40BattleText1, SeviiRoute40EndBattleText1, SeviiRoute40AfterBattleText1
SeviiRoute40TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_2, 4, SeviiRoute40BattleText2, SeviiRoute40EndBattleText2, SeviiRoute40AfterBattleText2
SeviiRoute40TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_3, 4, SeviiRoute40BattleText3, SeviiRoute40EndBattleText3, SeviiRoute40AfterBattleText3
SeviiRoute40TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_4, 4, SeviiRoute40BattleText4, SeviiRoute40EndBattleText4, SeviiRoute40AfterBattleText4
SeviiRoute40TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_5, 4, SeviiRoute40BattleText5, SeviiRoute40EndBattleText5, SeviiRoute40AfterBattleText5
SeviiRoute40TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_6, 4, SeviiRoute40BattleText6, SeviiRoute40EndBattleText6, SeviiRoute40AfterBattleText6
SeviiRoute40TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_7, 4, SeviiRoute40BattleText7, SeviiRoute40EndBattleText7, SeviiRoute40AfterBattleText7
SeviiRoute40TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_40_TRAINER_8, 4, SeviiRoute40BattleText8, SeviiRoute40EndBattleText8, SeviiRoute40AfterBattleText8
	db -1 ; end

SeviiRoute40_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute40Text2:
	text_asm
	ld hl, SeviiRoute40TrainerHeader1
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText1:
	text_far _SeviiRoute40BattleText1
	text_end

SeviiRoute40EndBattleText1:
	text_far _SeviiRoute40EndBattleText1
	text_end

SeviiRoute40AfterBattleText1:
	text_far _SeviiRoute40AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute40Text3:
	text_asm
	ld hl, SeviiRoute40TrainerHeader2
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText2:
	text_far _SeviiRoute40BattleText2
	text_end

SeviiRoute40EndBattleText2:
	text_far _SeviiRoute40EndBattleText2
	text_end

SeviiRoute40AfterBattleText2:
	text_far _SeviiRoute40AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute40Text4:
	text_asm
	ld hl, SeviiRoute40TrainerHeader3
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText3:
	text_far _SeviiRoute40BattleText3
	text_end

SeviiRoute40EndBattleText3:
	text_far _SeviiRoute40EndBattleText3
	text_end

SeviiRoute40AfterBattleText3:
	text_far _SeviiRoute40AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute40Text5:
	text_asm
	ld hl, SeviiRoute40TrainerHeader4
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText4:
	text_far _SeviiRoute40BattleText4
	text_end

SeviiRoute40EndBattleText4:
	text_far _SeviiRoute40EndBattleText4
	text_end

SeviiRoute40AfterBattleText4:
	text_far _SeviiRoute40AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute40Text6:
	text_asm
	ld hl, SeviiRoute40TrainerHeader5
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText5:
	text_far _SeviiRoute40BattleText5
	text_end

SeviiRoute40EndBattleText5:
	text_far _SeviiRoute40EndBattleText5
	text_end

SeviiRoute40AfterBattleText5:
	text_far _SeviiRoute40AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute40Text7:
	text_asm
	ld hl, SeviiRoute40TrainerHeader6
	jr SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText6:
	text_far _SeviiRoute40BattleText6
	text_end

SeviiRoute40EndBattleText6:
	text_far _SeviiRoute40EndBattleText6
	text_end

SeviiRoute40AfterBattleText6:
	text_far _SeviiRoute40AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute40Text8:
	text_asm
	ld hl, SeviiRoute40TrainerHeader7
	jp SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText7:
	text_far _SeviiRoute40BattleText7
	text_end

SeviiRoute40EndBattleText7:
	text_far _SeviiRoute40EndBattleText7
	text_end

SeviiRoute40AfterBattleText7:
	text_far _SeviiRoute40AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute40Text9:
	text_asm
	ld hl, SeviiRoute40TrainerHeader8
	jp SeviiRoute40_TalkToTrainer

SeviiRoute40BattleText8:
	text_far _SeviiRoute40BattleText8
	text_end

SeviiRoute40EndBattleText8:
	text_far _SeviiRoute40EndBattleText8
	text_end

SeviiRoute40AfterBattleText8:
	text_far _SeviiRoute40AfterBattleText8
	text_end

; signs =================================

SeviiRoute40SignText1:
SeviiRoute40SignText2:
	text_asm
	CheckEvent EVENT_SEVII_DOTTED_HOLE_OPENED
	ld hl, SeviiRoute40SignText2_After_Inner
	jr nz, .printAndEnd
; before opening the door
	ld a, 3
	ld [wCurMapScript], a
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiRoute40SignText2_Before_Inner
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute40SignText2_Before_Inner:
	text_far _SeviiRoute40SignText2_Before
	text_end

SeviiRoute40SignText2_After_Inner:
	text_far _SeviiRoute40SignText2_After
	text_end

; scripts =================================

SeviiRoute40SignText2_InsertTopaz:
	text_far _SeviiRoute40SignText2_InsertTopaz
	sound_get_item_1
	text_end

SeviiRoute40SignText2_InsertTigersEye:
	text_far _SeviiRoute40SignText2_InsertTigersEye
	sound_get_item_1
	text_end

SeviiRoute40SignText2_DoorOpens:
	text_far _SeviiRoute40SignText2_DoorOpens
	text_end
	