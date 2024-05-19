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
	jr nz, .nextCheck
; event not set yet, check if to be set
	ld a, [wBattleFacilityStandardRecordNormal]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordNormal]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityStandardRecordInverse]
	cp 255
	jr z, .BFMaxed
	ld a, [wBattleFacilityHardcoreRecordInverse]
	cp 255
	jr z, .BFMaxed
	jr .nextCheck
.BFMaxed
	SetEvent EVENT_MAXED_BATTLE_FACILITY
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_2
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
