SeviiFourIslandHazardRoom_Script:
	call ResetScrambledInputsInHazardRoom
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFourIslandHazardRoom_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

ResetScrambledInputsInHazardRoom:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	ResetEvent EVENT_SCRAMBLE_INPUTS
	ret

SeviiFourIslandHazardRoom_ScriptPointers:
	dw SeviiFourIslandHazardRoom_Null ; 0
	
; scripts =========================

SeviiFourIslandHazardRoom_Null:
; check for return-to-square-one tiles
	ld hl, SeviiFourIslandHazardRoom_Coordinates_BackToSquareOne
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkDarkeningTiles
; warp back to beginning
	call StopAllMusic
	ld c, BANK(SFX_Safari_Zone_PA)
	ld a, SFX_SAFARI_ZONE_PA
	call PlayMusic
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_FOUR_ISLAND_HAZARD_ROOM ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 0 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, SEVII_FOUR_ISLAND_CITY
	ld [wLastMap], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	xor a
	ld [wMapPalOffset], a
	ret

.checkDarkeningTiles
	ld hl, SeviiFourIslandHazardRoom_Coordinates_Darkening
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .checkScramblingTiles
; darken map
	CheckEvent EVENT_SEVII_HAZARD_ROOM_PRESSED_TILE
	ret nz
	ld a, SFX_TURN_OFF_PC
	call PlaySound
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $06
	ld [wMapPalOffset], a
	SetEvent EVENT_SEVII_HAZARD_ROOM_PRESSED_TILE
	ret

.checkScramblingTiles
	ld hl, SeviiFourIslandHazardRoom_Coordinates_ScrambleInputs
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .noHazardTile
; scramble inputs
	CheckEvent EVENT_SEVII_HAZARD_ROOM_PRESSED_TILE
	ret nz
	ld a, SFX_DENIED
	call PlaySound
	ld a, 4
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_SCRAMBLE_INPUTS
	SetEvent EVENT_SEVII_HAZARD_ROOM_PRESSED_TILE
	ret

.noHazardTile
	ResetEvent EVENT_SEVII_HAZARD_ROOM_PRESSED_TILE
	ret

SeviiFourIslandHazardRoom_Coordinates_BackToSquareOne:
 	dbmapcoord  7,  1
 	dbmapcoord  5,  2
	dbmapcoord 10,  2
	dbmapcoord 11,  2
 	dbmapcoord  8,  6
 	dbmapcoord  9,  6
 	dbmapcoord  4,  8
	dbmapcoord 14,  8
	dbmapcoord 13, 10
	dbmapcoord  2, 12
	dbmapcoord  5, 13
	dbmapcoord 11, 13
	dbmapcoord  3, 14
	dbmapcoord 15, 15
	dbmapcoord  2, 18
	dbmapcoord  8, 18
	dbmapcoord  3, 19
	db -1 ; end

SeviiFourIslandHazardRoom_Coordinates_Darkening:
	dbmapcoord  9, 10
	dbmapcoord  4, 11
	dbmapcoord  3, 13
	dbmapcoord 13, 14
	dbmapcoord 10, 16
	dbmapcoord  9, 19
	db -1 ; end

SeviiFourIslandHazardRoom_Coordinates_ScrambleInputs:
	dbmapcoord  4,  2
	dbmapcoord  5,  8
	dbmapcoord 15,  9
	dbmapcoord  9, 10
	dbmapcoord 12, 11
	dbmapcoord  6, 14
	dbmapcoord 12, 15
	dbmapcoord  6, 19
	db -1 ; end

; texts ===========================

SeviiFourIslandHazardRoom_TextPointers:
	; signs
	dw SeviiFourIslandHazardRoomSignText1 ; 1
	; scripts
	dw SeviiFourIslandHazardRoomScriptText1_BackToSquareOne ; 2
	dw SeviiFourIslandHazardRoomScriptText2_DarkenMap ; 3
	dw SeviiFourIslandHazardRoomScriptText3_ScrambleInputs ; 4

SeviiFourIslandHazardRoomSignText1:
	text_asm
;	call StopAllMusic
;	ld c, BANK(SFX_Level_Up)
	ld a, SFX_LEVEL_UP
	call PlaySound
	ld hl, SeviiFourIslandHazardRoomSignText1_Won
	call PrintText
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_FOUR_ISLAND_HOUSES ; map-specific
	ldh [hWarpDestinationMap], a
	ld a, 8 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld a, SEVII_FOUR_ISLAND_CITY
	ld [wLastMap], a
	xor a
	ld [wIsInBattle], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	xor a
	ld [wMapPalOffset], a
	SetEvent EVENT_SEVII_HAZARD_ROOM_WON
	jp TextScriptEnd

SeviiFourIslandHazardRoomSignText1_Won:
	text_far _SeviiFourIslandHazardRoomSignText1_Won
	text_end

SeviiFourIslandHazardRoomScriptText1_BackToSquareOne:
	text_far _SeviiFourIslandHazardRoomScriptText1_BackToSquareOne
	text_end

SeviiFourIslandHazardRoomScriptText2_DarkenMap:
	text_far _SeviiFourIslandHazardRoomScriptText2_DarkenMap
	text_end

SeviiFourIslandHazardRoomScriptText3_ScrambleInputs:
	text_far _SeviiFourIslandHazardRoomScriptText3_ScrambleInputs
	text_end
