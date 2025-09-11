SeviiThreeIslandGym_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiThreeIslandGym_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiThreeIslandGym_ScriptPointers:
	dw SeviiThreeIslandGymScript0
	dw SeviiThreeIslandGymScriptPostBattle

SeviiThreeIslandGymScript0:
	ret

SeviiThreeIslandGymScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_SANTRE
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiThreeIslandGym_TextPointers:
	dw SeviiThreeIslandGymText1
	dw SeviiThreeIslandGymText2
	; scripts
	dw SeviiThreeIslandGymText3_Victory

SeviiThreeIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiThreeIslandGymText1_NoChampionYet
	jp z, .printAndEnd

	ld hl, SeviiThreeIslandGymText1_Intro
	call PrintText
	call WaitForTextScrollButtonPress
	callfar CheckIfAllMonsShareAType ; d and/or e contain the shared type, otherwise, $FF

; find if and which type is shared, and if both are, choose at random
	ld a, d
	cp $FF
	jr nz, .type1NotNull
; type 1 null, check type 2
	ld a, e
	cp $FF
	ld hl, SeviiThreeIslandGymText1_NoSharedTypes
	jr z, .printAndEnd
; type 1 null, type 2 valid
.oneMatchFound ; the (possibly chosen out of the 2 different valid ones) type is in a
	ld [wMultipurposeBuffer], a
	ld d, a
	callfar StoreTypeInwTrainerName
	ld hl, SeviiThreeIslandGymText1_SharedTypes
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiThreeIslandGymText1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiThreeIslandGymText1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiThreeIslandGymText1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, SantreText_PostBattleText
	ld de, SantreText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_SANTRE
	ld [wCurOpponent], a

	ld a, [wMultipurposeBuffer]
	cp 13 ; between physical and special types
	jr c, .physical
; special type
	sub 10
.physical
	inc a
	ld [wTrainerNo], a

	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

.type1NotNull
	cp e
	jr z, .oneMatchFound ; type1=type2
	ld a, e
	cp $FF
	ld a, d ; load correct value in a in case e=$FF so we're ready for the .oneMatchFound
	jr z, .oneMatchFound
; if here: $FF!=type1!=type2!=$FF, pick one at random
	call Random
	cp 50 percent
	ld a, d
	jr c, .oneMatchFound
	ld a, e
	jr .oneMatchFound

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandGymText1_NoChampionYet:
	text_far _SeviiThreeIslandGymText1_NoChampionYet
	text_end

SeviiThreeIslandGymText1_Intro:
	text_far _SeviiThreeIslandGymText1_Intro
	text_end

SeviiThreeIslandGymText1_SharedTypes:
	text_far _SeviiThreeIslandGymText1_SharedTypes
	text_end

SeviiThreeIslandGymText1_NoSharedTypes:
	text_far _SeviiThreeIslandGymText1_NoSharedTypes
	text_end

SeviiThreeIslandGymText2:
	text_far _SeviiThreeIslandGymText2
	text_end

SeviiThreeIslandGymText1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiThreeIslandGymText1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiThreeIslandGymText1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

SantreText_PostBattleText:
	text_far _SantreText_PostBattleText
	text_end

SeviiThreeIslandGymText3_Victory:
	text_far _SeviiThreeIslandGymText3_Victory
	text_end
