SafariZoneNorth_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SafariZoneNorthTrainerHeaders
	ld de, SafariZoneNorth_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

ResetSafariZoneNorthScript:
	ResetEvent EVENT_IN_SAFARI_ZONE
	xor a
	ld [wNumSafariBalls], a
	ld [wSafariSteps], a
	ld [wSafariZoneGateCurScript], a
	ld [wCurMapScript], a ; new
	ret

SafariZoneNorth_ScriptPointers:
	dw SafariZoneNorthScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw SafariZoneNorthScript2
	dw SafariZoneNorthScript3
	dw SafariZoneNorthScript4

SafariZoneNorthScript4:
	ret

SafariZoneNorthScript0:
	jp nc, CheckFightingMapTrainers
	ld a, $3
	ld [wCurMapScript], a
	ret

SafariZoneNorthScript3:
	xor a
	ld [wCurMapScript], a
	ret

SafariZoneNorthScript2:
	call EndTrainerBattle ; any need to do any shenanigans with the beyond 200?
	ld a, [wIsInBattle]
	cp $ff
	jp z, ResetSafariZoneNorthScript
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; hide Safari Giovanni after having defeat them
	call GBFadeOutToBlack
	ld a, HS_SAFARI_ZONE_NORTH_GIOVANNI
	ld [wMissableObjectIndex], a
	predef HideObjectExtra ; edited, new HS function
; and show them in Oaks Lab
	ld a, HS_OAKS_LAB_GIOVANNI
	ld [wMissableObjectIndex], a
	predef ShowObject
; also spawn another tourist
	ld a, HS_LUNAR_SHRINE_TOURIST_3
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp TextScriptEnd

SafariZoneNorth_TextPointers:
	dw GiovanniSafariText1
	dw PickUpItemText
	dw PickUpItemText
	dw SafariZoneNorthGuardText ; new
	dw SafariZoneNorthGuardText ; new
	dw SafariZoneNorthText3
	dw SafariZoneNorthText4
	dw SafariZoneNorthText5
	dw SafariZoneNorthText6
	dw SafariZoneNorthText7

SafariZoneNorthTrainerHeaders:
	def_trainers
SafariZoneNorthTrainerHeader0:
	trainer EVENT_BEAT_SAFARI_ZONE_NORTH_TRAINER_0, 0, GiovanniSafariBeforeBattleText, GiovanniSafariEndBattleText, GiovanniSafariAfterBattleText
	db -1 ; end

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

; --------------------

GiovanniSafariText1:
	text_asm
	ld hl, SafariZoneNorthTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

GiovanniSafariBeforeBattleText:
	text_far _GiovanniSafariBeforeBattleText
	text_end

GiovanniSafariEndBattleText:
	text_far _GiovanniSafariEndBattleText
	text_end

GiovanniSafariAfterBattleText:
	text_far _GiovanniSafariAfterBattleText
	text_end

; --------------------------------

SafariZoneNorthGuardText:
	text_far _SafariZoneNorthGuardText
	text_end
