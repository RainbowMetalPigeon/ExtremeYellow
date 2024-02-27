CeladonMansion2F_Script:
	call EnableAutoTextBoxDrawing
	ld de, CeladonMansion2F_ScriptPointers
	ld a, [wCeladonMansion2FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeladonMansion2FCurScript], a
	ret

CeladonMansion2F_ScriptPointers:
	dw CeladonMansion2FScript0
	dw CeladonMansion2FScript1 ; post-battle

CeladonMansion2FScript0:
	ret

CeladonMansion2FScript1:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	jr .endScript
.notDefeated
; give piece of Map if not already done
	CheckEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	jr z, .noPieceObtained
; piece already obtained
	ld a, 13 ; TBE, normal dialogue, map-unrelated
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jr .endScript
.noPieceObtained
	ld a, 14 ; TBE, pre-give map piece
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_OBTAIN_ANY_MAP_PIECE
	jr nz, .alreadyHaveAPiece
; first piece we obtain
	lb bc, MYSTERY_MAP, 1
	call GiveItem
	jr c, .alreadyHaveAPiece
; bag is full
	SetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON_FAILED
	ld a, 16 ; TBE, failed to obtain map piece (bag full)
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	jr .endScript
.alreadyHaveAPiece
	SetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	SetEvent EVENT_OBTAIN_ANY_MAP_PIECE
	ResetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON_FAILED
	ld a, 15 ; TBE, successfully given a piece
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
.endScript
	xor a
	ld [wCeladonMansion2FCurScript], a
	ld [wCurMapScript], a
	ret

; =========================

CeladonMansion2F_TextPointers:
	; NPCs
	dw CeladonMansion2Text1
	dw CeladonMansion2Text2
	dw CeladonMansion2Text3
	dw CeladonMansion2Text4
	dw CeladonMansion2Text5
	dw CeladonMansion2Text6
	dw CeladonMansion2Text7
	dw CeladonMansion2Text8
	; signs
	dw CeladonMansion2TextSign1
	dw CeladonMansion2TextSign2
	dw CeladonMansion2TextSign3
	dw CeladonMansion2TextSign4
	; non-NPC dialogues
	dw CeladonMansion2TextPigeon_PostBattleMapUnrelated ; 13
	dw CeladonMansion2TextPigeon_PostBattlePreGiveMapPiece ; 14
	dw CeladonMansion2TextPigeon_PostBattleGivenMapPiece ; 15
	dw CeladonMansion2TextPigeon_PostBattleFailedGiveMapPiece ; 16
	dw CeladonMansion2TextPigeon_AreYouBackForYourReward ; 17

; NPCs =========================

CeladonMansion2Text1:
	text_asm
	CheckEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON_FAILED
	jr z, .beginBattle
; try again to give map piece
	ld hl, CeladonMansion2TextPigeon_AreYouBackForYourReward
	call PrintText
	CheckEvent EVENT_OBTAIN_ANY_MAP_PIECE
	jr nz, .alreadyHaveAPiece
; first piece we obtain
	lb bc, MYSTERY_MAP, 1
	call GiveItem
	jr c, .alreadyHaveAPiece
; bag is full
	ld hl, CeladonMansion2TextPigeon_PostBattleFailedGiveMapPiece
	call PrintText
	jp TextScriptEnd
.alreadyHaveAPiece
	SetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON
	SetEvent EVENT_OBTAIN_ANY_MAP_PIECE
	ResetEvent EVENT_OBTAIN_MAP_PIECE_2_PIGEON_FAILED
	ld a, SFX_GET_KEY_ITEM
	call PlaySound
	call Delay3
	ld hl, CeladonMansion2TextPigeon_PostBattleGivenMapPiece
	call PrintText
	jp TextScriptEnd

.beginBattle
; initiate battle
	ld c, BANK(Music_MeetFemaleTrainer)
	ld a, MUSIC_MEET_FEMALE_TRAINER
	call PlayMusic

	ld hl, PigeonBeforeBattleText
	CheckEvent EVENT_1ST_SPOKE_WITH_PIGEON
	jr z, .goPrint
	ld hl, PigeonBeforeBattleTextShort
.goPrint
	call PrintText
	SetEvent EVENT_1ST_SPOKE_WITH_PIGEON

	callfar NormalInverseChoice
	ld a, [wCurrentMenuItem]
	ld [wInverseBattle], a

	ld hl, PigeonBeforeBattleText2
	call PrintText

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic.

	call Delay3
	ld a, OPP_PIGEON
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a

	ld hl, PigeonPostBattlePlayerWinsText ; text if player wins
	ld de, PigeonPostBattlePlayerLosesText ; text if player loses

	; handle scripts
	ld a, 1
	ld [wCeladonMansion2FCurScript], a

	call SaveEndBattleTextPointers
	jp TextScriptEnd

PigeonBeforeBattleText:
	text_far _PigeonBeforeBattleText
	text_end

PigeonBeforeBattleTextShort:
	text_far _PigeonBeforeBattleTextShort
	text_end

PigeonBeforeBattleText2:
	text_far _PigeonBeforeBattleText2
	text_end

PigeonPostBattlePlayerWinsText:
	text_far _PigeonPostBattlePlayerWinsText
	text_end

PigeonPostBattlePlayerLosesText:
	text_far _PigeonPostBattlePlayerLosesText
	text_end

; ---------------------

CeladonMansion2Text2:
	text_far _CeladonMansion2TextCramorant
	text_end

CeladonMansion2Text3:
	text_far _CeladonMansion2TextCarrot
	text_end

CeladonMansion2Text4:
	text_far _CeladonMansion2TextMord
	text_end

CeladonMansion2Text5:
	text_far _CeladonMansion2TextDannye
	text_end

CeladonMansion2Text6:
	text_far _CeladonMansion2TextSatoMew
	text_end

CeladonMansion2Text7:
	text_far _CeladonMansion2TextJoJo
	text_end

CeladonMansion2Text8:
	text_far _CeladonMansion2TextOrange
	text_end

; Signs =========================

CeladonMansion2TextSign1:
	text_far _CeladonMansion2TextSign1
	text_end

CeladonMansion2TextSign2:
	text_far _CeladonMansion2TextSign2
	text_end

CeladonMansion2TextSign3:
	text_far _CeladonMansion2TextSign3
	text_end

CeladonMansion2TextSign4:
	text_far _CeladonMansion2TextSign4
	text_end

; non-NPCs dialogues =========================

CeladonMansion2TextPigeon_PostBattleMapUnrelated:
	text_far _CeladonMansion2TextPigeon_PostBattleMapUnrelated
	text_end

CeladonMansion2TextPigeon_PostBattlePreGiveMapPiece:
	text_far _CeladonMansion2TextPigeon_PostBattlePreGiveMapPiece
	text_end

CeladonMansion2TextPigeon_PostBattleGivenMapPiece:
	text_far _Route12TextObsidianMinesHiker_GiveMapPiece ; edited
	sound_get_key_item
	text_end

CeladonMansion2TextPigeon_PostBattleFailedGiveMapPiece:
	text_far _CeladonMansion2TextPigeon_PostBattleFailedGiveMapPiece
	text_end

CeladonMansion2TextPigeon_AreYouBackForYourReward:
	text_far _CeladonMansion2TextPigeon_AreYouBackForYourReward
	text_end
