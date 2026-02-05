HauntedHouse3_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse3HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedHouse3_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call CallFunctionInTable
	ret

HauntedHouse3HandleRandomGlitchyBehaviours:
	lb bc, 39, 59
	lb de, 41, 59
	call CheckIfInRectangle_HH ; b = min x, c = max x, d = min y, e = max y
	jr nc, .notInDarkMaze
; in dark maze
; hide Pikachu too, if present
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu
	call DisablePikachuOverworldSpriteDrawing
.notFollowingPikachu
; hide player
	jp LoadTransparentPlayerSpriteGraphics
	ret ; unnecessary?
.notInDarkMaze
; show Pikachu, if present
	call CheckPikachuFollowingPlayer
	jr nz, .notFollowingPikachu2
	ld a, $1
	ld [wPikachuSpawnState], a
	call EnablePikachuOverworldSpriteDrawing
.notFollowingPikachu2
	callfar HauntedHouseHandleRandomGlitchyBehaviours
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
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID

HauntedHouse3BetweenBedsCoords:
	dbmapcoord 42, 24
	dbmapcoord 43, 24
	dbmapcoord 42, 25
	dbmapcoord 43, 25
	db -1 ; end

; ============================

HauntedHouse3_TextPointers:
	dw HauntedHouse3Text1

HauntedHouse3Text1:
	text_far _HauntedHouse3Text1
	text_end

; ============================

; inputs:
; b = min x, c = max x, d = min y, e = max y
; output:
; c flag = in the rectangle, nc otherwise
CheckIfInRectangle_HH::
	inc c
	inc e
	ld a, [wXCoord]
	cp b
	jr c, .outsideRectangle ; if X<=b-1
	cp c
	jr nc, .outsideRectangle ; if X>=c+1
	ld a, [wYCoord]
	cp d
	jr c, .outsideRectangle ; if Y<=d-1
	cp e
	jr nc, .outsideRectangle ; if Y>=e+1
;insideRectangle
	scf
	ret
.outsideRectangle
	xor a
	ret
