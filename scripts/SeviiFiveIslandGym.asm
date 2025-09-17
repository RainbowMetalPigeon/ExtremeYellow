SeviiFiveIslandGym_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiFiveIslandGym_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiFiveIslandGym_ScriptPointers:
	dw SeviiFiveIslandGymScript0
	dw SeviiFiveIslandGymScriptPostBattle

SeviiFiveIslandGymScript0:
	ret

SeviiFiveIslandGymScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiFiveIslandGym_TextPointers:
	dw SeviiFiveIslandGymText1
	dw SeviiFiveIslandGymText2
	; scripts
	dw SeviiFiveIslandGymText3_Victory

SeviiFiveIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiFiveIslandGymText1_NoChampionYet
	jp z, .printAndEnd

	ld hl, SeviiFiveIslandGymText1_Intro
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiFiveIslandGymText1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiFiveIslandGymText1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiFiveIslandGymText1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, GonqueText_PostBattleText
	ld de, GonqueText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_GONQUE
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

SeviiFiveIslandGymText1_NoChampionYet:
	text_far _SeviiFiveIslandGymText1_NoChampionYet
	text_end

SeviiFiveIslandGymText1_Intro:
	text_far _SeviiFiveIslandGymText1_Intro
	text_end

SeviiFiveIslandGymText2:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiFiveIslandGymText2_PreLeague
	jr z, .printAndEnd
	ld hl, SeviiFiveIslandGymText2_PostLeague
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandGymText2_PreLeague:
	text_far _SeviiFiveIslandGymText2_PreLeague
	text_end

SeviiFiveIslandGymText2_PostLeague:
	text_far _SeviiFiveIslandGymText2_PostLeague
	text_end

SeviiFiveIslandGymText1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiFiveIslandGymText1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiFiveIslandGymText1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

GonqueText_PostBattleText:
	text_far _GonqueText_PostBattleText
	text_end

SeviiFiveIslandGymText3_Victory:
	text_far _SeviiFiveIslandGymText3_Victory
	text_end
