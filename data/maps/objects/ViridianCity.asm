ViridianCity_Object:
	db $f ; border block

	def_warp_events
	warp_event 23, 25, VIRIDIAN_POKECENTER, 1
	warp_event 29, 19, VIRIDIAN_MART, 1
	warp_event 21, 15, VIRIDIAN_SCHOOL_HOUSE, 1
	warp_event 21,  9, VIRIDIAN_NICKNAME_HOUSE, 1
	warp_event 32,  7, VIRIDIAN_GYM, 1
	warp_event 31, 25, VIRIDIAN_NICKNAME_HOUSE, 3 ; new, relocated Badge Expert

	def_bg_events
	bg_event 17, 17, 10 ; ViridianCityText8
	bg_event 19,  1, 11 ; ViridianCityText9
	bg_event 21, 29, 12 ; ViridianCityText10
	bg_event 30, 19, 13 ; MartSignText
	bg_event 24, 25, 14; PokeCenterSignText
	bg_event 27,  7, 15 ; ViridianCityText13
	bg_event 21, 17, 16 ; ViridianCityText14 ; new

	def_object_events
	object_event 13, 20, SPRITE_YOUNGSTER, WALK, ANY_DIR, 1 ; person
	object_event 30,  8, SPRITE_GAMBLER, STAY, NONE, 2 ; person
	object_event 28, 22, SPRITE_YOUNGSTER, WALK, ANY_DIR, 3 ; person; edited
	object_event 17,  9, SPRITE_GIRL, STAY, RIGHT, 4 ; person
	object_event 18,  9, SPRITE_GAMBLER_ASLEEP, STAY, NONE, 5 ; person
	object_event  6, 23, SPRITE_FISHER, STAY, DOWN, 6 ; person
	object_event 17,  5, SPRITE_GAMBLER, WALK, LEFT_RIGHT, 7 ; person
	object_event 18,  9, SPRITE_GAMBLER, STAY, NONE, 8
	object_event 25, 18, SPRITE_TRAVELER, STAY, ANY_DIR, 9 ; new, traveler

	def_warps_to VIRIDIAN_CITY
