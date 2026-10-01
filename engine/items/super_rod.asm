ReadSuperRodData:
	ld a, [wCurMap]
	ld c, a
; new for sevii
	CheckEvent EVENT_IN_SEVII
	jr z, .noSevii
	ld hl, SuperRodFishingSlots_Sevii
	CheckEvent EVENT_ENHANCED_RODS
	jr z, .loop
	ld hl, SuperRodFishingSlots_Sevii_Enhanced
	jr .loop
.noSevii
; back to vanilla
	ld hl, SuperRodFishingSlots
	CheckEvent EVENT_ENHANCED_RODS			; new, to improve rods (Obsidian Fishing Guru)
	jr z, .loop								; new, to improve rods (Obsidian Fishing Guru)
	ld hl, SuperRodFishingSlots_Enhanced	; new, to improve rods (Obsidian Fishing Guru)
.loop
	ld a, [hli]
	cp $ff
	jr z, .notfound
	cp c
	jr z, .found
	ld de, $0A ; edited becasue I added one species per location, it was $8
	add hl, de
	jr .loop
.found
	call GenerateRandomFishingEncounter
	ret
.notfound
	ld de, $0
	ret

GenerateRandomFishingEncounter:
	call Random
	cp $66 ; 40%
	jr c, .asm_f5ed6
	inc hl
	inc hl
	cp $b2 ; 30%, tot 70%
	jr c, .asm_f5ed6
	inc hl
	inc hl
	cp $e5 ; 20%, tot 90%
	jr c, .asm_f5ed6
	inc hl
	inc hl
	cp $ff 				; new, =255 -> 0.4%, tot 99.6%
	jr c, .asm_f5ed6	; new
	inc hl				; new
	inc hl				; new
.asm_f5ed6 ; 0.4%, tot 100%
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

INCLUDE "data/wild/super_rod.asm"
INCLUDE "data/wild/super_rod_sevii.asm"

; new --------------------------------------------

; creates a list at wBuffer of maps where the mon in [wd11e] can be found.
; this is used by the pokedex to display locations the mon can be found on the map.
; especially for Super Rod fishing locations 
FindWildLocationsOfMon_SuperRod::
; choose list to use
	CheckEvent EVENT_IN_SEVII
	jr z, .noSevii
; yes Sevii
	ld hl, SuperRodFishingSlots_Sevii
	CheckEvent EVENT_ENHANCED_RODS
	jr z, .gotRodList
	ld hl, SuperRodFishingSlots_Sevii_Enhanced
	jr .gotRodList
.noSevii
; back to vanilla
	ld hl, SuperRodFishingSlots
	CheckEvent EVENT_ENHANCED_RODS
	jr z, .gotRodList
	ld hl, SuperRodFishingSlots_Enhanced
.gotRodList

; fill wBuffer = wTownMapCoords
	ld de, wBuffer
	ld a, [wd11e]
	ld b, a ; b has the mon we are checking

.loop
	ld a, [hli] ; a has the map index, and now hl points to first mon
	ld [de], a ; de holds the maps; may be emptied later
	cp $FF ; = -1
	ret z

;checkMon1
	ld a, [hli] ; a has the pokemon
	inc hl ; now hl points to second mon
	cp b
	jr nz, .checkMon2
; confirm this map, check the next, advance hl appropriately
; hl +8
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc de
	jr .loop

.checkMon2
	ld a, [hli] ; a has the pokemon
	inc hl ; now hl points to third mon
	cp b
	jr nz, .checkMon3
; confirm this map, check the next, advance hl appropriately
; hl +6
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc hl
	inc de
	jr .loop

.checkMon3
	ld a, [hli] ; a has the pokemon
	inc hl ; now hl points to fourth mon
	cp b
	jr nz, .checkMon4
; confirm this map, check the next, advance hl appropriately
; hl +4
	inc hl
	inc hl
	inc hl
	inc hl
	inc de
	jr .loop

.checkMon4
	ld a, [hli] ; a has the pokemon
	inc hl ; now hl points to fifth mon
	cp b
	jr nz, .checkMon5
; confirm this map, check the next, advance hl appropriately
; hl +2
	inc hl
	inc hl
	inc de
	jr .loop

.checkMon5
	ld a, [hli] ; a has the pokemon
	inc hl ; now hl points to fifth mon
	cp b
	jr nz, .noMatchThisMap
; confirm this map, check the next, advance hl appropriately
; hl +0
	inc de
	jr .loop

.noMatchThisMap
; empty the value currently held in de, and do not advance it
	xor a
	ld [de], a
	jr .loop
