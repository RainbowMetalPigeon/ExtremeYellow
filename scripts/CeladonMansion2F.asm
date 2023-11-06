CeladonMansion2F_Script:
	call EnableAutoTextBoxDrawing
	ret

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

; NPCs =========================

CeladonMansion2Text1:
	text_asm
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

	ld hl, PigeonPostBattleText
	ld de, PigeonPostBattleText
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

PigeonPostBattleText:
	text_far _PigeonPostBattleText
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
