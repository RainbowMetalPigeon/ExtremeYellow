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
	bg_event 16,  4,  9 ; CeladonHotelRoomsSign1
	bg_event 16,  5, 10 ; CeladonHotelRoomsSign2
	bg_event 16,  1, 11 ; CeladonHotelRoomsSign3
	bg_event 23,  1, 12 ; CeladonHotelRoomsSign4
	bg_event 25,  6, 13 ; CeladonHotelRoomsSign5
	bg_event 39,  1, 14 ; CeladonHotelRoomsSign6
	bg_event 32,  1, 15 ; CeladonHotelRoomsSign7
	bg_event 25,  5, 16 ; CeladonHotelRoomsSign8

	def_object_events
	object_event 39,  4, SPRITE_HIKER, STAY, LEFT, 1 ; Looker (Bellocchio)
	object_event 51,  5, SPRITE_TRAVELER, STAY, RIGHT, 2 ; Traveler (yet unused)
	object_event  1,  1, SPRITE_OLD_AMBER, STAY, NONE, 3 ; Trophy 1, League, proxy
	object_event  2,  1, SPRITE_OLD_AMBER, STAY, NONE, 4 ; Trophy 2, MAX in BF, proxy
	object_event  3,  1, SPRITE_OLD_AMBER, STAY, NONE, 5 ; Trophy 3, Pokedex, proxy
	object_event  4,  4, SPRITE_OLD_AMBER, STAY, NONE, 6 ; Trophy 4, Inverse rematches, proxy
	object_event  5,  5, SPRITE_OLD_AMBER, STAY, NONE, 7 ; Trophy 5, Mega Stones, proxy
	object_event  6,  4, SPRITE_OLD_AMBER, STAY, NONE, 8 ; Trophy 6, Forbidden Merchant, proxy

	def_warps_to CELADON_HOTEL_ROOMS
