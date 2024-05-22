CeruleanCity_Object:
	db $a ; border block

	def_warp_events
	warp_event 27, 11, CERULEAN_TRASHED_HOUSE, 1
	warp_event 13, 15, CERULEAN_MELANIES_HOUSE, 1
	warp_event 19, 17, CERULEAN_POKECENTER, 1
	warp_event 30, 19, CERULEAN_GYM, 1
	warp_event 13, 25, BIKE_SHOP, 1
	warp_event 25, 25, CERULEAN_POKECENTER, 3 ; edited due to MERGING
	warp_event  4, 11, CERULEAN_CAVE_1F, 1
	warp_event 27,  9, CERULEAN_TRASHED_HOUSE, 3 ; maybe to be removed?
	warp_event  9, 11, CERULEAN_BADGE_HOUSE, 2
	warp_event  9,  9, CERULEAN_BADGE_HOUSE, 1
	warp_event 15, 11, CERULEAN_MELANIES_HOUSE, 3 ; 11, new, trade house
	warp_event 19, 25, CERULEAN_MELANIES_HOUSE, 5 ; 12, new, sad elder
	warp_event 35, 11, CERULEAN_MELANIES_HOUSE, 7 ; 13, new, baby expert
	warp_event 29, 25, CERULEAN_MELANIES_HOUSE, 9 ; 14, new, Misty's siblings

	def_bg_events
	bg_event 23, 19, 13 ; CeruleanCityText12
	bg_event 16, 28, 14 ; CeruleanCityText13
	bg_event 26, 25, 15 ; MartSignText
	bg_event 20, 17, 16 ; PokeCenterSignText
	bg_event 11, 25, 17 ; CeruleanCityText16
	bg_event 27, 21, 18 ; CeruleanCityText17

	def_object_events
	object_event 20,  2, SPRITE_BLUE, STAY, DOWN, 1 ; person
	object_event 30,  8, SPRITE_ROCKET, STAY, NONE, 2, OPP_ROCKET, 5
	object_event 31, 20, SPRITE_COOLTRAINER_M, STAY, DOWN, 3 ; person
	object_event 15, 18, SPRITE_SUPER_NERD, WALK, UP_DOWN, 4 ; person
	object_event  9, 21, SPRITE_SUPER_NERD, WALK, LEFT_RIGHT, 5 ; person
	object_event 28, 12, SPRITE_OFFICER_JENNY, STAY, DOWN, 6 ; person
	object_event 32, 27, SPRITE_COOLTRAINER_F, STAY, LEFT, 7 ; person, edited
	object_event 33, 27, SPRITE_POKE_BALL, STAY, DOWN, 8 ; person, edited
	object_event  9, 27, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 9 ; person
	object_event  4, 12, SPRITE_SUPER_NERD, STAY, DOWN, 10 ; person
	object_event 27, 12, SPRITE_OFFICER_JENNY, STAY, DOWN, 11 ; person
	object_event 23, 12, SPRITE_TRAVELER, STAY, ANY_DIR, 12 ; new, traveler

	def_warps_to CERULEAN_CITY
