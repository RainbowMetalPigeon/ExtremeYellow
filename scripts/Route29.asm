Route29_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route29TrainerHeaders
	ld de, Route29_ScriptPointers
	ld a, [wRoute29CurScript]
	call ExecuteCurMapScriptInTable
	ld [wRoute29CurScript], a
	ret

Route29_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw Route29Script_PlacedAllOrbs1 ; 3
	dw Route29Script_PlacedAllOrbs2 ; 4

Route29Script_PlacedAllOrbs1:
	ld a, 24 ; Route29TextOrbsVanish1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToWhite
	ld a, ARTICUNO
	call PlayCry
	call WaitForSoundToFinish
	ld a, HS_ARTICUNO
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, ZAPDOS
	call PlayCry
	call WaitForSoundToFinish
	ld a, HS_ZAPDOS
	ld [wMissableObjectIndex], a
	predef ShowObject
	ld a, MOLTRES
	call PlayCry
	call WaitForSoundToFinish
	ld a, HS_MOLTRES
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromWhite
	ld a, 4 ; Route29Script_PlacedAllOrbs2
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	ret

Route29Script_PlacedAllOrbs2:
	ld a, 25 ; Route29TextOrbsVanish2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 0
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	ret

Route29_TextPointers:
	; trainers
	dw Route29Text1                ; 1
	dw Route29Text2                ; 2
	dw Route29Text3                ; 3
	dw Route29Text4                ; 4
	dw Route29Text5                ; 5
	dw Route29Text6                ; 6
	dw Route29Text7                ; 7
	dw Route29Text8                ; 8
	dw Route29Text9                ; 9
	; non-trainers
	dw Route29TextSlowking         ; 10
	; signs
	dw Route29TextIceOrbRecess     ; 11
	dw Route29TextThunderOrbRecess ; 12
	dw Route29TextFireOrbRecess    ; 13
	dw Route29TextRuin1			   ; 14
	dw Route29TextRuin1			   ; 15
	dw Route29TextRuin2			   ; 16
	dw Route29TextRuin2			   ; 17
	dw Route29TextRuin3			   ; 18
	dw Route29TextRuin3			   ; 19
	dw Route29TextRuin4			   ; 20
	dw Route29TextRuin4			   ; 21
	dw Route29TextRuin5			   ; 22
	dw Route29TextRuin5			   ; 23
	; non-NPCs/signs
	dw Route29TextOrbsVanish1      ; 24
	dw Route29TextOrbsVanish2      ; 25

Route29TrainerHeaders:
	def_trainers
Route29TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_0, 0, Route29BattleText1, Route29EndBattleText1, Route29AfterBattleText1
Route29TrainerHeader1:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_1, 3, Route29BattleText2, Route29EndBattleText2, Route29AfterBattleText2
Route29TrainerHeader2:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_2, 3, Route29BattleText3, Route29EndBattleText3, Route29AfterBattleText3
Route29TrainerHeader3:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_3, 3, Route29BattleText4, Route29EndBattleText4, Route29AfterBattleText4
Route29TrainerHeader4:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_4, 1, Route29BattleText5, Route29EndBattleText5, Route29AfterBattleText5
Route29TrainerHeader5:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_5, 0, Route29BattleText6, Route29EndBattleText6, Route29AfterBattleText6
Route29TrainerHeader6:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_6, 0, Route29BattleText7, Route29EndBattleText7, Route29AfterBattleText7
Route29TrainerHeader7:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_7, 4, Route29BattleText8, Route29EndBattleText8, Route29AfterBattleText8
Route29TrainerHeader8:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_8, 4, Route29BattleText9, Route29EndBattleText9, Route29AfterBattleText9
	db -1 ; end

; trainers -------------------

Route29Text1:
	text_asm
	ld hl, Route29TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText1:
	text_far _Route29BattleText1
	text_end

Route29EndBattleText1:
	text_far _Route29EndBattleText1
	text_end

Route29AfterBattleText1:
	text_asm
	CheckEvent EVENT_GOT_TM51 ; FLAIL
	jr nz, .gotItem
	ld hl, Route29AfterBattleText1_TM51PreReceiveText
	call PrintText
	lb bc, TM_FREEZE_DRY, 1
	call GiveItem
	jr nc, .bagFull
	ld hl, Route29AfterBattleText1_TM51ReceivedText
	call PrintText
	SetEvent EVENT_GOT_TM51
	jr .done
.bagFull
	ld hl, Route29AfterBattleText1_TM51NoRoomText
	call PrintText
	jr .done
.gotItem
	ld hl, Route29AfterBattleText1_TM51PostReceiveText
	call PrintText
.done
	jp TextScriptEnd

Route29AfterBattleText1_TM51PreReceiveText:
	text_far _Route29AfterBattleText1_TM51PreReceiveText
	text_end

Route29AfterBattleText1_TM51ReceivedText:
	text_far _Route29AfterBattleText1_TM51ReceivedText
	sound_get_item_1
	text_end

Route29AfterBattleText1_TM51NoRoomText:
	text_far _Route29AfterBattleText1_TM51NoRoomText
	text_end

Route29AfterBattleText1_TM51PostReceiveText:
	text_far _Route29AfterBattleText1_TM51PostReceiveText
	text_end


; ---

Route29Text2:
	text_asm
	ld hl, Route29TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText2:
	text_far _Route29BattleText2
	text_end

Route29EndBattleText2:
	text_far _Route29EndBattleText2
	text_end

Route29AfterBattleText2:
	text_far _Route29AfterBattleText2
	text_end

; ---

Route29Text3:
	text_asm
	ld hl, Route29TrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText3:
	text_far _Route29BattleText3
	text_end

Route29EndBattleText3:
	text_far _Route29EndBattleText3
	text_end

Route29AfterBattleText3:
	text_far _Route29AfterBattleText3
	text_end

; ---

Route29Text4:
	text_asm
	ld hl, Route29TrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText4:
	text_far _Route29BattleText4
	text_end

Route29EndBattleText4:
	text_far _Route29EndBattleText4
	text_end

Route29AfterBattleText4:
	text_far _Route29AfterBattleText4
	text_end

; ---

Route29Text5:
	text_asm
	ld hl, Route29TrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText5:
	text_far _Route29BattleText5
	text_end

Route29EndBattleText5:
	text_far _Route29EndBattleText5
	text_end

Route29AfterBattleText5:
	text_far _Route29AfterBattleText5
	text_end

; ---

Route29Text6:
	text_asm
	ld hl, Route29TrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText6:
	text_far _Route29BattleText6
	text_end

Route29EndBattleText6:
	text_far _Route29EndBattleText6
	text_end

Route29AfterBattleText6:
	text_far _Route29AfterBattleText6
	text_end

; ---

Route29Text7:
	text_asm
	ld hl, Route29TrainerHeader6
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText7:
	text_far _Route29BattleText7
	text_end

Route29EndBattleText7:
	text_far _Route29EndBattleText7
	text_end

Route29AfterBattleText7:
	text_far _Route29AfterBattleText7
	text_end

; ---

Route29Text8:
	text_asm
	ld hl, Route29TrainerHeader7
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText8:
	text_far _Route29BattleText8
	text_end

Route29EndBattleText8:
	text_far _Route29EndBattleText8
	text_end

Route29AfterBattleText8:
	text_far _Route29AfterBattleText8
	text_end

; ---

Route29Text9:
	text_asm
	ld hl, Route29TrainerHeader8
	call TalkToTrainer
	jp TextScriptEnd

Route29BattleText9:
	text_far _Route29BattleText9
	text_end

Route29EndBattleText9:
	text_far _Route29EndBattleText9
	text_end

Route29AfterBattleText9:
	text_far _Route29AfterBattleText9
	text_end

; non-trainers ---------------

Route29TextSlowking:
	text_asm
	ld hl, Route29TextSlowking_SummoningHappened
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr nz, .printAndEnd
; Birds not summoned yet
	xor a
	ld [wUniQuizAnswer], a ; this wram variable is never used again
	CheckEvent EVENT_ALREADY_REWARDED_ORB_OBSIDIAN_SCIENTIST
	jr z, .continue1
	ld a, [wUniQuizAnswer]
	inc a
	ld [wUniQuizAnswer], a
.continue1
	CheckEvent EVENT_ALREADY_REWARDED_ORB_CELADON_PHD
	jr z, .continue2
	ld a, [wUniQuizAnswer]
	inc a
	ld [wUniQuizAnswer], a
.continue2
	CheckEvent EVENT_ALREADY_REWARDED_ORB_OCHRE_POWER_ENGINEER
	jr z, .continue3
	ld a, [wUniQuizAnswer]
	inc a
	ld [wUniQuizAnswer], a
.continue3
	ld a, [wUniQuizAnswer] ; now a contains the number of ORBs obtained
	and a
	jr .orbs0
	cp 1
	jr .orbs1
	cp 2
	jr .orbs2
; 3 orbs
	ld hl, Route29TextSlowking_3OrbsObtained
	jr .printAndEnd
.orbs2
	ld hl, Route29TextSlowking_2OrbsObtained
	jr .printAndEnd
.orbs1
	ld hl, Route29TextSlowking_1OrbsObtained
	jr .printAndEnd
.orbs0
	ld hl, Route29TextSlowking_0OrbsObtained
.printAndEnd
	call PrintText
	jp TextScriptEnd

Route29TextSlowking_SummoningHappened:
	text_far _Route29TextSlowking_SummoningHappened
	text_end

Route29TextSlowking_3OrbsObtained:
	text_far _Route29TextSlowking_3OrbsObtained
	text_end

Route29TextSlowking_2OrbsObtained:
	text_far _Route29TextSlowking_2OrbsObtained
	text_end

Route29TextSlowking_1OrbsObtained:
	text_far _Route29TextSlowking_1OrbsObtained
	text_end

Route29TextSlowking_0OrbsObtained:
	text_far _Route29TextSlowking_0OrbsObtained
	text_end

; signs ----------------------

Route29TextIceOrbRecess:
	text_asm
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr nz, .alreadyPlacedAllOrbs
	CheckEvent EVENT_PLACED_ICE_ORB_IN_RECESS
	jr nz, .alreadyPlacedThisOrb
	ld b, ICE_ORB
	call IsItemInBag
	jr nz, .haveIceOrb
	ld hl, Route29TextIceOrbRecess_NotPlacedNotInBag
	call PrintText
	jr .done
.haveIceOrb
	ld hl, Route29TextIceOrbRecess_PlaceThisOrb
	call PrintText
	ld a, ICE_ORB
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_PLACED_ICE_ORB_IN_RECESS
	CheckEvent EVENT_PLACED_THUNDER_ORB_IN_RECESS
	jr z, .done
	CheckEvent EVENT_PLACED_FIRE_ORB_IN_RECESS
	jr z, .done
	SetEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	ld a, 3 ; Route29Script_PlacedAllOrbs1
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	jr .done
.alreadyPlacedThisOrb
	ld hl, Route29TextIceOrbRecess_AlreadyPlacedThisOrb
	call PrintText
	jr .done
.alreadyPlacedAllOrbs
	ld hl, Route29TextIceOrbRecess_AlreadyPlacedAllOrbs
	call PrintText
.done
	jp TextScriptEnd

Route29TextIceOrbRecess_NotPlacedNotInBag:
	text_far _Route29TextIceOrbRecess_NotPlacedNotInBag
	text_end

Route29TextIceOrbRecess_PlaceThisOrb:
	text_far _Route29TextIceOrbRecess_PlaceThisOrb
	text_end

Route29TextIceOrbRecess_AlreadyPlacedThisOrb:
	text_far _Route29TextIceOrbRecess_AlreadyPlacedThisOrb
	text_end

Route29TextIceOrbRecess_AlreadyPlacedAllOrbs:
	text_far _Route29TextIceOrbRecess_AlreadyPlacedAllOrbs
	text_end

; ---------------

Route29TextThunderOrbRecess:
	text_asm
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr nz, .alreadyPlacedAllOrbs
	CheckEvent EVENT_PLACED_THUNDER_ORB_IN_RECESS
	jr nz, .alreadyPlacedThisOrb
	ld b, THUNDER_ORB
	call IsItemInBag
	jr nz, .haveThunderOrb
	ld hl, Route29TextThunderOrbRecess_NotPlacedNotInBag
	call PrintText
	jr .done
.haveThunderOrb
	ld hl, Route29TextThunderOrbRecess_PlaceThisOrb
	call PrintText
	ld a, THUNDER_ORB
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_PLACED_THUNDER_ORB_IN_RECESS
	CheckEvent EVENT_PLACED_ICE_ORB_IN_RECESS
	jr z, .done
	CheckEvent EVENT_PLACED_FIRE_ORB_IN_RECESS
	jr z, .done
	SetEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	ld a, 3 ; Route29Script_PlacedAllOrbs1
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	jr .done
.alreadyPlacedThisOrb
	ld hl, Route29TextThunderOrbRecess_AlreadyPlacedThisOrb
	call PrintText
	jr .done
.alreadyPlacedAllOrbs
	ld hl, Route29TextThunderOrbRecess_AlreadyPlacedAllOrbs
	call PrintText
.done
	jp TextScriptEnd

Route29TextThunderOrbRecess_NotPlacedNotInBag:
	text_far _Route29TextThunderOrbRecess_NotPlacedNotInBag
	text_end

Route29TextThunderOrbRecess_PlaceThisOrb:
	text_far _Route29TextThunderOrbRecess_PlaceThisOrb
	text_end

Route29TextThunderOrbRecess_AlreadyPlacedThisOrb:
	text_far _Route29TextThunderOrbRecess_AlreadyPlacedThisOrb
	text_end

Route29TextThunderOrbRecess_AlreadyPlacedAllOrbs:
	text_far _Route29TextThunderOrbRecess_AlreadyPlacedAllOrbs
	text_end

; ---------------

Route29TextFireOrbRecess:
	text_asm
	CheckEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	jr nz, .alreadyPlacedAllOrbs
	CheckEvent EVENT_PLACED_FIRE_ORB_IN_RECESS
	jr nz, .alreadyPlacedThisOrb
	ld b, FIRE_ORB
	call IsItemInBag
	jr nz, .haveFireOrb
	ld hl, Route29TextFireOrbRecess_NotPlacedNotInBag
	call PrintText
	jr .done
.haveFireOrb
	ld hl, Route29TextFireOrbRecess_PlaceThisOrb
	call PrintText
	ld a, FIRE_ORB
	ldh [hItemToRemoveID], a
	farcall RemoveItemByID
	SetEvent EVENT_PLACED_FIRE_ORB_IN_RECESS
	CheckEvent EVENT_PLACED_THUNDER_ORB_IN_RECESS
	jr z, .done
	CheckEvent EVENT_PLACED_ICE_ORB_IN_RECESS
	jr z, .done
	SetEvent EVENT_PLACED_ALL_ORBS_IN_RECESSES
	ld a, 3 ; Route29Script_PlacedAllOrbs1
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	jr .done
.alreadyPlacedThisOrb
	ld hl, Route29TextFireOrbRecess_AlreadyPlacedThisOrb
	call PrintText
	jr .done
.alreadyPlacedAllOrbs
	ld hl, Route29TextFireOrbRecess_AlreadyPlacedAllOrbs
	call PrintText
.done
	jp TextScriptEnd

Route29TextFireOrbRecess_NotPlacedNotInBag:
	text_far _Route29TextFireOrbRecess_NotPlacedNotInBag
	text_end

Route29TextFireOrbRecess_PlaceThisOrb:
	text_far _Route29TextFireOrbRecess_PlaceThisOrb
	text_end

Route29TextFireOrbRecess_AlreadyPlacedThisOrb:
	text_far _Route29TextFireOrbRecess_AlreadyPlacedThisOrb
	text_end

Route29TextFireOrbRecess_AlreadyPlacedAllOrbs:
	text_far _Route29TextFireOrbRecess_AlreadyPlacedAllOrbs
	text_end

; ---------------

Route29TextRuin1:
	text_far _Route29TextRuin1
	text_end

Route29TextRuin2:
	text_far _Route29TextRuin2
	text_end

Route29TextRuin3:
	text_far _Route29TextRuin3
	text_end

Route29TextRuin4:
	text_far _Route29TextRuin4
	text_end

Route29TextRuin5:
	text_far _Route29TextRuin5
	text_end

; ---------------

Route29TextOrbsVanish1:
	text_far _Route29TextOrbsVanish1
	text_end

Route29TextOrbsVanish2:
	text_far _Route29TextOrbsVanish2
	text_end
