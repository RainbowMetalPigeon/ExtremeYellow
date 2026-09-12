SeviiFourIslandParkourPath_Script:
	RPTextChooser SeviiFourIslandParkourPath_TextPointers, SeviiFourIslandParkourPath_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld de, SeviiFourIslandParkourPath_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

; scripts ============================================

SeviiFourIslandParkourPath_ScriptPointers:
	dw SeviiFourIslandParkourPathScript0
	
SeviiFourIslandParkourPathScript0:
; are we at the start? ------------------------
	ld hl, SeviiFourIslandParkourPath_StartCoordinates
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkEnd
; we are at the start: (re)start time tracking
	xor a
	ld [wParkourPathSeconds], a
	ResetEvent EVENT_PARKOUR_OVERTIME
	SetEvent EVENT_PARKOUR_TIME_TO_BE_PRINTED
	SetEvent EVENT_PARKOUR_TRACKING_TIME
	ret
; are we at the end? --------------------------
.checkEnd
	ld hl, SeviiFourIslandParkourPath_EndCoordinates
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; we are at the end: deactivate tracking and check if we set record
	ResetEvent EVENT_PARKOUR_TRACKING_TIME
	ld a, [wParkourPathSeconds_Record]
	ld b, a
	ld a, [wParkourPathSeconds]
	cp b ; a-b = current - record -> if carry, update record
	jr nc, .doNotUpdateRecord
	ld [wParkourPathSeconds_Record], a
.doNotUpdateRecord
	CheckAndResetEvent EVENT_PARKOUR_TIME_TO_BE_PRINTED
	ret z
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

SeviiFourIslandParkourPath_StartCoordinates:
	dbmapcoord  6, 11
	db -1 ; end

SeviiFourIslandParkourPath_EndCoordinates:
	dbmapcoord  6, 38
	db -1 ; end

; texts ============================================

SeviiFourIslandParkourPath_TextPointers:
	dw SeviiFourIslandParkourPathText1
	; signs
	dw SeviiFourIslandParkourPathSignText1
	dw SeviiFourIslandParkourPathSignText2
	; scripts
	dw SeviiFourIslandParkourPathScriptText1

SeviiFourIslandParkourPath_TextPointers_Rocket:
	dw SeviiFourIslandParkourPathText1_RP
	; signs
	dw SeviiFourIslandParkourPathSignText1
	dw SeviiFourIslandParkourPathSignText2
	; scripts
	dw SeviiFourIslandParkourPathScriptText1

SeviiFourIslandParkourPathText1:
	text_far _SeviiFourIslandParkourPathText1
	text_end

SeviiFourIslandParkourPathText1_RP:
	text_far _SeviiFourIslandParkourPathText1_RP
	text_end

SeviiFourIslandParkourPathSignText1:
	text_asm
	ld hl, SeviiFourIslandParkourPathSignText1_Intro
	call PrintText
	ld hl, SeviiFourIslandParkourPathSignText2
	call PrintText
	jp TextScriptEnd

SeviiFourIslandParkourPathSignText1_Intro:
	text_far _SeviiFourIslandParkourPathSignText1_Intro
	text_end

SeviiFourIslandParkourPathSignText2:
	text_asm
	ld a, [wParkourPathSeconds_Record]
	cp 240
	ld hl, SeviiFourIslandParkourPathSignText2_Capped
	jr nc, .printAndEnd
	ld hl, SeviiFourIslandParkourPathSignText2_Normal
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandParkourPathSignText2_Normal:
	text_far _SeviiFourIslandParkourPathSignText2_Normal
	text_end

SeviiFourIslandParkourPathSignText2_Capped:
	text_far _SeviiFourIslandParkourPathSignText2_Capped
	text_end

SeviiFourIslandParkourPathScriptText1:
	text_asm
	CheckAndResetEvent EVENT_PARKOUR_OVERTIME
	ld hl, SeviiFourIslandParkourPathScriptText1_Overtime
	jr nz, .printAndEnd
	ld hl, SeviiFourIslandParkourPathScriptText1_Normal
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFourIslandParkourPathScriptText1_Normal:
	text_far _SeviiFourIslandParkourPathScriptText1_Normal
	text_end

SeviiFourIslandParkourPathScriptText1_Overtime:
	text_far _SeviiFourIslandParkourPathScriptText1_Overtime
	text_end
