SeviiSixIslandGym3_Script:
	call ApplyMalusOnEntry3
	call EnableAutoTextBoxDrawing
	ld de, SeviiSixIslandGym3_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; ===============================

ApplyMalusOnEntry3:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	SetEvent EVENT_BATTLE_CAN_BE_LOST ; for overworld death to poison
	ld a, [wXCoord]
; Web room?
	cp 10 ; between Web room and FRZ room
	jr nc, .checkFRZRoom
	ld a, [wUniQuizAnswer+9]
	and a
	ret nz
	inc a
	ld [wUniQuizAnswer+9], a
	ld a, 6
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkFRZRoom
; preliminary check
	call CheckIfAllMonsAreStatused ; z flag if at least 1 mon is NOT statused
	ret nz
; now, normal checks
	ld a, [wXCoord] ; need to be reloaded because was overwritten above
	cp 24
	jr nc, .checkSLPRoom
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	set FRZ, [hl]
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.checkSLPRoom
	ld a, [wXCoord] ; need to be reloaded because was overwritten above
	cp 38
	ret nc ; Rokusei room
	call FindARandomNonStatusedPokemon ; hl now points to a non-statused mon
	call Random
	and %00000111
	ld [hl], a ; apply SLP, which is different from the other statuses as the value itself is the number of turns it'll last
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

SeviiSixIslandGym3_ScriptPointers:
	dw SeviiSixIslandGym3Script0
	dw SeviiSixIslandGym3ScriptPostBattle

SeviiSixIslandGym3Script0:
	ld a, [wIsInBattle]
	cp $ff
	ret nz
; we have been defeated (all mons fainted, due to poison)
	ld a, 10 ; SeviiSixIslandGym3Text10_PostBlackout
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

SeviiSixIslandGym3ScriptPostBattle:
	xor a
	ld [wCurMapScript], a
; check battle result
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .playerWon
; if we lost
	ld a, 9 ; if we lost ; map-specific
	jr .commonPart
.playerWon
	SetEvent EVENT_DEFEATED_SEVII_SAGE_ROKUSEI ; map-specific
	ld a, 5 ; map-specific
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
	ld a, SEVII_SIX_ISLAND_GYM_1 ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	ret

; ===============================

SeviiSixIslandGym3_TextPointers:
	dw SeviiSixIslandGym3Text1
	; signs
	dw SeviiSixIslandGym3SignText1
	dw SeviiSixIslandGym3SignText2
	dw SeviiSixIslandGym3SignText3
	; scripts
	dw SeviiSixIslandGym3Text5_Victory ; 5
	dw SeviiSixIslandGym3PopUpMessageWeb ; 6
	dw SeviiSixIslandGym3PopUpMessageFrozen ; 7
	dw SeviiSixIslandGym3PopUpMessageSleep ; 8
	dw SeviiSixIslandGym3Text9_Defeat ; 9
	dw SeviiSixIslandGym3Text10_PostBlackout ; 10

SeviiSixIslandGym3Text1:
	text_asm
	ld hl, SeviiSixIslandGym3Text1_Intro
	call PrintText
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	SetEvent EVENT_ENGAGED_ROKUSEI
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

RokuseiText_PostBattleText:
	text_far _RokuseiText_PostBattleText
	text_end

SeviiSixIslandGym3Text5_Victory:
	text_far _SeviiSixIslandGym3Text5_Victory
	text_end

SeviiSixIslandGym3Text9_Defeat:
	text_far _SeviiSixIslandGym3Text9_Defeat
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

SeviiSixIslandGym3PopUpMessageWeb:
	text_far _SeviiSixIslandGym3PopUpMessageWeb
	text_end

SeviiSixIslandGym3PopUpMessageFrozen:
	text_far _SeviiSixIslandGym3PopUpMessageFrozen
	text_end

SeviiSixIslandGym3PopUpMessageSleep:
	text_far _SeviiSixIslandGym3PopUpMessageSleep
	text_end

SeviiSixIslandGym3Text10_PostBlackout:
	text_far _SeviiSixIslandGymTextBlackout
	text_end

; ----------------------------------

LoadStatModifiersForRokusei::
	ld hl, wUniQuizAnswer
	ld de, wPlayerMonAttackMod ; = wPlayerMonStatMods
	ld bc, 6
	jp CopyData ; copies bc bytes from hl to de
