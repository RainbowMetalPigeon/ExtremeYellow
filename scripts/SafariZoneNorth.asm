SafariZoneNorth_Script:
	call EnableAutoTextBoxDrawing
;	ld de, SafariZoneNorth_ScriptPointers	; new
;	ld a, [wSafariZoneNorthCurScript]		; new
;	call ExecuteCurMapScriptInTable			; new
;	ld [wSafariZoneNorthCurScript], a		; new
	ret

;SafariZoneNorth_ScriptPointers: ; new
;	dw CheckFightingMapTrainers
;	dw DisplayEnemyTrainerTextAndStartBattle
;	dw EndTrainerBattle

SafariZoneNorth_TextPointers:
	dw SafariZoneNorthTextGiovanni ; new
	dw PickUpItemText
	dw PickUpItemText
	dw SafariZoneNorthText3
	dw SafariZoneNorthText4
	dw SafariZoneNorthText5
	dw SafariZoneNorthText6
	dw SafariZoneNorthText7

SafariZoneNorthText3:
	text_far _SafariZoneNorthText3
	text_end

SafariZoneNorthText4:
	text_far _SafariZoneNorthText4
	text_end

SafariZoneNorthText5:
	text_far _SafariZoneNorthText5
	text_end

SafariZoneNorthText6:
	text_far _SafariZoneNorthText6
	text_end

SafariZoneNorthText7:
	text_far _SafariZoneNorthText7
	text_end

; new ------------------------------------------------

SafariZoneNorthTextGiovanni:
	text_asm
	ld hl, SafariZoneNorthGiovanniBeforeBattleText
	call PrintText
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]

	call Delay3
	ld a, OPP_GIOVANNI
	ld [wCurOpponent], a

	ld a, 4
	ld [wTrainerNo], a

	ld hl, SafariZoneNorthGiovanniPostBattleText
	ld de, SafariZoneNorthGiovanniPostBattleText
	call SaveEndBattleTextPointers
	jp TextScriptEnd

SafariZoneNorthGiovanniBeforeBattleText:
	text_far _SafariZoneNorthGiovanniBeforeBattleText
	text_end

SafariZoneNorthGiovanniPostBattleText:
	text_far _SafariZoneNorthGiovanniPostBattleText
	text_end
