HauntedHouse4_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedHouse4HandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedHouse4_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call CallFunctionInTable
	ret

HauntedHouse4HandleRandomGlitchyBehaviours:
	lb bc, 55, 59
	lb de, 55, 59
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
; move the "Moms" if appropriate
	CheckEvent EVENT_DEFEATED_MISSINGNO
	ret nz ; no "Mom shenanigans" if we already defeated MissingNo
; check the Mom tornado
	ld hl, HauntedHouse4TornadoCenterCoords
	call ArePlayerCoordsInArray ; carry flag if yes
	ret nc
	call HauntedHouse4TornadoOfMoms
	ret

HauntedHouse4TornadoOfMoms:
	ld a, $ff ; testing
	ld [wJoyIgnore], a

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 0

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 120
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 110
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 100
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 90
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 1

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 84
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 76
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 68
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 60
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 2

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 50
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 45
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 40
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 35
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 3

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 32
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 28
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 24
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 20
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 4

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 11
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 9
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_LEFT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 7
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_DOWN
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 5
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_RIGHT
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

; end loop 5

	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld c, 100
	call DelayFrames
	ld a, HS_HAUNTED_HOUSE_4_MOM_TORNADO_UP
	ld [wMissableObjectIndex], a
	predef HideObjectExtra

	xor a
	ld [wJoyIgnore], a
	ret

HauntedHouse4_ScriptPointers:
	dw HauntedHouse4Script0
	dw HauntedHouse4Script1_SW
	dw HauntedHouse4Script2_SE
	dw HauntedHouse4Script3_NE
	dw HauntedHouse4Script4_NW

HauntedHouse4Script0:
	ld hl, HauntedHouse4MommyEntrance_SW
	call ArePlayerCoordsInArray ; carry flag if yes
	jr c, .inSW
	ld hl, HauntedHouse4MommyEntrance_SE
	call ArePlayerCoordsInArray ; carry flag if yes
	jr c, .inSE
	ld hl, HauntedHouse4MommyEntrance_NE
	call ArePlayerCoordsInArray ; carry flag if yes
	jr c, .inNE
	ld hl, HauntedHouse4MommyEntrance_NW
	call ArePlayerCoordsInArray ; carry flag if yes
	jp c, .inNW
	ret ; inefficient, but here I prefer better code clarity ^^"
.inSW
	CheckEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SW
	ret z
	ld de, HauntedHouse4MovementMom_SW
	ld a, 1 ; SW
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 1
	ld [wCurMapScript], a
	ret
.inSE
	CheckEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SE
	ret z
	ld de, HauntedHouse4MovementMom_SE
	ld a, 2 ; SE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 2
	ld [wCurMapScript], a
	ret
.inNE
	CheckEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NE
	ret z
	ld de, HauntedHouse4MovementMom_NE
	ld a, 3 ; NE
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 3
	ld [wCurMapScript], a
	ret
.inNW
	CheckEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NW
	ret z
	ld de, HauntedHouse4MovementMom_NW
	ld a, 4 ; NW
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 4
	ld [wCurMapScript], a
	ret

HauntedHouse4Script1_SW:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_HAUNTED_HOUSE_4_MOM_SW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ResetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SW
	ld a, HS_HAUNTED_HOUSE_4_MOM_SE
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SE
	xor a
	ld [wCurMapScript], a
	ret

HauntedHouse4Script2_SE:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_HAUNTED_HOUSE_4_MOM_SE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ResetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SE
	ld a, HS_HAUNTED_HOUSE_4_MOM_NE
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NE
	xor a
	ld [wCurMapScript], a
	ret

HauntedHouse4Script3_NE:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_HAUNTED_HOUSE_4_MOM_NE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ResetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NE
	ld a, HS_HAUNTED_HOUSE_4_MOM_NW
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NW
	xor a
	ld [wCurMapScript], a
	ret

HauntedHouse4Script4_NW:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	xor a
	ld [wJoyIgnore], a
	ld a, HS_HAUNTED_HOUSE_4_MOM_NW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ResetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_NW
	ld a, HS_HAUNTED_HOUSE_4_MOM_SW
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	SetEvent EVENT_HAUNTED_HOUSE_4_MOM_IN_ROOM_SW
	xor a
	ld [wCurMapScript], a
	ret

HauntedHouse4TornadoCenterCoords:
	dbmapcoord 28, 55
	db -1 ; end

HauntedHouse4MommyEntrance_SW:
	dbmapcoord  3, 55
	dbmapcoord  5, 57
	db -1 ; end

HauntedHouse4MommyEntrance_SE:
	dbmapcoord 12, 56
	dbmapcoord 15, 54
	db -1 ; end

HauntedHouse4MommyEntrance_NE:
	dbmapcoord 14, 49
	dbmapcoord 12, 46
	db -1 ; end

HauntedHouse4MommyEntrance_NW:
	dbmapcoord  5, 47
	dbmapcoord  2, 49
	db -1 ; end

HauntedHouse4MovementMom_SW:
	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_RIGHT
	db -1 ; end

HauntedHouse4MovementMom_SE:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

HauntedHouse4MovementMom_NE:
	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_LEFT
	db -1 ; end

HauntedHouse4MovementMom_NW:
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1 ; end

; ============================

HauntedHouse4_TextPointers:
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextProxy
	dw HauntedHouse4TextPokeBall

HauntedHouse4TextProxy:
	text_far _HauntedHouse4TextProxy
	text_end

HauntedHouse4TextPokeBall:
	text_asm

	ld a, HAUNTED_REDS_HOUSE
	ldh [hWarpDestinationMap], a
	ld a, 4 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a

	ld a, SPRITE_FACING_UP
	ld [wSpritePlayerStateData1FacingDirection], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp

	jp TextScriptEnd
