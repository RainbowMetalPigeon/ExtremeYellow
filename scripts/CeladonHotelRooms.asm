CeladonHotelRooms_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, CeladonHotelRoomsSpawns
	jp EnableAutoTextBoxDrawing

CeladonHotelRoomsSpawns:
	CheckEvent EVENT_FOUND_ALL_MEGA_STONES
	ret nz
; check if the event is to be set
	callfar CheckIfMegaStonesHaveAllBeenFound
	ret z
; all stones have been found
	SetEvent EVENT_FOUND_ALL_MEGA_STONES
	ld a, HS_CELADON_HOTEL_ROOMS_TROPHY_1 ; TBV
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ret

CeladonHotelRooms_TextPointers:
	dw CeladonHotelRoomsText1 ; Looker (Bellocchio)
	dw CeladonHotelRoomsText2 ; Traveler (not yet used)
	dw CeladonHotelRoomsText3 ; Trophy 1
	dw CeladonHotelRoomsText4 ; Trophy 2
	dw CeladonHotelRoomsText5 ; Trophy 3
	dw CeladonHotelRoomsText6 ; Trophy 4
	dw CeladonHotelRoomsText7 ; Trophy 5
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
