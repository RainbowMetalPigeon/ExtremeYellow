CeladonHotelHall_Object:
	db $0f ; border block

	def_warp_events
	warp_event 14,  3, CELADON_HOTEL, 3 ; 1
	warp_event 15,  3, CELADON_HOTEL, 3 ; 2
	warp_event  1,  0, CELADON_HOTEL_ROOMS, 1 ; 3
	warp_event  5,  0, CELADON_HOTEL_ROOMS, 3 ; 4
	warp_event  9,  0, CELADON_HOTEL_ROOMS, 5 ; 5
	warp_event 17,  0, CELADON_HOTEL_ROOMS, 7 ; 6

	def_bg_events
	bg_event  2,  0, 1 ; CeladonHotelHallSign1
	bg_event  6,  0, 2 ; CeladonHotelHallSign2
	bg_event 10,  0, 3 ; CeladonHotelHallSign3
	bg_event 14,  0, 4 ; CeladonHotelHallSign4
	bg_event 18,  0, 5 ; CeladonHotelHallSign5

	def_object_events
;	object_event  3,  1, SPRITE_GRANNY, STAY, DOWN, 1 ; person

	def_warps_to CELADON_HOTEL_HALL
