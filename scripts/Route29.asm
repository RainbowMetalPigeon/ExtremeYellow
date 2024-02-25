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
	ld a, 6 ; TBE, Route29TextOrbsVanish1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call GBFadeOutToBlack
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
	call GBFadeInFromBlack
	ld a, 4 ; Route29Script_PlacedAllOrbs2
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	ret

Route29Script_PlacedAllOrbs2:
	ld a, 7 ; TBE, Route29TextOrbsVanish2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 0
	ld [wRoute29CurScript], a
	ld [wCurMapScript], a
	ret

Route29_TextPointers:
	; trainers
	dw Route29Text1                ; 1
	; non-trainers
	dw Route29TextSlowking         ; 2
	; signs
	dw Route29TextIceOrbRecess     ; 3
	dw Route29TextThunderOrbRecess ; 4
	dw Route29TextFireOrbRecess    ; 5
	; non-NPCs/signs
	dw Route29TextOrbsVanish1      ; 6
	dw Route29TextOrbsVanish2      ; 7

Route29TrainerHeaders:
	def_trainers
Route29TrainerHeader0:
	trainer EVENT_BEAT_ROUTE_29_TRAINER_0, 0, Route29BattleText1, Route29EndBattleText1, Route29AfterBattleText1
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
	text_far _Route29AfterBattleText1
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

Route29TextOrbsVanish1:
	text_far _Route29TextOrbsVanish1
	text_end

Route29TextOrbsVanish2:
	text_far _Route29TextOrbsVanish2
	text_end
