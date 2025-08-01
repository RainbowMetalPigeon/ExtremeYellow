DEF NOT_VISITED EQU $fe

DisplayTownMap:
	call LoadTownMap
	CheckEvent EVENT_IN_SEVII ; new for sevii
	jr nz, .notHauntedHouse ; new for sevii
; new, to handle Haunted House
	push hl
	push de
	push bc
	callfar IsCurrentMapHauntedHouse_AlsoIsland
	pop bc
	pop de
	pop hl
	jr nz, .notHauntedHouse
.doNotPrintMapCursor
	hlcoord 1, 7
	lb bc, 2, 15
	call TextBoxBorder
	hlcoord 2, 9
	ld de, AreaQuestionMarksText
	call PlaceString
; handle inputs
.inputLoopHaunted
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON
	jr z, .inputLoopHaunted
;	ld a, SFX_TINK
;	call PlaySound
	xor a
	ldh [hJoy7], a
;	ld [wAnimCounter], a ; ?
	call ExitTownMap
;	pop hl
;	pop af
;	ld [hl], a ; ?
	ret
.notHauntedHouse
; back to vanilla
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	ld a, $1
	ldh [hJoy7], a
	ld a, [wCurMap]
	push af
	ld b, $0
	call DrawPlayerOrBirdSprite ; player sprite
	hlcoord 1, 0
	ld de, wcd6d
	call PlaceString
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $10
	call CopyData
	ld hl, vSprites tile $04
	ld de, TownMapCursor
	lb bc, BANK(TownMapCursor), (TownMapCursorEnd - TownMapCursor) / $8
	call CopyVideoDataDouble
	xor a
	ld [wWhichTownMapLocation], a
	pop af
	jr .enterLoop

.townMapLoop
	hlcoord 0, 0
	lb bc, 1, 20
	call ClearScreenArea
	ld hl, TownMapOrder_Sevii ; new, for sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii1
	ld hl, TownMapOrder
.sevii1
	ld a, [wWhichTownMapLocation]
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
.enterLoop
	ld de, wTownMapCoords
	call LoadTownMapEntry
	ld a, [de]
	push hl
	call TownMapCoordsToOAMCoords
	ld a, $4
	ld [wOAMBaseTile], a
	ld hl, wShadowOAMSprite04
	call WriteTownMapSpriteOAM ; town map cursor sprite
	pop hl
	ld de, wcd6d
.copyMapName
	ld a, [hli]
	ld [de], a
	inc de
	cp $50
	jr nz, .copyMapName
	hlcoord 1, 0
	ld de, wcd6d
	call PlaceString
	ld hl, wShadowOAMSprite04
	ld de, wTileMapBackup + 16
	ld bc, $10
	call CopyData
.inputLoop
	call TownMapSpriteBlinkingAnimation
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	and A_BUTTON | B_BUTTON | D_UP | D_DOWN
	jr z, .inputLoop
	ld a, SFX_TINK
	call PlaySound
	bit 6, b
	jr nz, .pressedUp
	bit 7, b
	jr nz, .pressedDown
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	ldh [hJoy7], a
	ld [wAnimCounter], a
	call ExitTownMap
	pop hl
	pop af
	ld [hl], a
	ret
.pressedUp
	ld a, [wWhichTownMapLocation]
	inc a
; new for sevii
	push af
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii2
; Kanto
	pop af
	cp TownMapOrderEnd - TownMapOrder ; number of list items + 1
	jr nz, .noOverflow
	xor a
	jr .noOverflow
.sevii2
	pop af
	cp TownMapOrderEnd_Sevii - TownMapOrder_Sevii ; number of list items + 1
; back to vanilla
	jr nz, .noOverflow
	xor a
.noOverflow
	ld [wWhichTownMapLocation], a
	jp .townMapLoop
.pressedDown
	ld a, [wWhichTownMapLocation]
	dec a
	cp -1
	jr nz, .noUnderflow
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii3
	ld a, TownMapOrderEnd - TownMapOrder - 1 ; number of list items
	jr .noUnderflow
.sevii3
	ld a, TownMapOrderEnd_Sevii - TownMapOrder_Sevii - 1 ; number of list items
; back to vanilla
.noUnderflow
	ld [wWhichTownMapLocation], a
	jp .townMapLoop

;Func_70f87: ; unreferenced
;	ldh a, [hJoy5]
;	and D_DOWN | D_UP
;	ret z
;	callfar PlayPikachuSoundClip
;	ret

INCLUDE "data/maps/town_map_order.asm"
INCLUDE "data/maps/town_map_order_sevii.asm" ; new, for sevii

TownMapCursor:
	INCBIN "gfx/town_map/town_map_cursor.1bpp"
TownMapCursorEnd:

LoadTownMap_Nest:
	call LoadTownMap
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	call DisplayWildLocations
	call GetMonName
	hlcoord 1, 0
	call PlaceString
	ld h, b
	ld l, c
	ld de, MonsNestText
	call PlaceString
	call WaitForTextScrollButtonPress
	call ExitTownMap
	pop hl
	pop af
	ld [hl], a
	ret

MonsNestText:
	db "'s NEST@"

LoadTownMap_Fly::
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .currentlyInKanto
; currently in Sevii
	ld a, 1
	ld [wOriginallyInKantoOrSevii], a
	jr .coreOfFlyMap
.currentlyInKanto
	xor a
	ld [wOriginallyInKantoOrSevii], a
.coreOfFlyMap
; BTV
	call ClearSprites
	call LoadTownMap
	ld a, $1
	ldh [hJoy7], a
	call LoadPlayerSpriteGraphics
	call LoadFontTilePatterns
;	call ReloadTilesetTilePatterns ; new, to expand tileset?
; new, to load the Flying Pikachu sprite
	ld a, [wcf91]
	cp STARTER_PIKACHU
	jr nz, .vanillaBirdSprite
	ld de, FlyingPikachuSprite
	ld b, BANK(FlyingPikachuSprite)
	jr .continueLoadingSprite
.vanillaBirdSprite
	ld de, BirdSprite
	ld b, BANK(BirdSprite)
.continueLoadingSprite
; back to vanilla
	ld c, 12
	ld hl, vSprites tile $04
	call CopyVideoData
	ld de, TownMapUpArrow
	ld hl, vChars1 tile $6d
	lb bc, BANK(TownMapUpArrow), (TownMapUpArrowEnd - TownMapUpArrow) / $8
	call CopyVideoDataDouble
	call BuildFlyLocationsList_Wrapper ; edited for Sevii
	ld hl, wUpdateSpritesEnabled
	ld a, [hl]
	push af
	ld [hl], $ff
	push hl
	hlcoord 0, 0
	ld de, ToText
	call PlaceString
	ld a, [wCurMap]
	ld b, $0
	call DrawPlayerOrBirdSprite	
	ld hl, wFlyLocationsList_Sevii ; new, for sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii1
	ld hl, wFlyLocationsList
.sevii1
	decoord 18, 0
.townMapFlyLoop
	ld a, " "
	ld [de], a
	push hl
	push hl
	hlcoord 3, 0
	lb bc, 1, 15
	call ClearScreenArea
	pop hl
	ld a, [hl]
	ld b, $4
	call DrawPlayerOrBirdSprite ; draw bird sprite
	hlcoord 3, 0
	ld de, wcd6d
	call PlaceString
	ld c, 15
	call DelayFrames
	hlcoord 18, 0
	ld [hl], "▶"
	hlcoord 19, 0
	ld [hl], "▼"
	pop hl
.inputLoop
	push hl
	call DelayFrame
	call JoypadLowSensitivity
	ldh a, [hJoy5]
	ld b, a
	pop hl
	and A_BUTTON | B_BUTTON | D_UP | D_DOWN | SELECT ; edited for sevii
	jr z, .inputLoop
	bit BIT_A_BUTTON, b
	jr nz, .pressedA
	ld a, SFX_TINK
	call PlaySound
	bit BIT_D_UP, b
	jr nz, .pressedUp
	bit BIT_D_DOWN, b
	jp nz, .pressedDown
	bit BIT_SELECT, b     ; new for sevii
	jr nz, .pressedSelect ; new for sevii
	jr .pressedB
.pressedA
	ld a, SFX_HEAL_AILMENT
	call PlaySound
	ld a, [hl]
	ld [wDestinationMap], a
	ld hl, wd732
	set 3, [hl]
	inc hl
	set 7, [hl]
	jr .continueWithB ; new for sevii
.pressedB
; new for sevii
	ResetEvent EVENT_FLYING_BETWEEN_KANTO_AND_SEVII
	ld a, [wOriginallyInKantoOrSevii]
	and a ; z flag sets only if a=0 -> in Kanto
	jr z, .originallyInKanto
	; originally in Sevii
	SetEvent EVENT_IN_SEVII
	jr .continueWithB
.originallyInKanto
	ResetEvent EVENT_IN_SEVII 
.continueWithB
; BTV
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	ldh [hJoy7], a
	call GBPalWhiteOutWithDelay3
	pop hl
	pop af
	ld [hl], a
;; new for sevii testing
;	CheckEvent EVENT_IN_SEVII
;	ld a, 1
;	jr nz, .flyingToSevii
;; flying to Kanto
;	xor a
;.flyingToSevii
;	ld [wOriginallyInKantoOrSevii], a ; 0=Kanto, 1=Sevii
;; BTV
	ret
.pressedUp
	decoord 18, 0
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .wrapToStartOfList
	cp NOT_VISITED
	jr z, .pressedUp ; skip past unvisited towns
	jp .townMapFlyLoop
; new for sevii
.pressedSelect
	CheckEvent EVENT_UNLOCKED_SEVII
	jp z, .inputLoop
	SetEvent EVENT_FLYING_BETWEEN_KANTO_AND_SEVII
	CheckEvent EVENT_IN_SEVII
	jr z, .seeminglyInKanto
; seemingly in Sevii
	ResetEvent EVENT_IN_SEVII
	jr .loadOtherMap
.seeminglyInKanto
	SetEvent EVENT_IN_SEVII
.loadOtherMap
	pop hl
	pop af
	jp .coreOfFlyMap
; BTV
.wrapToStartOfList
	ld hl, wFlyLocationsList_Sevii ; new, for sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii2
	ld hl, wFlyLocationsList
.sevii2
	jp .townMapFlyLoop
.pressedDown
	decoord 19, 0
	dec hl
	ld a, [hl]
	cp $ff
	jr z, .wrapToEndOfList
	cp NOT_VISITED
	jr z, .pressedDown ; skip past unvisited towns
	jp .townMapFlyLoop
.wrapToEndOfList
	ld hl, wFlyLocationsList_Sevii + NUM_CITY_MAPS_SEVII ; new, for sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii3
	ld hl, wFlyLocationsList + NUM_CITY_MAPS + 2
.sevii3
	jr .pressedDown

ToText:
	db "To@"

BuildFlyLocationsList:
	ld hl, wFlyAnimUsingCoordList
	ld [hl], $ff
	inc hl ; it's wFlyLocationsList
	ld a, [wTownVisitedFlag]
	ld e, a
	ld a, [wTownVisitedFlag + 1]
	ld d, a
	ld b, 0
	ld c, NUM_CITY_MAPS + 2
.loop
	srl d
	rr e
	ld a, NOT_VISITED
	jr nc, .notVisited
	ld a, b ; store the map number of the town if it has been visited
; new for Route 4 and Route 10
	cp 13
	jr nz, .notRoute4
	ld a, ROUTE_4
.notRoute4
	cp 14
	jr nz, .notRoute10
	ld a, ROUTE_10
; back to vanilla
.notRoute10
.notVisited
	ld [hl], a
	inc hl
	inc b
	dec c
	jr nz, .loop
	ld [hl], $ff
	ret

BuildFlyLocationsList_Sevii: ; new, for Sevii
	ld hl, wFlyAnimUsingCoordList_Sevii
	ld [hl], $ff
	inc hl ; it's wFlyLocationsList_Sevii
	ld a, [wTownVisitedFlag_Sevii]
	ld e, a
	ld a, [wTownVisitedFlag_Sevii + 1]
	ld d, a
	lb bc, 0, NUM_CITY_MAPS_SEVII
.loop
	srl d
	rr e
	ld a, NOT_VISITED
	jr nc, .notVisited
	ld a, b ; store the map number of the town if it has been visited
.notVisited
	ld [hl], a
	inc hl
	inc b
	dec c
	jr nz, .loop
	ld [hl], $ff
	ret

BuildFlyLocationsList_Wrapper: ; new for Sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .Sevii
	call BuildFlyLocationsList
	ret
.Sevii
	call BuildFlyLocationsList_Sevii
	ret

TownMapUpArrow:
	INCBIN "gfx/town_map/up_arrow.1bpp"
TownMapUpArrowEnd:

LoadTownMap:
	call GBPalWhiteOutWithDelay3
	call ClearScreen
	call UpdateSprites
	hlcoord 0, 0
	lb bc, $12, $12
	call TextBoxBorder
	call DisableLCD
	ld hl, WorldMapTileGraphics
	ld de, vChars2 tile $60
	ld bc, WorldMapTileGraphicsEnd - WorldMapTileGraphics
	ld a, BANK(WorldMapTileGraphics)
	call FarCopyData
	ld hl, MonNestIcon
	ld de, vSprites tile $04
	ld bc, MonNestIconEnd - MonNestIcon
	ld a, BANK(MonNestIcon)
	call FarCopyDataDouble
	hlcoord 0, 0
; new, for sevii
	ld de, CompressedMap_Sevii
	CheckEvent EVENT_IN_SEVII
	jr nz, .nextTile ; just skip the Kanto map
; back to vanilla
	ld de, CompressedMap
.nextTile
	ld a, [de]
	and a
	jr z, .done
	ld b, a
	and $f
	ld c, a
	ld a, b
	swap a
	and $f
	add $60
.writeRunLoop
	ld [hli], a
	dec c
	jr nz, .writeRunLoop
	inc de
	jr .nextTile
.done
	call EnableLCD
	ld b, SET_PAL_TOWN_MAP
	call RunPaletteCommand
	call Delay3
	call GBPalNormal
	xor a
	ld [wAnimCounter], a
	inc a
	ld [wTownMapSpriteBlinkingEnabled], a
	ret

CompressedMap:
	INCBIN "gfx/town_map/town_map.rle"

CompressedMap_Sevii: ; new, for sevii
	INCBIN "gfx/town_map/town_map_sevii.rle"

ExitTownMap:
; clear town map graphics data and load usual graphics data
	xor a
	ld [wTownMapSpriteBlinkingEnabled], a
	call GBPalWhiteOut
	call ClearScreen
	call ClearSprites
	call LoadPlayerSpriteGraphics
	call LoadFontTilePatterns
	call ReloadTilesetTilePatterns ; new, to expand tileset
	call UpdateSprites
	jp RunDefaultPaletteCommand

; a = map number
; b = OAM base tile: 0=player, 4=bird/pikachu?
DrawPlayerOrBirdSprite:
; new for sevii
	push af
	ld a, b
	and a
	jr nz, .vanilla
	CheckEvent EVENT_IN_SEVII
	ld a, [wOriginallyInKantoOrSevii] ; 0=Kanto, 1=Sevii
	jr nz, .inSevii
; in Kanto
	and a
	jr z, .vanilla
	jr .popAndRet
.inSevii
	and a
	jr nz, .vanilla
.popAndRet
	pop af
	ret
.vanilla
	pop af
; BTV
	push af
	ld a, b
	ld [wOAMBaseTile], a
	pop af
	ld de, wTownMapCoords
	call LoadTownMapEntry
	ld a, [de]
	push hl
	call TownMapCoordsToOAMCoords
	call WritePlayerOrBirdSpriteOAM
	pop hl
	ld de, wcd6d
.loop
	ld a, [hli]
	ld [de], a
	inc de
	cp "@"
	jr nz, .loop
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $a0
	jp CopyData

DisplayWildLocations:
	ld a, [wd11e]				; new
	cp MEW						; new
	jr z, .printMysterious		; new
	cp MAROWAK					; new, testing
	jr z, .printMysterious		; new, testing
	farcall FindWildLocationsOfMon
	call ZeroOutDuplicatesInList
	ld hl, wShadowOAM
	ld de, wTownMapCoords
.loop
	ld a, [de]
	cp $ff
	jr z, .exitLoop
	and a
	jr z, .nextEntry
; new, for sevii
	push af
	CheckEvent EVENT_IN_SEVII
	jr nz, .inSevii
	pop af
; new, to skip Haunted House
	cp HAUNTED_HOUSE_1
	jr z, .nextEntry
	cp HAUNTED_HOUSE_2
	jr z, .nextEntry
	cp HAUNTED_HOUSE_3
	jr z, .nextEntry
	cp HAUNTED_HOUSE_4
	jr z, .nextEntry
	cp HAUNTED_ISLAND_OF_NUMBERS
	jr z, .nextEntry
	jr .postSevii ; new, for sevii
; back to vanilla
; new for sevii
.inSevii
	pop af
.postSevii
; back to vanilla
	push hl
	call LoadTownMapEntry
	pop hl
	CheckEvent EVENT_IN_SEVII ; new for sevii
	ld a, [de] ; from vanilla
	jr nz, .SeviiNoSkipDexNest ; new for sevii
; code that hides nests in certain area
	cp $19 ; Cerulean Cave's YX (not XY!!!) coordinates
	jr z, .nextEntry ; skip Cerulean Cave
	cp $FF ; new, Secluded Island
	jr z, .nextEntry ; new
.SeviiNoSkipDexNest
; back to vanilla
	call TownMapCoordsToOAMCoords
	ld a, $4 ; nest icon tile no.
	ld [hli], a
	xor a
	ld [hli], a
.nextEntry
	inc de
	jr .loop
.exitLoop
	ld a, l
	and a ; were any OAM entries written?
	jr nz, .drawPlayerSprite
; if no OAM entries were written, print area unknown text
.printMysterious
	hlcoord 1, 7
	lb bc, 2, 15
	call TextBoxBorder
	hlcoord 2, 9
	ld de, AreaMysteriousText	; new
	ld a, [wd11e]				; new
	cp MEW						; new
	jr z, .notUnknownText		; new
	ld de, AreaExtinctText		; new, testing
	cp MAROWAK					; new, testing
	jr z, .notUnknownText		; new, testing
	ld de, AreaUnknownText
.notUnknownText					; new
	call PlaceString
	jr .done
.drawPlayerSprite
	ld a, [wCurMap]
	ld b, $0
	call DrawPlayerOrBirdSprite
.done
	ld hl, wShadowOAM
	ld de, wTileMapBackup
	ld bc, $a0
	jp CopyData

AreaUnknownText:
	db " AREA UNKNOWN@"

AreaMysteriousText:				; new
	db " AREA: MYSTERY@"		; new

AreaExtinctText:				; new
	db "    EXTINCT@"			; new

AreaQuestionMarksText:          ; new
	db " ?????????????@"        ; new

TownMapCoordsToOAMCoords:
; in: lower nybble of a = x, upper nybble of a = y
; out: b and [hl] = (y * 8) + 24, c and [hl+1] = (x * 8) + 24
	push af
	and $f0
	srl a
	add 24
	ld b, a
	ld [hli], a
	pop af
	and $f
	swap a
	srl a
	add 24
	ld c, a
	ld [hli], a
	ret

WritePlayerOrBirdSpriteOAM:
	ld a, [wOAMBaseTile]
	and a
	ld hl, wShadowOAMSprite36 ; for player sprite
	jr z, WriteTownMapSpriteOAM
	ld hl, wShadowOAMSprite32 ; for bird sprite

WriteTownMapSpriteOAM:
	push hl

; Subtract 4 from c (X coord) and 4 from b (Y coord). However, the carry from c
; is added to b, so the net result is that only 3 is subtracted from b.
	lb hl, -4, -4
	add hl, bc

	ld b, h
	ld c, l
	pop hl

WriteAsymmetricMonPartySpriteOAM:
; Writes 4 OAM blocks for a helix mon party sprite, since it does not have
; a vertical line of symmetry.
	lb de, 2, 2
.loop
	push de
	push bc
.innerLoop
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, [wOAMBaseTile]
	ld [hli], a
	inc a
	ld [wOAMBaseTile], a
	xor a
	ld [hli], a
	inc d
	ld a, 8
	add c
	ld c, a
	dec e
	jr nz, .innerLoop
	pop bc
	pop de
	ld a, 8
	add b
	ld b, a
	dec d
	jr nz, .loop
	ret

WriteSymmetricMonPartySpriteOAM:
; Writes 4 OAM blocks for a mon party sprite other than a helix. All the
; sprites other than the helix one have a vertical line of symmetry which allows
; the X-flip OAM bit to be used so that only 2 rather than 4 tile patterns are
; needed.
	xor a
	ld [wSymmetricSpriteOAMAttributes], a
	lb de, 2, 2
.loop
	push de
	push bc
.innerLoop
	ld a, b
	ld [hli], a ; Y
	ld a, c
	ld [hli], a ; X
	ld a, [wOAMBaseTile]
	ld [hli], a ; tile
	ld a, [wSymmetricSpriteOAMAttributes]
	ld [hli], a ; attributes
	xor (1 << OAM_X_FLIP)
	ld [wSymmetricSpriteOAMAttributes], a
	inc d
	ld a, 8
	add c
	ld c, a
	dec e
	jr nz, .innerLoop
	pop bc
	pop de
	push hl
	ld hl, wOAMBaseTile
	inc [hl]
	inc [hl]
	pop hl
	ld a, 8
	add b
	ld b, a
	dec d
	jr nz, .loop
	ret

ZeroOutDuplicatesInList:
; replace duplicate bytes in the list of wild pokemon locations with 0
	ld de, wBuffer
.loop
	ld a, [de]
	inc de
	cp $ff
	ret z
	ld c, a
	ld l, e
	ld h, d
.zeroDuplicatesLoop
	ld a, [hl]
	cp $ff
	jr z, .loop
	cp c
	jr nz, .skipZeroing
	xor a
	ld [hl], a
.skipZeroing
	inc hl
	jr .zeroDuplicatesLoop

LoadTownMapEntry:
; in: a = map number
; out: lower nybble of [de] = x, upper nybble of [de] = y (i.e.: [de]=YX coorindates); hl = address of name
; edited for Sevii
	push af
	CheckEvent EVENT_IN_SEVII
	jr nz, .sevii
; Kanto
	pop af
	cp FIRST_INDOOR_MAP
	jr c, .externalKanto
	ld bc, 4
	ld hl, InternalMapEntries
	jr .loop
.sevii
	pop af
	cp FIRST_INDOOR_MAP_SEVII
	jr c, .externalSevii
	ld bc, 4
	ld hl, InternalMapEntries_Sevii
; back to vanilla
.loop
	cp [hl]
	jr c, .foundEntry
	add hl, bc
	jr .loop
.foundEntry
	inc hl
	jr .readEntry
.externalKanto ; new
	ld hl, ExternalMapEntries
	jr .continue ; new
.externalSevii ; new
	ld hl, ExternalMapEntries_Sevii ; new
.continue ; new
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
.readEntry
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

INCLUDE "data/maps/town_map_entries.asm"
INCLUDE "data/maps/town_map_entries_sevii.asm" ; new, for sevii

INCLUDE "data/maps/names.asm"

MonNestIcon:
	INCBIN "gfx/town_map/mon_nest_icon.1bpp"
MonNestIconEnd:

TownMapSpriteBlinkingAnimation::
	ld a, [wAnimCounter]
	inc a
	cp 25
	jr z, .hideSprites
	cp 50
	jr nz, .done
; show sprites when the counter reaches 50
	ld hl, wTileMapBackup
	ld de, wShadowOAM
	ld bc, $90
	call CopyData
	xor a
	jr .done
.hideSprites
	ld hl, wShadowOAM
	ld b, $24
	ld de, $4
.hideSpritesLoop
	ld [hl], $a0
	add hl, de
	dec b
	jr nz, .hideSpritesLoop
	ld a, 25
.done
	ld [wAnimCounter], a
	jp DelayFrame
