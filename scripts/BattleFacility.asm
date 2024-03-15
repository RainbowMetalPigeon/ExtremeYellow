BattleFacility_Script:
	call EnableAutoTextBoxDrawing
;	ld hl, BattleFacilityTrainerHeaders
	ld de, BattleFacility_ScriptPointers
	ld a, [wBattleFacilityCurScript]
	call ExecuteCurMapScriptInTable
	ld [wBattleFacilityCurScript], a
	ret

; =====================================

BattleFacility_ScriptPointers:
	dw BattleFacilityScript0 ; 0
	dw BattleFacilityScript_PostBattle ; 1, TBE?

BattleFacilityScript0:
	ret

BattleFacilityScript_PostBattle:
; reset level scaling as chosen by the player
	ld a, [wLevelScalingBackup]
	ld [wLevelScaling], a
	ld a, [wIsInBattle]
; check battle result
	cp $ff
	jr nz, .notDefeated
; we have been defeated
	xor a
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
; do all the other things we need to do if we lost, like reset the streak
	xor a
	ld [wBattleFacilityWinningStreak], a
; avoid losing money, set special respawn point

	ret

.notDefeated ; we won
	ld a, 3 ; TBE
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; increase win streak
	ld a, [wBattleFacilityWinningStreak]
	inc a
	ld [wBattleFacilityWinningStreak], a ; TBE: this needs to be set to 0 after we finish the 7-battle streak

; move BF trainer out and in again

; re-block commands?

; script handling
	ld a, 0 ; TBE
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a

	ret

; =====================================

BattleFacility_TextPointers:
	dw BattleFacilityText1 ; guide
	dw BattleFacilityText2 ; opponent
	; other NPCs' texts
; non-NPCs texts
	dw BattleFacilityExtraText1 ; 3, TBE

BattleFacilityText1:
	text_far _BattleFacilityText1
	text_end
	
; NPCs texts --------------------------

BattleFacilityText2:
	text_asm
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic
; print intro text
	ld hl, BattleFacilityText2_Intro
	call PrintText
; they seem to do nothing?
.proxyLabel
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
; Turn on battle animations to make the battle feel more epic
	res 7, [hl]
; handle all wram variables needed for randomization
	xor a
	ld [wBattleFacilityWhichMonIsRandomized], a
	ld [wBattleFacilityMonNumber1], a
	ld [wBattleFacilityMonNumber2], a
	ld [wBattleFacilityMonNumber3], a
	ld [wBattleFacilityMonNumber4], a
	ld [wBattleFacilityMonNumber5], a
; backup the current Level Scaling option choice to restore it after the battle, and set up the level scaling
	ld a, [wLevelScaling]
	ld [wLevelScalingBackup], a
	ld a, 1
	ld [wLevelScaling], a
; set opponent
	call Delay3
	ld a, OPP_BF_TRAINER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
; end-of-battle text
	ld hl, BattleFacilityText2_PostBattle
	ld de, BattleFacilityText2_PostBattle
	call SaveEndBattleTextPointers
; script handling
	ld a, 1 ; BattleFacilityScript_PostBattle, number TBE
	ld [wBattleFacilityCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

BattleFacilityText2_Intro:
	text_far _BattleFacilityText2_Intro
	text_end
	
BattleFacilityText2_PostBattle:
	text_far _BattleFacilityText2_PostBattle
	text_end
	
; -------------------------------------

; non-NPCs texts ----------------------

BattleFacilityExtraText1:
	text_far _BattleFacilityExtraText1
	text_end
