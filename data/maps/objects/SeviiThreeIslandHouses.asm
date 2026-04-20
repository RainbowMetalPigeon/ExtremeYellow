SeviiThreeIslandHouses_Object:
	db $0c ; border block

	def_warp_events
	warp_event  2,  7, SEVII_THREE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_THREE_ISLAND_CITY, 6
	warp_event 16,  7, SEVII_THREE_ISLAND_CITY, 7
	warp_event 17,  7, SEVII_THREE_ISLAND_CITY, 7
	warp_event 20,  0, SEVII_THREE_ISLAND_SECRET_GARDEN, 1
	warp_event 30,  7, SEVII_THREE_ISLAND_CITY, 12
	warp_event 31,  7, SEVII_THREE_ISLAND_CITY, 12

	def_bg_events
	bg_event 19,  4,  6 ; SeviiThreeIslandHousesSignText1
	bg_event  0,  7,  7 ; SeviiThreeIslandHousesSignText2
	bg_event 14,  7,  8 ; SeviiThreeIslandHousesSignText3
	bg_event 30,  1,  9 ; SeviiThreeIslandHousesSignText4
	bg_event 14,  1, 10 ; SeviiThreeIslandHousesBookshelfText1
	bg_event 15,  1, 11 ; SeviiThreeIslandHousesBookshelfText2
	bg_event 16,  1, 12 ; SeviiThreeIslandHousesBookshelfText3
	bg_event 17,  1, 13 ; SeviiThreeIslandHousesBookshelfText4
	bg_event 18,  1, 14 ; SeviiThreeIslandHousesBookshelfText5
	bg_event 19,  1, 15 ; SeviiThreeIslandHousesBookshelfText6
	bg_event 20,  1, 16 ; SeviiThreeIslandHousesBookshelfText7
	bg_event 21,  1, 17 ; SeviiThreeIslandHousesBookshelfText8

	def_object_events
	object_event  5,  3, SPRITE_SUPER_NERD, STAY, RIGHT, 1 ; move tutor terrains
	object_event 19,  6, SPRITE_BEAUTY, STAY, UP, 2
	object_event 15,  5, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 3
	object_event 30,  4, SPRITE_CHANNELER, WALK, ANY_DIR, 4
	object_event 33,  6, SPRITE_SCIENTIST, WALK, ANY_DIR, 5

	def_warps_to SEVII_THREE_ISLAND_HOUSES
