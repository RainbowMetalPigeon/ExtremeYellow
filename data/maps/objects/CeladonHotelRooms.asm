CeladonHotelRooms_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, CELADON_HOTEL_HALL, 3 ; 1
	warp_event  3,  7, CELADON_HOTEL_HALL, 3 ; 2
	warp_event 18,  7, CELADON_HOTEL_HALL, 4 ; 3
	warp_event 19,  7, CELADON_HOTEL_HALL, 4 ; 4
	warp_event 34,  7, CELADON_HOTEL_HALL, 5 ; 5
	warp_event 35,  7, CELADON_HOTEL_HALL, 5 ; 6
	warp_event 50,  7, CELADON_HOTEL_HALL, 6 ; 7
	warp_event 51,  7, CELADON_HOTEL_HALL, 6 ; 8

	def_bg_events
	bg_event 16,  4, 2 ; CeladonHotelRoomsSign1
	bg_event 16,  5, 3 ; CeladonHotelRoomsSign2
	bg_event 16,  1, 4 ; CeladonHotelRoomsSign3
	bg_event 23,  1, 5 ; CeladonHotelRoomsSign4
	bg_event 25,  6, 6 ; CeladonHotelRoomsSign5
	bg_event 39,  1, 7 ; CeladonHotelRoomsSign6
	bg_event 32,  1, 8 ; CeladonHotelRoomsSign7

	def_object_events
	object_event 39,  4, SPRITE_HIKER, STAY, LEFT, 1 ; Looker (Bellocchio)

	def_warps_to CELADON_HOTEL_ROOMS
