SeviiOneIslandGym_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiOneIslandGym_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiOneIslandGym_ScriptPointers:
	dw SeviiOneIslandGymScript0
	dw SeviiOneIslandGymScriptPostBattle

SeviiOneIslandGymScript0:
	ret

SeviiOneIslandGymScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_ICHINO
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiOneIslandGym_TextPointers:
	dw SeviiOneIslandGymText1
	dw SeviiOneIslandGymText2
	; scripts
	dw SeviiOneIslandGymText3_Victory

SeviiOneIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiOneIslandGymText1_NoChampionYet
	jp z, .printAndEnd

	ld hl, SeviiOneIslandGymText1_Intro
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiOneIslandGymText1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiOneIslandGymText1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiOneIslandGymText1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, IchinoText_PostBattleText
	ld de, IchinoText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_ICHINO
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

SeviiOneIslandGymText1_NoChampionYet:
	text_far _SeviiOneIslandGymText1_NoChampionYet
	text_end

SeviiOneIslandGymText1_Intro:
	text_far _SeviiOneIslandGymText1_Intro
	text_end

SeviiOneIslandGymText2:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiOneIslandGymText2_PreLeague
	jr z, .printAndEnd
	ld hl, SeviiOneIslandGymText2_PostLeague
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandGymText2_PreLeague:
	text_far _SeviiOneIslandGymText2_PreLeague
	text_end

SeviiOneIslandGymText2_PostLeague:
	text_far _SeviiOneIslandGymText2_PostLeague
	text_end

SeviiOneIslandGymText1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiOneIslandGymText1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiOneIslandGymText1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

IchinoText_PostBattleText:
	text_far _IchinoText_PostBattleText
	text_end

SeviiOneIslandGymText3_Victory:
	text_far _SeviiOneIslandGymText3_Victory
	text_end
