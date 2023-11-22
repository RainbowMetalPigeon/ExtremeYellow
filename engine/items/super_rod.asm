ReadSuperRodData:
	ld a, [wCurMap]
	ld c, a
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
