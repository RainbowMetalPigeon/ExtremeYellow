SeviiFourIslandGym_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiFourIslandGym_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiFourIslandGym_ScriptPointers:
	dw SeviiFourIslandGymScript0
	dw SeviiFourIslandGymScriptPostBattle

SeviiFourIslandGymScript0:
	ret

SeviiFourIslandGymScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr z, .gotDefeated
; if you won
	xor a
	ld [wIsTrainerBattle], a
	SetEvent EVENT_DEFEATED_SEVII_SAGE_YOTTRO
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.gotDefeated ; TBE, modify defeat system to make this an "ok-to-lose battle"
	ret

; ===============================

SeviiFourIslandGym_TextPointers:
	dw SeviiFourIslandGymText1
	dw SeviiFourIslandGymText2
	; scripts
	dw SeviiFourIslandGymText3_Victory

SeviiFourIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiFourIslandGymText1_NoChampionYet
	jp z, .printAndEnd

	ld hl, SeviiFourIslandGymText1_Intro
	call PrintText
	call WaitForTextScrollButtonPress
	callfar CheckIfAllMovesAreStatusMoves ; output: nz flag if team contains a non-status move
	jr z, .allowedTeam
; team not ok
	ld hl, SeviiFourIslandGymText1_DamagingMoves
	jr .printAndEnd
.allowedTeam ; the (possibly chosen out of the 2 different valid ones) type is in a
	ld hl, SeviiFourIslandGymText1_OnlyStatusMoves ; TBE
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiFourIslandGymText1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiFourIslandGymText1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiFourIslandGymText1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, YottroText_PostBattleText
	ld de, YottroText_PostBattleText
	call SaveEndBattleTextPointers
	ld a, OPP_YOTTRO
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

SeviiFourIslandGymText1_NoChampionYet:
	text_far _SeviiFourIslandGymText1_NoChampionYet
	text_end

SeviiFourIslandGymText1_Intro:
	text_far _SeviiFourIslandGymText1_Intro
	text_end

SeviiFourIslandGymText1_OnlyStatusMoves:
	text_far _SeviiFourIslandGymText1_OnlyStatusMoves
	text_end

SeviiFourIslandGymText1_DamagingMoves:
	text_far _SeviiFourIslandGymText1_DamagingMoves
	text_end

SeviiFourIslandGymText2:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiFourIslandGymText2_PreLeague
	jr z, .printAndEnd
	ld hl, SeviiFourIslandGymText2_PostLeague
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandGymText2_PreLeague:
	text_far _SeviiFourIslandGymText2_PreLeague
	text_end

SeviiFourIslandGymText2_PostLeague:
	text_far _SeviiFourIslandGymText2_PostLeague
	text_end

SeviiFourIslandGymText1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiFourIslandGymText1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiFourIslandGymText1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

YottroText_PostBattleText:
	text_far _YottroText_PostBattleText
	text_end

SeviiFourIslandGymText3_Victory:
	text_far _SeviiFourIslandGymText3_Victory
	text_end
