SpecialWarpIn::
	call LoadSpecialWarpData
	predef LoadTilesetHeader
	ld hl, wd732
	bit 2, [hl] ; dungeon warp or fly warp?
	res 2, [hl]
	jr z, .next
; if dungeon warp or fly warp
	ld a, [wDestinationMap]
	jr .next2
.next
	bit 1, [hl] ; debug bit
	jr z, .next3
	call DebugStart
.next3
	ld a, 0 ; Pallet Town?
.next2
	ld b, a
	ld a, [wd72d]
	and a
	jr nz, .next4
	ld a, b
.next4
	ld hl, wd732
	bit 4, [hl] ; dungeon warp?
	ret nz
; if not dungeon warp
	ld [wLastMap], a
	ret

; gets the map ID, tile block map view pointer, tileset, and coordinates
LoadSpecialWarpData:
	ld a, [wd72d]
; new for sevii
	cp SEVII_ONE_ISLAND_DOCK
	jr z, .sevii1
	cp SEVII_TWO_ISLAND_DOCK
	jr z, .sevii2
	cp SEVII_THREE_ISLAND_DOCK
	jr z, .sevii3
	cp SEVII_FOUR_ISLAND_DOCK
	jr z, .sevii4
	cp SEVII_FIVE_ISLAND_DOCK
	jr z, .sevii5
	cp SEVII_SIX_ISLAND_DOCK
	jr z, .sevii6
	cp SEVII_SEVEN_ISLAND_DOCK
	jr z, .sevii7
	cp SEVII_EIGHT_ISLAND_DOCK
	jr z, .sevii8
	cp VERMILION_DOCK
	jr z, .kanto
; back to vanilla
	cp TRADE_CENTER
	jr nz, .notTradeCenter
	ld hl, TradeCenterSpec1
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK ; which gameboy is clocking determines who is on the left and who is on the right
	jr z, .copyWarpData
	ld hl, TradeCenterSpec2
	jr .copyWarpData
.notTradeCenter
	cp COLOSSEUM
	jr nz, .notColosseum
	ld hl, ColosseumSpec1
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .copyWarpData
	ld hl, ColosseumSpec2
	jr .copyWarpData
.notColosseum
	ld a, [wd732]
	bit 1, a
	jr nz, .notFirstMap
	bit 2, a
	jr nz, .notFirstMap
	ld hl, FirstMapSpec
; new for sevii
	jr .copyWarpData
.sevii1
	ld hl, SeviiSpec1
	jr .copyWarpData
.sevii2
	ld hl, SeviiSpec2
	jr .copyWarpData
.sevii3
	ld hl, SeviiSpec3
	jr .copyWarpData
.sevii4
	ld hl, SeviiSpec4
	jr .copyWarpData
.sevii5
	ld hl, SeviiSpec5
	jr .copyWarpData
.sevii6
	ld hl, SeviiSpec6
	jr .copyWarpData
.sevii7
	ld hl, SeviiSpec7
	jr .copyWarpData
.sevii8
	ld hl, SeviiSpec8
	jr .copyWarpData
.kanto
	ld hl, KantoSpec
; back to vanilla	
.copyWarpData
	ld de, wCurMap
	ld c, $7
.copyWarpDataLoop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyWarpDataLoop
	ld a, [hli]
	ld [wCurMapTileset], a
	xor a
	jp .done ; edited jr into jp
.notFirstMap
	ld a, [wLastMap] ; this value is overwritten before it's ever read
	ld hl, wd732
	bit 4, [hl] ; used dungeon warp (jumped down hole/waterfall)?
	jr nz, .usedDunegonWarp
	bit 6, [hl] ; return to last pokemon center (or player's house)?
	res 6, [hl]
	jr z, .otherDestination
; return to last pokemon center or player's house
	ld a, [wLastBlackoutMap]
	jr .usedFlyWarp
.usedDunegonWarp
	ld hl, wd72d
	res 4, [hl]
	ld a, [wDungeonWarpDestinationMap]
	ld b, a
	ld [wCurMap], a
	ld a, [wWhichDungeonWarp]
	ld c, a
	ld hl, DungeonWarpList
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .notSevii1
	ld hl, DungeonWarpList_Sevii
.notSevii1
; back to vanilla
	ld de, 0
	ld a, 6
	ld [wDungeonWarpDataEntrySize], a ; useless, it's always 6
.dungeonWarpListLoop
	ld a, [hli]
	cp b
	jr z, .matchedDungeonWarpDestinationMap
	inc hl
	jr .nextDungeonWarp
.matchedDungeonWarpDestinationMap
	ld a, [hli]
	cp c
	jr z, .matchedDungeonWarpID
.nextDungeonWarp
	ld a, [wDungeonWarpDataEntrySize] ; useless, it's always 6
	add e
	ld e, a
	jr .dungeonWarpListLoop
.matchedDungeonWarpID
	ld hl, DungeonWarpData
	add hl, de
	jr .copyWarpData2
.otherDestination
	ld a, [wDestinationMap]
.usedFlyWarp
	ld b, a
	ld [wCurMap], a
	ld hl, FlyWarpDataPtr
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .notSevii2
	ld hl, FlyWarpDataPtr_Sevii
.notSevii2
; back to vanilla
.flyWarpDataPtrLoop
	ld a, [hli]
	inc hl
	cp b
	jr z, .foundFlyWarpMatch
	inc hl
	inc hl
	jr .flyWarpDataPtrLoop
.foundFlyWarpMatch
	ld a, [hli]
	ld h, [hl]
	ld l, a
.copyWarpData2
	ld de, wCurrentTileBlockMapViewPointer
	ld c, $6
.copyWarpDataLoop2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copyWarpDataLoop2
; new for sevii
	CheckEvent EVENT_IN_SEVII
	ld a, OVERWORLD_SEVII
	jr nz, .almostDone
	xor a ; OVERWORLD
.almostDone
; BTV
	ld [wCurMapTileset], a
.done
	ld [wYOffsetSinceLastSpecialWarp], a
	ld [wXOffsetSinceLastSpecialWarp], a
	ld a, $ff ; the player's coordinates have already been updated using a special warp, so don't use any of the normal warps
	ld [wDestinationWarpID], a
	ret

INCLUDE "data/maps/special_warps.asm"
