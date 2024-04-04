HauntedHouse3_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse3HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedHouse3_ScriptPointers
	ld a, [wHauntedHouse3CurScript]
	call CallFunctionInTable
	ret

HauntedHouse3HandleRandomGlitchyBehaviours:
	callfar HauntedHouseHandleRandomGlitchyBehaviours ; testing
	call HauntedHouse3ReplaceBlockForRealExit
	ret

HauntedHouse3ReplaceBlockForRealExit:
	ld a, [wHauntedHouse3HowManyTimeBetweenBeds]
	rr a ; rotate a right, the lowest bit is "set into the" carry flag
	     ; so, if the last bit is 0, i.e. a is even, c is NOT set, path blocked
		 ; vice versa, if a is odd, c flag is set, and path is open
	jr c, .pathOpen
	ld a, $12 ; floor-and-plant block ID
	jr .replaceTile
.pathOpen
	ld a, $B ; clear-floor block ID
.replaceTile
	ld [wNewTileBlockID], a
	lb bc, 18, 7 ; block coordinates in Y, X
	predef_jump ReplaceTileBlock

HauntedHouse3_ScriptPointers:
	dw HauntedHouse3Script0

HauntedHouse3Script0:
	ld hl, HauntedHouse3BetweenBedsCoords
	call ArePlayerCoordsInArray
	jr c, .betweenBeds
	ResetEvent EVENT_HAUNTED_HOUSE_BETWEEN_BEDS
	ret ; in Pokemon Tower 5F is "jp CheckFightingMapTrainers"
.betweenBeds
	CheckAndSetEvent EVENT_HAUNTED_HOUSE_BETWEEN_BEDS
	ret nz ; already between the beds
; not already between the beds
	ld hl, wHauntedHouse3HowManyTimeBetweenBeds
	inc [hl]
	call HauntedHouse3ReplaceBlockForRealExit
	ret

HauntedHouse3BetweenBedsCoords:
	dbmapcoord 42, 24
	dbmapcoord 43, 24
	dbmapcoord 42, 25
	dbmapcoord 43, 25
	db -1 ; end

; ============================

HauntedHouse3_TextPointers:
;	dw HauntedHouse3Text1

	text_end

; ============================
