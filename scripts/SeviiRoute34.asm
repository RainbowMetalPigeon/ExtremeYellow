SeviiRoute34_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute34TrainerHeaders
	ld de, SeviiRoute34_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute34_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

SeviiRoute34_TextPointers:
	dw SeviiRoute34Text1 ; Amulet Coin gifter
	dw SeviiRoute34Text2 ; trainer
	dw SeviiRoute34Text3 ; trainer
	dw SeviiRoute34Text4 ; trainer
	dw SeviiRoute34Text5 ; trainer
	dw SeviiRoute34Text6 ; underground guard

SeviiRoute34TrainerHeaders:
	def_trainers 2
SeviiRoute34TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_34_TRAINER_1, 5, SeviiRoute34BattleText1, SeviiRoute34EndBattleText1, SeviiRoute34AfterBattleText1
SeviiRoute34TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_34_TRAINER_2, 5, SeviiRoute34BattleText2, SeviiRoute34EndBattleText2, SeviiRoute34AfterBattleText2
SeviiRoute34TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_34_TRAINER_3, 5, SeviiRoute34BattleText3, SeviiRoute34EndBattleText3, SeviiRoute34AfterBattleText3
SeviiRoute34TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_34_TRAINER_4, 1, SeviiRoute34BattleText4, SeviiRoute34EndBattleText4, SeviiRoute34AfterBattleText4
	db -1 ; end

SeviiRoute34_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute34Text2:
	text_asm
	ld hl, SeviiRoute34TrainerHeader1
	jr SeviiRoute34_TalkToTrainer

SeviiRoute34BattleText1:
	text_far _SeviiRoute34BattleText1
	text_end

SeviiRoute34EndBattleText1:
	text_far _SeviiRoute34EndBattleText1
	text_end

SeviiRoute34AfterBattleText1:
	text_far _SeviiRoute34AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute34Text3:
	text_asm
	ld hl, SeviiRoute34TrainerHeader2
	jr SeviiRoute34_TalkToTrainer

SeviiRoute34BattleText2:
	text_far _SeviiRoute34BattleText2
	text_end

SeviiRoute34EndBattleText2:
	text_far _SeviiRoute34EndBattleText2
	text_end

SeviiRoute34AfterBattleText2:
	text_far _SeviiRoute34AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute34Text4:
	text_asm
	ld hl, SeviiRoute34TrainerHeader3
	jr SeviiRoute34_TalkToTrainer

SeviiRoute34BattleText3:
	text_far _SeviiRoute34BattleText3
	text_end

SeviiRoute34EndBattleText3:
	text_far _SeviiRoute34EndBattleText3
	text_end

SeviiRoute34AfterBattleText3:
	text_far _SeviiRoute34AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute34Text5:
	text_asm
	ld hl, SeviiRoute34TrainerHeader4
	jr SeviiRoute34_TalkToTrainer

SeviiRoute34BattleText4:
	text_far _SeviiRoute34BattleText4
	text_end

SeviiRoute34EndBattleText4:
	text_far _SeviiRoute34EndBattleText4
	text_end

SeviiRoute34AfterBattleText4:
	text_far _SeviiRoute34AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute34Text1:
	text_asm
	CheckEvent EVENT_GOT_AMULET_COIN
	jr z, .beforeAmuletCoin
; after Amulet Coin
	ld hl, SeviiRoute34Text1_AfterAmuletCoin
	jr .printAndEnd
.beforeAmuletCoin
	ld hl, SeviiRoute34Text1_BeforeAmuletCoin
	call PrintText
; check happiness
	ld a, [wPikachuHappiness]
	cp 255
	jr z, .maxHappinness
; not max happiness
	ld hl, SeviiRoute34Text1_NotMaxHappiness
	jr .printAndEnd
.maxHappinness
	ld hl, SeviiRoute34Text1_YesMaxHappiness
	call PrintText
	lb bc, AMULET_COIN, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_AMULET_COIN
	ld hl, SeviiRoute34Text1_GotAmuletCoin
	jr .printAndEnd
.bagFull
	ld hl, SeviiRoute34Text1_BagFull
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute34Text1_AfterAmuletCoin:
	text_far _SeviiRoute34Text1_AfterAmuletCoin
	text_end

SeviiRoute34Text1_BeforeAmuletCoin:
	text_far _SeviiRoute34Text1_BeforeAmuletCoin
	text_end

SeviiRoute34Text1_NotMaxHappiness:
	text_far _SeviiRoute34Text1_NotMaxHappiness
	text_end

SeviiRoute34Text1_YesMaxHappiness:
	text_far _SeviiRoute34Text1_YesMaxHappiness
	text_end

SeviiRoute34Text1_GotAmuletCoin:
	text_far _SeviiRoute34Text1_GotAmuletCoin
	text_end

SeviiRoute34Text1_BagFull:
	text_far _SeviiRoute34Text1_BagFull
	text_end

; ---------------------------------------

SeviiRoute34Text6:
	text_far _SeviiUndergroundCaveGuardText
	text_end
