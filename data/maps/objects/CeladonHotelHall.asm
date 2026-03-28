CeladonHotelHall_Object:
	db $0f ; border block

	def_warp_events
	warp_event 14,  9, CELADON_HOTEL, 3 ; 1
	warp_event 15,  9, CELADON_HOTEL, 3 ; 2
	warp_event  1,  6, CELADON_HOTEL_ROOMS, 1 ; 3
	warp_event  5,  6, CELADON_HOTEL_ROOMS, 3 ; 4
	warp_event  9,  6, CELADON_HOTEL_ROOMS, 5 ; 5
	warp_event 17,  6, CELADON_HOTEL_ROOMS, 7 ; 6
	; repair shop
	warp_event 30,  9, CELADON_CITY, 16 ; 7
	warp_event 31,  9, CELADON_CITY, 16 ; 8

	def_bg_events
	bg_event  2,  6,  6 ; CeladonHotelHallSign1
	bg_event  6,  6,  7 ; CeladonHotelHallSign2
	bg_event 10,  6,  8 ; CeladonHotelHallSign3
	bg_event 14,  6,  9 ; CeladonHotelHallSign4
	bg_event 18,  6, 10 ; CeladonHotelHallSign5
	; repair shop
	bg_event 27,  4, 11 ; CeladonHotelHallSign6 ; sign
	bg_event 29,  1, 12 ; CeladonHotelHallSign7 ; shelves
	bg_event 27,  1, 13 ; CeladonHotelHallSign8 ; PC

	def_object_events
	; repair shop
	object_event 33,  7, SPRITE_SUPER_NERD, STAY, LEFT, 1, OPP_ENGINEER, 10
	object_event 29,  6, SPRITE_SUPER_NERD, STAY, UP, 2, OPP_ENGINEER, 11
	object_event 26,  5, SPRITE_SUPER_NERD, STAY, RIGHT, 3, OPP_ENGINEER, 12
	object_event 33,  4, SPRITE_SUPER_NERD, STAY, LEFT, 4, OPP_ENGINEER, 13
	object_event 26,  2, SPRITE_SUPER_NERD, STAY, UP, 5

	def_warps_to CELADON_HOTEL_HALL
