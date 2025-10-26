SeviiRoute36_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiRoute36TrainerHeaders
	ld de, SeviiRoute36_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; scripts ====================================

SeviiRoute36_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw SeviiRoute36Script3

SeviiRoute36Script3:
; exclamatin bubble
	ld a, 1
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; turn person and player
	lb bc, STAY, LEFT
	ld a, 1
	ldh [hSpriteIndex], a
	call ChangeSpriteMovementBytes ; Engeze approach
	lb de, 1, SPRITE_FACING_LEFT
	callfar ChangeSpriteFacing ; new Pigeon approach
	ld a, SPRITE_FACING_RIGHT
	ld [wSpritePlayerStateData1FacingDirection], a
; dialogue
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; end
	xor a
	ld [wCurMapScript], a
	ret

; texts ====================================

SeviiRoute36_TextPointers:
	dw SeviiRoute36Text1  ;  1 person
	dw SeviiRoute36Text2  ;  2 trainer
	dw SeviiRoute36Text3  ;  3 trainer
	dw SeviiRoute36Text4  ;  4 trainer
	dw SeviiRoute36Text5  ;  5 trainer
	dw SeviiRoute36Text6  ;  6 trainer
	dw SeviiRoute36Text7  ;  7 trainer
	dw SeviiRoute36Text8  ;  8 trainer
	dw SeviiRoute36Text9  ;  9 trainer
	dw SeviiRoute36Text10 ; 10 trainer
	dw SeviiRoute36Text11 ; 11 trainer
	dw SeviiRoute36Text12 ; 12 trainer
	dw SeviiRoute36Text13 ; 13 trainer
	dw PickUpItemText ; 14
	; signs
	dw SeviiRoute36SignText1 ; 15

SeviiRoute36TrainerHeaders:
	def_trainers 2
; metalheads
SeviiRoute36TrainerHeader1:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_1, 2, SeviiRoute36BattleText1, SeviiRoute36EndBattleText1, SeviiRoute36AfterBattleText1
SeviiRoute36TrainerHeader2:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_2, 2, SeviiRoute36BattleText2, SeviiRoute36EndBattleText2, SeviiRoute36AfterBattleText2
SeviiRoute36TrainerHeader3:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_3, 2, SeviiRoute36BattleText3, SeviiRoute36EndBattleText3, SeviiRoute36AfterBattleText3
SeviiRoute36TrainerHeader4:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_4, 2, SeviiRoute36BattleText4, SeviiRoute36EndBattleText4, SeviiRoute36AfterBattleText4
; cooltrainer
SeviiRoute36TrainerHeader5:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_5, 2, SeviiRoute36BattleText5, SeviiRoute36EndBattleText5, SeviiRoute36AfterBattleText5
; birbs!
SeviiRoute36TrainerHeader6:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_6, 2, SeviiRoute36BattleText6, SeviiRoute36EndBattleText6, SeviiRoute36AfterBattleText6
SeviiRoute36TrainerHeader7:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_7, 2, SeviiRoute36BattleText7, SeviiRoute36EndBattleText7, SeviiRoute36AfterBattleText7
SeviiRoute36TrainerHeader8:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_8, 2, SeviiRoute36BattleText8, SeviiRoute36EndBattleText8, SeviiRoute36AfterBattleText8
; splash splash
SeviiRoute36TrainerHeader9:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_9, 2, SeviiRoute36BattleText9, SeviiRoute36EndBattleText9, SeviiRoute36AfterBattleText9
SeviiRoute36TrainerHeader10:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_10, 2, SeviiRoute36BattleText10, SeviiRoute36EndBattleText10, SeviiRoute36AfterBattleText10
SeviiRoute36TrainerHeader11:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_11, 3, SeviiRoute36BattleText11, SeviiRoute36EndBattleText11, SeviiRoute36AfterBattleText11
SeviiRoute36TrainerHeader12:
	trainer EVENT_BEAT_SEVII_ROUTE_36_TRAINER_12, 4, SeviiRoute36BattleText12, SeviiRoute36EndBattleText12, SeviiRoute36AfterBattleText12
	db -1 ; end

SeviiRoute36_TalkToTrainer:
	call TalkToTrainer
	jp TextScriptEnd

; ---------------------------------------

SeviiRoute36Text2:
	text_asm
	ld hl, SeviiRoute36TrainerHeader1
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText1:
	text_far _SeviiRoute36BattleText1
	text_end

SeviiRoute36EndBattleText1:
	text_far _SeviiRoute36EndBattleText1
	text_end

SeviiRoute36AfterBattleText1:
	text_far _SeviiRoute36AfterBattleText1
	text_end

; ---------------------------------------

SeviiRoute36Text3:
	text_asm
	ld hl, SeviiRoute36TrainerHeader2
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText2:
	text_far _SeviiRoute36BattleText2
	text_end

SeviiRoute36EndBattleText2:
	text_far _SeviiRoute36EndBattleText2
	text_end

SeviiRoute36AfterBattleText2:
	text_far _SeviiRoute36AfterBattleText2
	text_end

; ---------------------------------------

SeviiRoute36Text4:
	text_asm
	ld hl, SeviiRoute36TrainerHeader3
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText3:
	text_far _SeviiRoute36BattleText3
	text_end

SeviiRoute36EndBattleText3:
	text_far _SeviiRoute36EndBattleText3
	text_end

SeviiRoute36AfterBattleText3:
	text_far _SeviiRoute36AfterBattleText3
	text_end

; ---------------------------------------

SeviiRoute36Text5:
	text_asm
	ld hl, SeviiRoute36TrainerHeader4
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText4:
	text_far _SeviiRoute36BattleText4
	text_end

SeviiRoute36EndBattleText4:
	text_far _SeviiRoute36EndBattleText4
	text_end

SeviiRoute36AfterBattleText4:
	text_far _SeviiRoute36AfterBattleText4
	text_end

; ---------------------------------------

SeviiRoute36Text6:
	text_asm
	ld hl, SeviiRoute36TrainerHeader5
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText5:
	text_far _SeviiRoute36BattleText5
	text_end

SeviiRoute36EndBattleText5:
	text_far _SeviiRoute36EndBattleText5
	text_end

SeviiRoute36AfterBattleText5:
	text_far _SeviiRoute36AfterBattleText5
	text_end

; ---------------------------------------

SeviiRoute36Text7:
	text_asm
	ld hl, SeviiRoute36TrainerHeader6
	jr SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText6:
	text_far _SeviiRoute36BattleText6
	text_end

SeviiRoute36EndBattleText6:
	text_far _SeviiRoute36EndBattleText6
	text_end

SeviiRoute36AfterBattleText6:
	text_far _SeviiRoute36AfterBattleText6
	text_end

; ---------------------------------------

SeviiRoute36Text8:
	text_asm
	ld hl, SeviiRoute36TrainerHeader7
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText7:
	text_far _SeviiRoute36BattleText7
	text_end

SeviiRoute36EndBattleText7:
	text_far _SeviiRoute36EndBattleText7
	text_end

SeviiRoute36AfterBattleText7:
	text_far _SeviiRoute36AfterBattleText7
	text_end

; ---------------------------------------

SeviiRoute36Text9:
	text_asm
	ld hl, SeviiRoute36TrainerHeader8
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText8:
	text_far _SeviiRoute36BattleText8
	text_end

SeviiRoute36EndBattleText8:
	text_far _SeviiRoute36EndBattleText8
	text_end

SeviiRoute36AfterBattleText8:
	text_far _SeviiRoute36AfterBattleText8
	text_end

; ---------------------------------------

SeviiRoute36Text10:
	text_asm
	ld hl, SeviiRoute36TrainerHeader9
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText9:
	text_far _SeviiRoute36BattleText9
	text_end

SeviiRoute36EndBattleText9:
	text_far _SeviiRoute36EndBattleText9
	text_end

SeviiRoute36AfterBattleText9:
	text_far _SeviiRoute36AfterBattleText9
	text_end

; ---------------------------------------

SeviiRoute36Text11:
	text_asm
	ld hl, SeviiRoute36TrainerHeader10
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText10:
	text_far _SeviiRoute36BattleText10
	text_end

SeviiRoute36EndBattleText10:
	text_far _SeviiRoute36EndBattleText10
	text_end

SeviiRoute36AfterBattleText10:
	text_far _SeviiRoute36AfterBattleText10
	text_end

; ---------------------------------------

SeviiRoute36Text12:
	text_asm
	ld hl, SeviiRoute36TrainerHeader11
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText11:
	text_far _SeviiRoute36BattleText11
	text_end

SeviiRoute36EndBattleText11:
	text_far _SeviiRoute36EndBattleText11
	text_end

SeviiRoute36AfterBattleText11:
	text_far _SeviiRoute36AfterBattleText11
	text_end

; ---------------------------------------

SeviiRoute36Text13:
	text_asm
	ld hl, SeviiRoute36TrainerHeader12
	jp SeviiRoute36_TalkToTrainer

SeviiRoute36BattleText12:
	text_far _SeviiRoute36BattleText12
	text_end

SeviiRoute36EndBattleText12:
	text_far _SeviiRoute36EndBattleText12
	text_end

SeviiRoute36AfterBattleText12:
	text_far _SeviiRoute36AfterBattleText12
	text_end

; Dive HM ==============================================

SeviiRoute36Text1:
	text_asm
	CheckEvent EVENT_GOT_HM09
	ld hl, SeviiRoute36Text1_PostHM
	jr nz, .printAndEnd
; we didn't get Dive, check if we already offered Lemonad to grave
	CheckEvent EVENT_SEVII_OFFERED_LEMONADE_TO_GRAVE
	ld hl, SeviiRoute36Text1_PreLemonade
	jr z, .printAndEnd
; we offered lemonade but didn't get HM yet (just did or bag full)
	ld hl, SeviiRoute36Text1_TryGiveHM
	call PrintText
	lb bc, HM_DIVE, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_HM09
	ld hl, SeviiRoute36Text1_ReceivedHM09
	jr .printAndEnd
.bagFull
	ld hl, SeviiRoute36Text1_NoRoom
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiRoute36Text1_ReceivedHM09:
	text_far _SeviiRoute36Text1_ReceivedHM09
	sound_get_key_item
	text_end

SeviiRoute36Text1_TryGiveHM:
	text_far _SeviiRoute36Text1_TryGiveHM
	text_end

SeviiRoute36Text1_NoRoom:
	text_far _SeviiRoute36Text1_NoRoom
	text_end

SeviiRoute36Text1_PreLemonade:
	text_far _SeviiRoute36Text1_PreLemonade
	text_end

SeviiRoute36Text1_PostHM:
	text_far _SeviiRoute36Text1_PostHM
	text_end
	
; ---------------------------------------

SeviiRoute36SignText1:
	text_asm
	ld hl, SeviiRoute36SignText1_WrongSide
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, .printAndEnd
; right direction
	CheckEvent EVENT_SEVII_OFFERED_LEMONADE_TO_GRAVE
	ld hl, SeviiRoute36SignText1_PostOffer
	jr nz, .printAndEnd
; not offered lemonade yet
	ld hl, SeviiRoute36SignText1_PreOffer
	call PrintText
	ld b, LEMONADE
	call IsItemInBag ; set zero flag if item isn't in player's bag	
	jr z, .done
; we have lemonade in bag
	call WaitForTextScrollButtonPress
	ld hl, SeviiRoute36SignText1_WannaOffer
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, SeviiRoute36SignText1_NoOffer
	jr nz, .printAndEnd
; we offer a lemonade
	ld a, LEMONADE
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_SEVII_OFFERED_LEMONADE_TO_GRAVE
; load script
	ld a, 3
	ld [wCurMapScript], a
	ld hl, SeviiRoute36SignText1_YesOffer
.printAndEnd
	call PrintText
.done
	jp TextScriptEnd

SeviiRoute36SignText1_YesOffer:
	text_far _SeviiRoute36SignText1_YesOffer
	text_end

SeviiRoute36SignText1_NoOffer:
	text_far _SeviiRoute36SignText1_NoOffer
	text_end

SeviiRoute36SignText1_WannaOffer:
	text_far _SeviiRoute36SignText1_WannaOffer
	text_end

SeviiRoute36SignText1_PreOffer:
	text_far _SeviiRoute36SignText1_PreOffer
	text_end

SeviiRoute36SignText1_PostOffer:
	text_far _SeviiRoute36SignText1_PostOffer
	text_end

SeviiRoute36SignText1_WrongSide:
	text_far _SeviiRoute36SignText1_WrongSide
	text_end
