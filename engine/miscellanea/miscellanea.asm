; d contains the Pokemon you want to check
CheckIfOneGivenMonIsInParty::
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the number of Mons in the party
.loop
	ld a, [hli]
	cp d
	jp z, .targetInParty
	dec b
	jr nz, .loop
	cp 0 ; a is always >=1, so when we do cp 0 the carry flag is never set (a-0)
	ret
.targetInParty
	scf ; set carry flag
	ret

; INPUT: d contains the Map Piece ID
; OUTPUT: de is the pointes to the corresponding pic
ConvertMapIDToMapPicID::
	ld a, d ; a contains the map piece ID, >= MAP_PIECES_1
	ld de, MysteryMap1Pic
	cp MAP_PIECES_1
	ret z
	ld de, MysteryMap2Pic
	cp MAP_PIECES_2
	ret z
	ld de, MysteryMap3Pic
	cp MAP_PIECES_3
	ret z
	ld de, MysteryMap4Pic
	cp MAP_PIECES_4
	ret z
	ld de, MysteryMap12Pic
	cp MAP_PIECES_12
	ret z
	ld de, MysteryMap13Pic
	cp MAP_PIECES_13
	ret z
	ld de, MysteryMap14Pic
	cp MAP_PIECES_14
	ret z
	ld de, MysteryMap23Pic
	cp MAP_PIECES_23
	ret z
	ld de, MysteryMap24Pic
	cp MAP_PIECES_24
	ret z
	ld de, MysteryMap34Pic
	cp MAP_PIECES_34
	ret z
	ld de, MysteryMap123Pic
	cp MAP_PIECES_123
	ret z
	ld de, MysteryMap124Pic
	cp MAP_PIECES_124
	ret z
	ld de, MysteryMap134Pic
	cp MAP_PIECES_134
	ret z
	ld de, MysteryMap234Pic
	cp MAP_PIECES_234
	ret z
	ld de, MysteryMap1234Pic
	ret
