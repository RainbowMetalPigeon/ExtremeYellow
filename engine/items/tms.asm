; tests if mon [wcf91] can learn move [wMoveNum]
CanLearnTM:
	ld a, [wcf91]
	ld [wd0b5], a
	call GetMonHeader
	ld hl, wMonHLearnset
	push hl
	ld a, [wMoveNum]
	ld b, a
	ld c, $0
	ld hl, TechnicalMachines
.findTMloop
	ld a, [hli]
	cp -1 ; reached terminator?
	jr z, .done
	cp b
	jr z, .TMfoundLoop
	inc c
	jr .findTMloop
.TMfoundLoop
	pop hl
	ld b, FLAG_TEST
	predef_jump FlagActionPredef
.done
	pop hl
	ld c, 0
	ret

; converts TM/HM number in wd11e into move number
; HMs start at 55 ; edited, was 51
TMToMove:
	ld a, [wd11e]
	dec a
	ld hl, TechnicalMachines
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"

; new, from ZetaPhoenix
; Displays TM Item Name in decoord from the Move ID in wd11e
;
; INPUT
; decoord = where the name will be displayed if applicable
; wd11e   = should contain move id
;
; RAM addresses it replaces
; wd11e         = TMHM id
; wcd6d         = TMHM item id
; wStringBuffer = TMHM item name
DisplayTMItemNameFromMoveName::
    push de
    ld a, [wd11e]
    ld b, a
    ld c, 1
    ld hl, TechnicalMachines
.findTMloop2
    ld a, [hli]
    cp b
    jr z, .TMfound
    inc c
    ld a, NUM_TM_HM ; 50 TMs + 5 HMs
    cp c
    jr c, .TMnotFound
    jr .findTMloop2
.TMfound
    ld a, c
    ld b, NUM_TMS + 1 ; 55 TMs + 1
    sub b
    jr c, .isTM
    ; isHM
    ld b, HM01 ; HM Item IDs start at 196
    add b
    jr .getItemName
.isTM
    ld b, TM01 + NUM_TMS ; TM Item IDs start at 201 (or whatever) (also adding the subtracted 55)
    add b
.getItemName
    ld [wd11e], a
    call GetItemName
    call CopyToStringBuffer
    pop de
    ld h, d
    ld l, e
    ld de, wStringBuffer
    call PlaceString
    push de
.TMnotFound
    pop de
    ret
