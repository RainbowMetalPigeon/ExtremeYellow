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

	def_bg_events
	bg_event 31,  4, 7 ; SeviiTwoIslandHousesSignText1

	def_object_events
	object_event  2,  3, SPRITE_GAMBLER, WALK, UP_DOWN, 1
	object_event 19,  3, SPRITE_GIRL, STAY, LEFT, 2 ; tutor ball
	object_event 19,  4, SPRITE_COOLTRAINER_F, STAY, LEFT, 3 ; tutor field
	object_event 30,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 4 ; Tauros farmer
	object_event 34,  2, SPRITE_GIRL, WALK, LEFT_RIGHT, 5 ; Tauros farmer
	object_event 44,  5, SPRITE_BEAUTY, WALK, ANY_DIR, 6 ; gate
	object_event 47,  2, SPRITE_GRAMPS, STAY, ANY_DIR, 7 ; gate

	def_warps_to SEVII_TWO_ISLAND_HOUSES
