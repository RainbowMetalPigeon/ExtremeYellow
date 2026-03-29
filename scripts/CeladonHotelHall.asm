CeladonHotelHall_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeladonHotelHallTrainerHeaders
	ld de, CeladonHotelHall_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

CeladonHotelHall_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

CeladonHotelHall_TextPointers:
	; NPCs repair shop
	dw CeladonHotelHallText1 ; trainer
	dw CeladonHotelHallText2 ; trainer
	dw CeladonHotelHallText3 ; trainer
	dw CeladonHotelHallText4 ; trainer
	dw CeladonHotelHallText5 ; boss
	; signs hotel
	dw CeladonHotelHallSign1
	dw CeladonHotelHallSign2
	dw CeladonHotelHallSign3
	dw CeladonHotelHallSign4
	dw CeladonHotelHallSign5
	; signs repair shop
	dw CeladonHotelHallSign6
	dw CeladonHotelHallSign7
	dw CeladonHotelHallSign8

; NPCs ==================================

CeladonHotelHallText5:
	text_asm
; all over?
	CheckEvent EVENT_FIXED_MATCHA_MACHINE
	ld hl, CeladonHotelHallText5_FixedMatchaMachine
	jr nz, .printAndEnd
; have screwdriver?
	ld b, SCREWDRIVER
	call IsItemInBag ; set zero flag if item isn't in player's bag
	jr z, .noScrewdriverInBag
; screwdriver in bag
	CheckEvent EVENT_SPOKEN_WITH_REPAIR_BOSS
	jr nz, .notFirstTimeTalkToBoss
; have screwdriver but first time we talk to boss
	ld a, HS_ROUTE_7_REPAIR_PERSON
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_SPOKEN_WITH_REPAIR_BOSS
	ld hl, CeladonHotelHallText5_ScrewdriverInBagFirstTime
	jr .printAndEnd
.notFirstTimeTalkToBoss
	ld hl, CeladonHotelHallText5_ScrewdriverInBag
	jr nz, .printAndEnd
.noScrewdriverInBag
; already spoken to repair person
	CheckEvent EVENT_SPOKEN_WITH_REPAIR_PERSON
	ld hl, CeladonHotelHallText5_SpokenWithRepairPerson
	jr nz, .printAndEnd
; already spoken with boss but not with repair person
	CheckEvent EVENT_SPOKEN_WITH_REPAIR_BOSS
	ld hl, CeladonHotelHallText5_SpokenWithRepairBoss
	jr nz, .printAndEnd
.spawnRepairPerson
; first time speaking
	ld a, HS_ROUTE_7_REPAIR_PERSON
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_SPOKEN_WITH_REPAIR_BOSS
	ld hl, CeladonHotelHallText5_FirstTime
.printAndEnd
	call PrintText
	jp TextScriptEnd

CeladonHotelHallText5_ScrewdriverInBagFirstTime:
	text_far _CeladonHotelHallText5_ScrewdriverInBagFirstTime
	text_end

CeladonHotelHallText5_FixedMatchaMachine:
	text_far _CeladonHotelHallText5_FixedMatchaMachine
	text_end

CeladonHotelHallText5_ScrewdriverInBag:
	text_far _CeladonHotelHallText5_ScrewdriverInBag
	text_end

CeladonHotelHallText5_SpokenWithRepairPerson:
	text_far _CeladonHotelHallText5_SpokenWithRepairPerson
	text_end

CeladonHotelHallText5_SpokenWithRepairBoss:
	text_far _CeladonHotelHallText5_SpokenWithRepairBoss
	text_end

CeladonHotelHallText5_FirstTime:
	text_far _CeladonHotelHallText5_FirstTime
	text_end

; ---------------------------

CeladonHotelHallTrainerHeaders:
	def_trainers 1
CeladonHotelHallTrainerHeader0:
	trainer EVENT_BEAT_CELADON_HOTEL_HALL_TRAINER_0, 5, CeladonHotelHallBattleText0, CeladonHotelHallEndBattleText0, CeladonHotelHallAfterBattleText0
CeladonHotelHallTrainerHeader1:
	trainer EVENT_BEAT_CELADON_HOTEL_HALL_TRAINER_1, 2, CeladonHotelHallBattleText1, CeladonHotelHallEndBattleText1, CeladonHotelHallAfterBattleText1
CeladonHotelHallTrainerHeader2:
	trainer EVENT_BEAT_CELADON_HOTEL_HALL_TRAINER_2, 2, CeladonHotelHallBattleText2, CeladonHotelHallEndBattleText2, CeladonHotelHallAfterBattleText2
CeladonHotelHallTrainerHeader3:
	trainer EVENT_BEAT_CELADON_HOTEL_HALL_TRAINER_3, 4, CeladonHotelHallBattleText3, CeladonHotelHallEndBattleText3, CeladonHotelHallAfterBattleText3
	db -1

; --------

CeladonHotelHallText1:
	text_asm
	ld hl, CeladonHotelHallTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

CeladonHotelHallBattleText0:
	text_far _CeladonHotelHallBattleText0
	text_end

CeladonHotelHallEndBattleText0:
	text_far _CeladonHotelHallEndBattleText0
	text_end

CeladonHotelHallAfterBattleText0:
	text_far _CeladonHotelHallAfterBattleText0
	text_end

; --------

CeladonHotelHallText2:
	text_asm
	ld hl, CeladonHotelHallTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

CeladonHotelHallBattleText1:
	text_far _CeladonHotelHallBattleText1
	text_end

CeladonHotelHallEndBattleText1:
	text_far _CeladonHotelHallEndBattleText1
	text_end

CeladonHotelHallAfterBattleText1:
	text_far _CeladonHotelHallAfterBattleText1
	text_end

; --------

CeladonHotelHallText3:
	text_asm
	ld hl, CeladonHotelHallTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

CeladonHotelHallBattleText2:
	text_far _CeladonHotelHallBattleText2
	text_end

CeladonHotelHallEndBattleText2:
	text_far _CeladonHotelHallEndBattleText2
	text_end

CeladonHotelHallAfterBattleText2:
	text_far _CeladonHotelHallAfterBattleText2
	text_end

; --------

CeladonHotelHallText4:
	text_asm
	ld hl, CeladonHotelHallTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

CeladonHotelHallBattleText3:
	text_far _CeladonHotelHallBattleText3
	text_end

CeladonHotelHallEndBattleText3:
	text_far _CeladonHotelHallEndBattleText3
	text_end

CeladonHotelHallAfterBattleText3:
	text_far _CeladonHotelHallAfterBattleText3
	text_end

; signs =================================

CeladonHotelHallSign1:
	text_far _CeladonHotelHallSign1
	text_end

CeladonHotelHallSign2:
	text_far _CeladonHotelHallSign2
	text_end

CeladonHotelHallSign3:
	text_far _CeladonHotelHallSign3
	text_end

CeladonHotelHallSign4:
	text_far _CeladonHotelHallSign4
	text_end

CeladonHotelHallSign5:
	text_far _CeladonHotelHallSign5
	text_end

CeladonHotelHallSign6:
	text_far _CeladonHotelHallSign6
	text_end

CeladonHotelHallSign7:
	text_far _CeladonHotelHallSign7
	text_end

CeladonHotelHallSign8:
	text_far _CeladonHotelHallSign8
	text_end
