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
	jr nz, .playerWon
; if we lost
	ld a, 4 ; if we lost ; map-specific
	jr .commonPart
.playerWon
	CheckEvent EVENT_DO_NOT_ALLOW_FOR_SAGE_WIN_RECORDING
	jr nz, .doNotRecordVictory
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE ; map-specific
	ld a, 3 ; map-specific
	jr nz, .commonPart
	SetEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE ; map-specific
	SetEvent EVENT_SEVII_BEAT_AT_LEAST_ONE_SHRINE_SAGE
	callfar HideUndegroundGuard
	ld a, 3 ; map-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 5 ; map-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 6 ; map-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 7 ; map-specific
	jr .commonPart
.doNotRecordVictory
	ld a, 3 ; map-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, 8 ; map-specific
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
	ld a, SEVII_FIVE_ISLAND_GYM ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret

; ===============================

SeviiFiveIslandGym_TextPointers:
	dw SeviiFiveIslandGymText1
	dw SeviiFiveIslandGymText2
	; scripts
	dw SeviiFiveIslandGymText3_Victory ; 3
	dw SeviiFiveIslandGymText4_Defeat ; 4
	dw SeviiFiveIslandGymText4_Reward1 ; 5
	dw SeviiFiveIslandGymText4_Reward2 ; 6
	dw SeviiFiveIslandGymText4_Reward3 ; 7
	dw SeviiFiveIslandGymText4_NoReward ; 8

SeviiFiveIslandGymText1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiFiveIslandGymText1_NoChampionYet
	jp z, .printAndEnd

	ResetEvent EVENT_DO_NOT_ALLOW_FOR_SAGE_WIN_RECORDING
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
	SetEvent EVENT_DO_NOT_ALLOW_FOR_SAGE_WIN_RECORDING
	ld hl, SeviiFiveIslandGymText1_NoRewardYesFight
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

SeviiFiveIslandGymText4_Defeat:
	text_far _SeviiFiveIslandGymText4_Defeat
	text_end

SeviiFiveIslandGymText4_Reward1:
	text_far _SeviiFiveIslandGymText4_Reward1
	text_end

SeviiFiveIslandGymText4_Reward2:
	text_far _SeviiFiveIslandGymText4_Reward2
	sound_get_key_item
	text_end

SeviiFiveIslandGymText4_Reward3:
	text_far _SeviiFiveIslandGymText4_Reward3
	text_end

SeviiFiveIslandGymText4_NoReward:
	text_far _SeviiFiveIslandGymText4_NoReward
	text_end
