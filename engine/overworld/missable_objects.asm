MarkTownVisitedAndLoadMissableObjects::
	ld a, [wCurMap]
	cp FIRST_ROUTE_MAP
	jr nc, .notInTown
	ld c, a
	ld b, FLAG_SET
	ld hl, wTownVisitedFlag   ; mark town as visited (for flying)
	predef FlagActionPredef
.notInTown
	ld hl, MapHSPointers
	ld a, [wCurMap]
	ld b, $0
	ld c, a
	add hl, bc
	add hl, bc
	ld a, [hli]                ; load missable objects pointer in hl
	ld h, [hl]
	ld l, a
	push hl

; new block of code for splitting the HS
	ld de, MissableObjectsExtra
	ld a, d
	sub h
	jr c, .useExtra
	jr nz, .useNormal
	ld a, e
	sub l
	jr z, .useExtra
	jr c, .useExtra
.useNormal
	ResetEventA EVENT_USE_EXTRA_HIDESHOW
;	ld de, MissableObjectsBase
	ld a, l
	sub LOW(MissableObjectsBase)   ; calculate difference between out pointer and the base pointer
	ld l, a
	ld a, h
	sbc HIGH(MissableObjectsBase)
	jr .addressSelected
.useExtra
	SetEventA EVENT_USE_EXTRA_HIDESHOW
	ld a, l
	sub LOW(MissableObjectsExtra)   ; calculate difference between out pointer and the base pointer
	ld l, a
	ld a, h
	sbc HIGH(MissableObjectsExtra)
.addressSelected

; commented away for splitting the HS
;	ld a, l
;	sub LOW(MissableObjects)   ; calculate difference between out pointer and the base pointer
;	ld l, a
;	ld a, h
;	sbc HIGH(MissableObjects)

	ld h, a
	ld a, h
	ldh [hDividend], a
	ld a, l
	ldh [hDividend+1], a
	xor a
	ldh [hDividend+2], a
	ldh [hDividend+3], a
	ld a, $3
	ldh [hDivisor], a
	ld b, $2
	call Divide                ; divide difference by 3, resulting in the global offset (number of missable items before ours)
	ld a, [wCurMap]
	ld b, a
	ldh a, [hDividend+3]
	ld c, a                    ; store global offset in c
	ld de, wMissableObjectList
	pop hl
.writeMissableObjectsListLoop
	ld a, [hli]
	cp -1
	jr z, .done     ; end of list
	cp b
	jr nz, .done    ; not for current map anymore
	ld a, [hli]
	inc hl
	ld [de], a                 ; write (map-local) sprite ID
	inc de
	ld a, c
	inc c
	ld [de], a                 ; write (global) missable object index
	inc de
	jr .writeMissableObjectsListLoop
.done
	ld a, -1
	ld [de], a                 ; write sentinel
	ret

InitializeMissableObjectsFlags:
	ld hl, wMissableObjectFlags
	ld bc, wMissableObjectFlagsEnd - wMissableObjectFlags
	xor a
	call FillMemory ; clear missable objects flags
	ld hl, MissableObjectsBase ; edited for splitting the HS
	xor a
	ld [wMissableObjectCounter], a
.missableObjectsLoop
	ld a, [hli]
	cp -1           ; end of list
;	ret z ; commented for splitting the HS
	jr z, InitializeMissableObjectsFlagsExtra ; new for splitting the HS
	push hl
	inc hl
	ld a, [hl]
	cp HIDE
	jr nz, .skip
	ld hl, wMissableObjectFlags
	ld a, [wMissableObjectCounter]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction ; set flag if Item is hidden
.skip
	ld hl, wMissableObjectCounter
	inc [hl]
	pop hl
	inc hl
	inc hl
	jr .missableObjectsLoop

; new function for splitting the HS
InitializeMissableObjectsFlagsExtra:
	ld hl, wMissableObjectFlagsExtra
	ld bc, wMissableObjectFlagsExtraEnd - wMissableObjectFlagsExtra
	xor a
	call FillMemory ; clear missable objects flags
	ld hl, MissableObjectsExtra
	xor a
	ld [wMissableObjectCounter], a
.missableObjectsLoop
	ld a, [hli]
	cp $ff          ; end of list
	ret z
	push hl
	inc hl
	ld a, [hl]
	cp HIDE
	jr nz, .skip
	ld hl, wMissableObjectFlagsExtra
	ld a, [wMissableObjectCounter]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction ; set flag if Item is hidden
.skip
	ld hl, wMissableObjectCounter
	inc [hl]
	pop hl
	inc hl
	inc hl
	jr .missableObjectsLoop

; tests if current sprite is a missable object that is hidden/has been removed
IsObjectHidden:
	ldh a, [hCurrentSpriteOffset]
	swap a
	ld b, a
	ld hl, wMissableObjectList
.loop
	ld a, [hli]
	cp -1
	jr z, .notHidden ; not missable -> not hidden
	cp b
	ld a, [hli]
	jr nz, .loop
	ld c, a
	ld b, FLAG_TEST
	CheckEvent EVENT_USE_EXTRA_HIDESHOW		; new for splitting HS
	ld hl, wMissableObjectFlags
	jr z, .callAction						; new for splitting HS
	ld hl, wMissableObjectFlagsExtra		; new for splitting HS
.callAction									; new for splitting HS
	call MissableObjectFlagAction
	ld a, c
	and a
	jr nz, .hidden
.notHidden
	xor a
.hidden
	ldh [hIsHiddenMissableObject], a
	ret

; adds missable object (items, leg. pokemon, etc.) to the map
; [wMissableObjectIndex]: index of the missable object to be added (global index)
ShowObject: ; edited for splitting HS
;ShowObject2: ; removed, useless?
	ld hl, wMissableObjectFlags
	jr ShowObjectCommon

ShowObjectExtra: ; new for splitting HS
	ld hl, wMissableObjectFlagsExtra
	jr ShowObjectCommon

ShowObjectCommon: ; new for splitting HS
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_RESET
	call MissableObjectFlagAction   ; reset "removed" flag
	jp UpdateSprites

; removes missable object (items, leg. pokemon, etc.) from the map
; [wMissableObjectIndex]: index of the missable object to be removed (global index)
HideObject: ; edited for splitting HS
	ld hl, wMissableObjectFlags
	jr HideObjectCommon

HideObjectExtra: ; new for splitting HS
	ld hl, wMissableObjectFlagsExtra
	jr HideObjectCommon

HideObjectCommon: ; new for splitting HS
	ld a, [wMissableObjectIndex]
	ld c, a
	ld b, FLAG_SET
	call MissableObjectFlagAction   ; set "removed" flag
	jp UpdateSprites

MissableObjectFlagAction:
; identical to FlagAction

	push hl
	push de
	push bc

	; bit
	ld a, c
	ld d, a
	and 7
	ld e, a

	; byte
	ld a, d
	srl a
	srl a
	srl a
	add l
	ld l, a
	jr nc, .ok
	inc h
.ok

	; d = 1 << e (bitmask)
	inc e
	ld d, 1
.shift
	dec e
	jr z, .shifted
	sla d
	jr .shift
.shifted

	ld a, b
	and a
	jr z, .reset
	cp 2
	jr z, .read

.set
	ld a, [hl]
	ld b, a
	ld a, d
	or b
	ld [hl], a
	jr .done

.reset
	ld a, [hl]
	ld b, a
	ld a, d
	xor $ff
	and b
	ld [hl], a
	jr .done

.read
	ld a, [hl]
	ld b, a
	ld a, d
	and b

.done
	pop bc
	pop de
	pop hl
	ld c, a
	ret
