SeviiTwoIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_TWO_ISLAND_CITY, 5
	warp_event  3,  7, SEVII_TWO_ISLAND_CITY, 5
	warp_event 16,  7, SEVII_TWO_ISLAND_CITY, 6
	warp_event 17,  7, SEVII_TWO_ISLAND_CITY, 6
	warp_event 30,  7, SEVII_TWO_ISLAND_CITY, 7
	warp_event 31,  7, SEVII_TWO_ISLAND_CITY, 7
	warp_event 46,  7, SEVII_TWO_ISLET, 1 ;  7
	warp_event 47,  7, SEVII_TWO_ISLET, 1 ;  8
	warp_event 46,  0, SEVII_TWO_ISLAND_CITY, 10 ;  9
	warp_event 60,  7, SEVII_TWO_ISLAND_CITY, 11 ; 10
	warp_event 61,  7, SEVII_TWO_ISLAND_CITY, 11 ; 11

	def_bg_events
	bg_event 31,  4, 12 ; SeviiTwoIslandHousesSignText1
	bg_event 61,  4, 13 ; SeviiTwoIslandHousesSignText2
	bg_event 58,  1, 14 ; SeviiTwoIslandHousesSignText3
	bg_event 59,  1, 15 ; SeviiTwoIslandHousesSignText3
	bg_event 64,  1, 16 ; SeviiTwoIslandHousesSignText3
	bg_event 65,  1, 17 ; SeviiTwoIslandHousesSignText3

	def_object_events
	object_event  2,  3, SPRITE_GAMBLER, WALK, UP_DOWN, 1
	object_event 19,  3, SPRITE_GIRL, STAY, LEFT, 2 ; tutor ball
	object_event 19,  4, SPRITE_COOLTRAINER_F, STAY, LEFT, 3 ; tutor field
	object_event 30,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 4 ; Tauros farmer
	object_event 34,  2, SPRITE_GIRL, WALK, LEFT_RIGHT, 5 ; Tauros farmer
	object_event 44,  5, SPRITE_BEAUTY, WALK, ANY_DIR, 6 ; gate
	object_event 47,  2, SPRITE_GRAMPS, STAY, ANY_DIR, 7 ; gate
	object_event 60,  4, SPRITE_COOLTRAINER_F, STAY, RIGHT, 8
	object_event 63,  3, SPRITE_BEAUTY, STAY, LEFT, 9
	object_event 61,  0, SPRITE_PAPER, STAY, NONE, 10
	object_event 62,  3, SPRITE_CLIPBOARD, STAY, NONE, 11

	def_warps_to SEVII_TWO_ISLAND_HOUSES
