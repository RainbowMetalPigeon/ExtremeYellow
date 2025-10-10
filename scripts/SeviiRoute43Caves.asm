SeviiRoute43Caves_Script:
	call SeviiRoute43Caves_CheckAndMaybeResetEvents
	call EnableAutoTextBoxDrawing
	ld de, SeviiRoute43Caves_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiRoute43Caves_CheckAndMaybeResetEvents:
	ld hl, wCurrentMapScriptFlags ; new
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBERS
	ret nz
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_1
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_2
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_3
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_4
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_5
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_6
	ResetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_7
	ret

SeviiRoute43Caves_ScriptPointers:
	dw SeviiRoute43CavesScript0
	dw SeviiRoute43CavesScript1

SeviiRoute43CavesScript0:
	CheckEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBERS
	ret nz
; check if all boulders are in the right slots one at the time
	call CheckSwitch1
	call CheckSwitch2
	call CheckSwitch3
	call CheckSwitch4
	call CheckSwitch5
	call CheckSwitch6
	call CheckSwitch7
; all boulders placed on all slots?
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_1
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_2
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_3
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_4
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_5
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_6
	ret z
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_7
	ret z
; all switches triggered
	SetEvent EVENT_SEVII_UNLOCKED_TANOBY_CHAMBERS
	ld a, 1
	ld [wCurMapScript], a
	ret

CheckSwitch1:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_1
	ret nz
	ld hl, CoordsData_Route43Caves_1
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_1
	ret

CheckSwitch2:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_2
	ret nz
	ld hl, CoordsData_Route43Caves_2
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_2
	ret

CheckSwitch3:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_3
	ret nz
	ld hl, CoordsData_Route43Caves_3
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_3
	ret

CheckSwitch4:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_4
	ret nz
	ld hl, CoordsData_Route43Caves_4
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_4
	ret

CheckSwitch5:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_5
	ret nz
	ld hl, CoordsData_Route43Caves_5
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_5
	ret

CheckSwitch6:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_6
	ret nz
	ld hl, CoordsData_Route43Caves_6
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_6
	ret

CheckSwitch7:
	CheckEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_7
	ret nz
	ld hl, CoordsData_Route43Caves_7
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z
	SetEvent EVENT_SEVII_ROUTE_43_CAVES_SWITCH_7
	ret

SeviiRoute43CavesScript1:
; wait for boulders to have moved
	ld a, [wd730]
	bit 0, a
	ret nz
; display message
	call ShakeScreen
;	ld a, SFX_PUSH_BOULDER
;	call PlaySound
	ld a, 8
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call PlayDefaultMusic
; load 0 script
	xor a
	ld [wCurMapScript], a
	ret

CoordsData_Route43Caves_1:
	dbmapcoord  4,  7
	db -1 ; end

CoordsData_Route43Caves_2:
	dbmapcoord  9,  7
	db -1 ; end

CoordsData_Route43Caves_3:
	dbmapcoord  4,  4
	db -1 ; end

CoordsData_Route43Caves_4:
	dbmapcoord  9,  4
	db -1 ; end

CoordsData_Route43Caves_5:
	dbmapcoord  2,  2
	db -1 ; end

CoordsData_Route43Caves_6:
	dbmapcoord 11,  2
	db -1 ; end

CoordsData_Route43Caves_7:
	dbmapcoord  7,  0
	db -1 ; end

SeviiRoute43Caves_TextPointers:
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	dw BoulderText
	; scripts
	dw SeviiRoute43CavesScriptText1 ; 8

SeviiRoute43CavesScriptText1:
	text_far _SeviiRoute43CavesScriptText1
	text_end

ShakeScreen:
	ld de, -$20
;	call ShakeElevatorRedrawRow
	ld de, SCREEN_HEIGHT * $20
;	call ShakeElevatorRedrawRow
	call Delay3
	call StopAllMusic
	ldh a, [hSCY]
	ld d, a
	ld e, $1
	ld b, 100
.shakeLoop ; scroll the BG up and down and play a sound effect
	ld a, e
	xor $fe
	ld e, a
	add d
	ldh [hSCY], a
	push bc
	ld c, BANK(SFX_Push_Boulder_1) ; SFX_Push_Boulder_1 ; SFX_Collision_1
	ld a, SFX_PUSH_BOULDER ; SFX_PUSH_BOULDER ; SFX_COLLISION
	call PlayMusic
	pop bc
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .shakeLoop
	ld a, d
	ldh [hSCY], a
;	call StopAllMusic
;	ld c, BANK(SFX_Safari_Zone_PA)
;	ld a, SFX_SAFARI_ZONE_PA
;	call PlayMusic
;musicLoop
;	ld a, [wChannelSoundIDs + CHAN5]
;	cp SFX_SAFARI_ZONE_PA
;	jr z, .musicLoop
	call UpdateSprites
	ret
;	jp PlayDefaultMusic
