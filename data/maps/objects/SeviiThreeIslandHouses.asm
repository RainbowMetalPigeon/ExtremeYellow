SeviiThreeIslandHouses_Object:
	db $0c ; border block

	def_warp_events
	warp_event  2,  7, SEVII_THREE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_THREE_ISLAND_CITY, 6
	warp_event 16,  7, SEVII_THREE_ISLAND_CITY, 7
	warp_event 17,  7, SEVII_THREE_ISLAND_CITY, 7
	warp_event 20,  0, SEVII_THREE_ISLAND_SECRET_GARDEN, 1

	def_bg_events
	bg_event 19,  4,  4 ; SeviiThreeIslandHousesSignText1
	bg_event  0,  7,  5 ; SeviiThreeIslandHousesSignText2
	bg_event 14,  7,  6 ; SeviiThreeIslandHousesSignText3
	bg_event 14,  1,  8 ; SeviiThreeIslandHousesBookshelfText1
	bg_event 15,  1,  9 ; SeviiThreeIslandHousesBookshelfText2
	bg_event 16,  1,  9 ; SeviiThreeIslandHousesBookshelfText3
	bg_event 17,  1, 10 ; SeviiThreeIslandHousesBookshelfText4
	bg_event 18,  1, 11 ; SeviiThreeIslandHousesBookshelfText5
	bg_event 19,  1, 12 ; SeviiThreeIslandHousesBookshelfText6
	bg_event 20,  1, 13 ; SeviiThreeIslandHousesBookshelfText7
	bg_event 21,  1, 14 ; SeviiThreeIslandHousesBookshelfText8

	def_object_events
	object_event  5,  3, SPRITE_SUPER_NERD, STAY, RIGHT, 1 ; move tutor terrains
	object_event 19,  6, SPRITE_BEAUTY, STAY, UP, 2
	object_event 15,  5, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 3

	def_warps_to SEVII_THREE_ISLAND_HOUSES
