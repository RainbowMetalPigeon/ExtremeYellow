SeviiOneIslandGym2_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiOneIslandGym2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

SeviiOneIslandGym2_ScriptPointers:
	dw SeviiOneIslandGym2Script0
	dw SeviiOneIslandGym2ScriptPostBattle

SeviiOneIslandGym2Script0:
	ret

SeviiOneIslandGym2ScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .playerWon
; if we lost
	ld a, 3 ; if we lost ; map-specific
	jr .commonPart
.playerWon
	SetEvent EVENT_DEFEATED_SEVII_SAGE_ICHINO ; map-specific
	ld a, 2 ; map-specific
.commonPart
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wIsTrainerBattle], a
	ld [wCurMapScript], a
; warp player back to entrance
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_ONE_ISLAND_GYM_1 ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret

; ===============================

SeviiOneIslandGym2_TextPointers:
	dw SeviiOneIslandGym2Text1
	; scripts
	dw SeviiOneIslandGym2Text3_Victory ; 2
	dw SeviiOneIslandGym2Text3_Defeat ; 3

SeviiOneIslandGym2Text1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiOneIslandGym2Text1_NoChampionYet
	jp z, .printAndEnd

	ld hl, SeviiOneIslandGym2Text1_Intro
	call PrintText
; check if team is valid for reward
	callfar CheckIfTeamValidForSeviiSagesRewards ; output: c flag if "invalid"
	jr nc, .setUpBattle
; ask the player if they actually wanna fight
	call WaitForTextScrollButtonPress
	ld hl, SeviiOneIslandGym2Text1_NoRewardWannaFight
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .yesBattle
; player refuses to battle
	ld hl, SeviiOneIslandGym2Text1_NoRewardNoFight
	jr .printAndEnd
.yesBattle
	ld hl, SeviiOneIslandGym2Text1_NoRewardYesFight
	call PrintText
; fallthrough
.setUpBattle
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl] ; turn on battle animations
	set 6, [hl] ; battle style set
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

SeviiOneIslandGym2Text1_NoChampionYet:
	text_far _SeviiOneIslandGym2Text1_NoChampionYet
	text_end

SeviiOneIslandGym2Text1_Intro:
	text_far _SeviiOneIslandGym2Text1_Intro
	text_end

SeviiOneIslandGym2Text1_NoRewardWannaFight:
	text_far _SeviiIslandGymText_NoRewardWannaFight
	text_end

SeviiOneIslandGym2Text1_NoRewardNoFight:
	text_far _SeviiIslandGymText_NoRewardNoFight
	text_end

SeviiOneIslandGym2Text1_NoRewardYesFight:
	text_far _SeviiIslandGymText_NoRewardYesFight
	text_end

IchinoText_PostBattleText:
	text_far _IchinoText_PostBattleText
	text_end

SeviiOneIslandGym2Text3_Victory:
	text_far _SeviiOneIslandGym2Text3_Victory
	text_end

SeviiOneIslandGym2Text3_Defeat:
	text_far _SeviiOneIslandGym2Text3_Defeat
	text_end
