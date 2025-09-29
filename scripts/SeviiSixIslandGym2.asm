SeviiSixIslandGym2_Script:
	call ApplyMalusOnEntry2
	call EnableAutoTextBoxDrawing
	ld de, SeviiSixIslandGym2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiSixIslandGym2_ScriptPointers:
	dw SeviiSixIslandGym2Script0

SeviiSixIslandGym2Script0:
	ld a, [wIsInBattle]
	cp $ff
	ret nz
; we have been defeated (all mons fainted, due to poison)
	ld a, 13 ; SeviiSixIslandGym2Text13_PostBlackout
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_SIX_ISLAND_GYM_1
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret

ApplyMalusOnEntry2:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	SetEvent EVENT_BATTLE_CAN_BE_LOST ; for overworld death to poison
	ld a, [wXCoord]
; Rock room?
	cp 10 ; between Rock room and Spikes room
	jr nc, .checkSpikesRoom
	ld a, [wUniQuizAnswer+6]
	and a
	ret nz
	inc a
	ld [wUniQuizAnswer+6], a
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkSpikesRoom
	cp 24
	jr nc, .checkToxicSpikesRoom
	ld a, [wUniQuizAnswer+7]
	cp 3
	ret z
	inc a
	ld [wUniQuizAnswer+7], a
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkToxicSpikesRoom
	ld a, [wXCoord] ; need to be reloaded because was overwritten above
	cp 38
	jr nc, .checkConfusionRoom
	ld a, [wUniQuizAnswer+8]
	cp 2
	ret z
	inc a
	ld [wUniQuizAnswer+8], a
	ld a, 9
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkConfusionRoom
	cp 52
	jr nc, .checkSeedsRoom
	ld hl, wPlayerBattleStatus1
	bit CONFUSED, [hl]
	ret nz
	set CONFUSED, [hl]
	call Random
	and $3
	inc a
	inc a
	ld [wPlayerConfusedCounter], a ; confusion status will last 2-5 turns
	ld a, 10
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkSeedsRoom
	cp 66
	jr nc, .curseRoom
	ld hl, wPlayerBattleStatus2
	bit SEEDED, [hl]
	ret nz
	set SEEDED, [hl]
	ld a, 11
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.curseRoom
	ld hl, wPlayerBattleStatus2
	bit BEING_CURSED, [hl]
	ret nz
	set BEING_CURSED, [hl]
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

SeviiSixIslandGym2_TextPointers:
	; signs
	dw SeviiSixIslandGym2SignText1
	dw SeviiSixIslandGym2SignText2
	dw SeviiSixIslandGym2SignText3
	dw SeviiSixIslandGym2SignText4
	dw SeviiSixIslandGym2SignText5
	dw SeviiSixIslandGym2SignText6
	; scripts
	dw SeviiSixIslandGym2PopUpMessageRock ; 7
	dw SeviiSixIslandGym2PopUpMessageSpikes ; 8
	dw SeviiSixIslandGym2PopUpMessageToxicSpikes ; 9
	dw SeviiSixIslandGym2PopUpMessageConfusion ; 10
	dw SeviiSixIslandGym2PopUpMessageSeeds ; 11
	dw SeviiSixIslandGym2PopUpMessageCurse ; 12
	dw SeviiSixIslandGym2Text13_PostBlackout ; 13

SeviiSixIslandGym2SignText1:
	text_far _SeviiSixIslandGym2SignText1
	text_end

SeviiSixIslandGym2SignText2:
	text_far _SeviiSixIslandGym2SignText2
	text_end

SeviiSixIslandGym2SignText3:
	text_far _SeviiSixIslandGym2SignText3
	text_end

SeviiSixIslandGym2SignText4:
	text_far _SeviiSixIslandGym2SignText4
	text_end

SeviiSixIslandGym2SignText5:
	text_far _SeviiSixIslandGym2SignText5
	text_end

SeviiSixIslandGym2SignText6:
	text_far _SeviiSixIslandGym2SignText6
	text_end

SeviiSixIslandGym2PopUpMessageRock:
	text_far _SeviiSixIslandGym2PopUpMessageRock
	text_end

SeviiSixIslandGym2PopUpMessageSpikes:
	text_far _SeviiSixIslandGym2PopUpMessageSpikes
	text_end

SeviiSixIslandGym2PopUpMessageToxicSpikes:
	text_far _SeviiSixIslandGym2PopUpMessageToxicSpikes
	text_end

SeviiSixIslandGym2PopUpMessageConfusion:
	text_far _SeviiSixIslandGym2PopUpMessageConfusion
	text_end

SeviiSixIslandGym2PopUpMessageSeeds:
	text_far _SeviiSixIslandGym2PopUpMessageSeeds
	text_end

SeviiSixIslandGym2PopUpMessageCurse:
	text_far _SeviiSixIslandGym2PopUpMessageCurse
	text_end

SeviiSixIslandGym2Text13_PostBlackout:
	text_far _SeviiSixIslandGymTextBlackout
	text_end
