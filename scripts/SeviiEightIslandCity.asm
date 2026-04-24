SeviiEightIslandCity_Script:
	call HideOrShowEightIslandCaveEntrance
	call EnableAutoTextBoxDrawing
	ld de, SeviiEightIslandCity_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HideOrShowEightIslandCaveEntrance:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, .changeBlock
	ld hl, wCurrentMapScriptFlags
	bit 4, [hl]
	res 4, [hl]
	ret z
.changeBlock
	CheckEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_TO_BE_CLOSED
	ret nz
	CheckEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_ALLOWED
	ret nz
; replace block
	ld a, $57 ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  5,  6
	predef_jump ReplaceTileBlock

SeviiEightIslandCity_ScriptPointers:
	dw SeviiEightIslandCity_Script0 ; 0
	dw SeviiEightIslandCity_ScriptOpenCave ; 1

SeviiEightIslandCity_Script0:
	CheckAndResetEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_TO_BE_CLOSED_AFTER_LOSS_VS_SUUJERO
	jr nz, .closeDoor
	CheckEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_TO_BE_CLOSED
	ret z
; if we have to close the entrance
	ld hl, SeviiEightIslandCity_CoordinatesFrontOfCaveEntrance
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
; close it
	callfar ShakeScreen
	call PlayDefaultMusic
	ld a, SFX_GO_INSIDE
	call PlaySound
.closeDoor
	ld a, $57 ; no-entrance block
	ld [wNewTileBlockID], a
	lb bc,  5,  6
	predef ReplaceTileBlock
	ResetEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_TO_BE_CLOSED
	xor a
	ld [wCurMapScript], a
	ret

SeviiEightIslandCity_CoordinatesFrontOfCaveEntrance:
	dbmapcoord 12, 12
	db -1 ; end

SeviiEightIslandCity_ScriptOpenCave:
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_ICHINO
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_NIUE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_SANTRE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_YOTTRO
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_ROKUSEI
	ResetEvent EVENT_DEFEATED_SEVII_SAGE_NANETTE
	SetEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_ALLOWED
	callfar ShakeScreen
	call PlayDefaultMusic
	ld a, $EB ; yes-entrance block
	ld [wNewTileBlockID], a
	lb bc,  5,  6
	predef ReplaceTileBlock
	ld a, SFX_GO_INSIDE
	call PlaySound
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wCurMapScript], a
	ret

; =================================================

SeviiEightIslandCity_TextPointers:
	dw SeviiEightIslandCityText1
	; scripts
	dw SeviiEightIslandCityText1_SomethingOpened

SeviiEightIslandCityText1:
	text_asm
	CheckEvent EVENT_SEVII_EIGHT_ISLAND_CAVE_ENTRANCE_ALLOWED
	ld hl, SeviiEightIslandCityText1_CaveOpen
	jr nz, .printAndEnd
; not open, check
	ld hl, SeviiEightIslandCityText1_TriangleWithSevenThings
	call PrintText
; check if we can open
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_ICHINO
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_NIUE
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_SANTRE
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_YOTTRO
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_GONQUE
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_ROKUSEI
	jr z, .cannotOpen
	CheckEvent EVENT_DEFEATED_SEVII_SAGE_NANETTE
	jr z, .cannotOpen
; can open
	ld a, 1
	ld [wCurMapScript], a
	ld hl, SeviiEightIslandCityText1_ReactsWithScrolls
	jr .printAndEnd
.cannotOpen
	ld hl, SeviiEightIslandCityText1_SomethingIsMissing
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiEightIslandCityText1_SomethingOpened:
	text_far _SeviiEightIslandCityText1_SomethingOpened
	text_end

SeviiEightIslandCityText1_ReactsWithScrolls:
	text_far _SeviiEightIslandCityText1_ReactsWithScrolls
	text_end

SeviiEightIslandCityText1_TriangleWithSevenThings:
	text_far _SeviiEightIslandCityText1_TriangleWithSevenThings
	text_end

SeviiEightIslandCityText1_SomethingIsMissing:
	text_far _SeviiEightIslandCityText1_SomethingIsMissing
	text_end

SeviiEightIslandCityText1_CaveOpen:
	text_far _SeviiEightIslandCityText1_CaveOpen
	text_end
