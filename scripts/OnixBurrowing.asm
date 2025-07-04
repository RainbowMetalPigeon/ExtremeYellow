OnixBurrowing_Script:
	call EnableAutoTextBoxDrawing
	ld de, OnixBurrowing_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

OnixBurrowing_ScriptPointers:
	dw OnixBurrowingScript0
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle

OnixBurrowingScript0:
	ld hl, CoordsData_AroundSnorlax ; super-ugly solution, but will do for now
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr c, .yesEncounters
	ld a, [wYCoord]
; are we below the southmost point of the main tunnel?
	cp 46 ; $2E
	jr nc, .noEncounters ; if yes, entrance, no encounters
; are we more east AND more north than Snorlax thresholds?
	cp 14
	jr nc, .yesEncounters
	ld a, [wXCoord]
	cp 35
	jr nc, .noEncounters ; if we are in the north-east corner, Snorlax Dex
.yesEncounters
	ld hl, wd72e
	res 4, [hl]
	ret
.noEncounters
	ld hl, wd72e
	set 4, [hl]
	ret

CoordsData_AroundSnorlax:
	dbmapcoord 40,  8
	dbmapcoord 42,  8
	dbmapcoord 41,  7
	dbmapcoord 41,  9
	db -1 ; end

OnixBurrowing_TextPointers:
	dw PickUpItemText
	dw SnorlaxDenText

OnixBurrowingTrainerHeaders:
	def_trainers
SnorlaxDenTrainerHeader:
	trainer EVENT_BEAT_SNORLAX_DEN, 0, SnorlaxDenBattleText, SnorlaxDenBattleText, SnorlaxDenBattleText
	db -1 ; end

SnorlaxDenText:
	text_asm
	ld hl, SnorlaxDenTrainerHeader
	call TalkToTrainer
;	ld a, [wCurMapScript]
;	ld [wOnixBurrowingCurScript], a
	jp TextScriptEnd

SnorlaxDenBattleText:
	text_far _SnorlaxDenBattleText
	text_asm
	ld a, SNORLAX
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd
