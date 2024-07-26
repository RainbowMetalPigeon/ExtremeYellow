CeladonHotelRooms_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, CeladonHotelRoomsSpawns
	jp EnableAutoTextBoxDrawing

CeladonHotelRoomsSpawns:

	CheckEvent EVENT_FOUND_ALL_MEGA_STONES
	jr nz, .checkPokedex
; check if the mega stone event is to be set
	callfar CheckIfMegaStonesHaveAllBeenFound
	jr z, .checkPokedex
; all stones have been found
	SetEvent EVENT_FOUND_ALL_MEGA_STONES
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_5
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

.checkPokedex
	CheckEvent EVENT_COMPLETED_POKEDEX
	jr nz, .checkBattleFacilityRecords
; event not set yet, check if to be set
	ld hl, wPokedexOwned
	ld b, wPokedexOwnedEnd - wPokedexOwned
	call CountSetBits
	ld a, [wNumSetBits]
	cp 209 ; all non-human mons
	jr nz, .checkBattleFacilityRecords
; event is to be set
	SetEvent EVENT_COMPLETED_POKEDEX
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_3
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

.checkBattleFacilityRecords
	CheckEvent EVENT_MAXED_BATTLE_FACILITY
	jr nz, .checkInverseBattles
; event not set yet, check if to be set
	ld a, [wBattleFacilityStandardRecordNormalLC]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordNormalNFE]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordNormalAG]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordNormalLC]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordNormalNFE]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordNormalAG]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordInverseLC]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordInverseNFE]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordInverseAG]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordInverseLC]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordInverseNFE]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordInverseAG]
	cp 255
	jr z, .BFMaxed
	jr .checkInverseBattles
.BFMaxed
	SetEvent EVENT_MAXED_BATTLE_FACILITY
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_2
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

.checkInverseBattles
	CheckEvent EVENT_BEAT_ALL_REMATCH_INVERSE
	jr nz, .nextCheck
; event not set yet, check if to be set
	CheckEvent EVENT_BEAT_BROCK_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_MISTY_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_LT_SURGE_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_ERIKA_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_KOGA_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_SABRINA_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_BLAINE_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_ORAGE_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_LORELEI_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_BRUNO_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_AGATHA_REMATCH_INVERSE
	jr z, .nextCheck
	CheckEvent EVENT_BEAT_LANCE_REMATCH_INVERSE
	jr z, .nextCheck
; all inverse rematches won
	SetEvent EVENT_BEAT_ALL_REMATCH_INVERSE
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_4
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra

.nextCheck
	ret

CeladonHotelRooms_TextPointers:
	dw CeladonHotelRoomsText1 ; Looker (Bellocchio)
	dw CeladonHotelRoomsText2 ; Traveler (not yet used)
	dw CeladonHotelRoomsText3 ; Trophy 1
	dw CeladonHotelRoomsText4 ; Trophy 2
	dw CeladonHotelRoomsText5 ; Trophy 3, Pokedex
	dw CeladonHotelRoomsText6 ; Trophy 4
	dw CeladonHotelRoomsText7 ; Trophy 5, Mega Stones
	dw CeladonHotelRoomsText8 ; Trophy 6
	; signs
	dw CeladonHotelRoomsSign1
	dw CeladonHotelRoomsSign2
	dw CeladonHotelRoomsSign3
	dw CeladonHotelRoomsSign4
	dw CeladonHotelRoomsSign5
	dw CeladonHotelRoomsSign6
	dw CeladonHotelRoomsSign7
	dw CeladonHotelRoomsSign8

CeladonHotelRoomsText1:
	text_far _CeladonHotelRoomsText1
	text_end

CeladonHotelRoomsText2:
	text_far _CeladonHotelRoomsText2
	text_end

CeladonHotelRoomsText3:
	text_far _CeladonHotelRoomsText3
	text_end

CeladonHotelRoomsText4:
	text_far _CeladonHotelRoomsText4
	text_end

CeladonHotelRoomsText5:
	text_far _CeladonHotelRoomsText5
	text_end

CeladonHotelRoomsText6:
	text_far _CeladonHotelRoomsText6
	text_end

CeladonHotelRoomsText7:
	text_far _CeladonHotelRoomsText7
	text_end

CeladonHotelRoomsText8:
	text_far _CeladonHotelRoomsText8
	text_end

; signs ----------------------------

CeladonHotelRoomsSign1:
	text_far _CeladonHotelRoomsSign1
	text_end

CeladonHotelRoomsSign2:
	text_far _CeladonHotelRoomsSign2
	text_end

CeladonHotelRoomsSign3:
	text_far _CeladonHotelRoomsSign3
	text_end

CeladonHotelRoomsSign4:
	text_far _CeladonHotelRoomsSign4
	text_end

CeladonHotelRoomsSign5:
	text_far _CeladonHotelRoomsSign5
	text_end

CeladonHotelRoomsSign6:
	text_far _CeladonHotelRoomsSign6
	text_end

CeladonHotelRoomsSign7:
	text_far _CeladonHotelRoomsSign7
	text_end

CeladonHotelRoomsSign8:
	text_far _CeladonHotelRoomsSign8
	text_end
