SeviiSixIslandGym3_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiSixIslandGym3_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiSixIslandGym3_ScriptPointers:
	dw SeviiSixIslandGym3Script0
	dw SeviiSixIslandGym3ScriptPostBattle

SeviiSixIslandGym3Script0:
	ret

SeviiSixIslandGym3ScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_ROKUSEI
	ld a, 5
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiSixIslandGym3_TextPointers:
	dw SeviiSixIslandGym3Text1
	; signs
	dw SeviiSixIslandGym3SignText1
	dw SeviiSixIslandGym3SignText2
	dw SeviiSixIslandGym3SignText3
	; scripts
	dw SeviiSixIslandGym3Text5_Victory
	text_end

SeviiSixIslandGym3Text1:
	text_asm
	ld hl, SeviiSixIslandGym3Text1_Intro
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiSixIslandGym3Text1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiSixIslandGym3Text1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiSixIslandGym3Text1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, RokuseiText_PostBattleText
	ld de, RokuseiText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_ROKUSEI
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	xor a
	ldh [hJoyHeld], a
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiSixIslandGym3Text1_Intro:
	text_far _SeviiSixIslandGym3Text1_Intro
	text_end

SeviiSixIslandGym3Text1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiSixIslandGym3Text1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiSixIslandGym3Text1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

RokuseiText_PostBattleText:
	text_far _RokuseiText_PostBattleText
	text_end

SeviiSixIslandGym3Text5_Victory:
	text_far _SeviiSixIslandGym3Text5_Victory
	text_end

SeviiSixIslandGym3SignText1:
	text_far _SeviiSixIslandGym3SignText1
	text_end

SeviiSixIslandGym3SignText2:
	text_far _SeviiSixIslandGym3SignText2
	text_end

SeviiSixIslandGym3SignText3:
	text_far _SeviiSixIslandGym3SignText3
	text_end

