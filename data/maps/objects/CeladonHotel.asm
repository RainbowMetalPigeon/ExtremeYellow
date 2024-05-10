CeladonHotel_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, LAST_MAP, 12 ; edited coz removed useless CELADON warp
	warp_event  4,  7, LAST_MAP, 12 ; edited coz removed useless CELADON warp
	warp_event 10,  0, CELADON_HOTEL_HALL, 1 ; 3

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_GRANNY, STAY, DOWN, 1 ; person
	object_event  2,  4, SPRITE_BEAUTY, STAY, NONE, 2 ; person
	object_event  8,  4, SPRITE_SUPER_NERD, WALK, LEFT_RIGHT, 3 ; person
	object_event 10,  5, SPRITE_GUARD, STAY, DOWN, 4 ; new, blocking pass, will be 10,  2
	object_event 11,  3, SPRITE_GUARD, STAY, LEFT, 5 ; new, allowing pass

	def_warps_to CELADON_HOTEL
