SeviiTwoIslandHouses_Object:
	db $0a ; border block

	def_warp_events
	warp_event  2,  7, SEVII_TWO_ISLAND_CITY, 5
	warp_event  3,  7, SEVII_TWO_ISLAND_CITY, 5
	warp_event 16,  7, SEVII_TWO_ISLAND_CITY, 6
	warp_event 17,  7, SEVII_TWO_ISLAND_CITY, 6
	warp_event 30,  7, SEVII_TWO_ISLAND_CITY, 7
	warp_event 31,  7, SEVII_TWO_ISLAND_CITY, 7

	def_bg_events
	bg_event 31,  4, 6 ; SeviiTwoIslandHousesSignText1
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  2,  3, SPRITE_GAMBLER, WALK, UP_DOWN, 1
	object_event 19,  3, SPRITE_COOLTRAINER_M, STAY, LEFT, 2 ; tutor ball
	object_event 19,  4, SPRITE_COOLTRAINER_F, STAY, LEFT, 3 ; tutor field
	object_event 30,  4, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 4 ; Tauros farmer
	object_event 34,  2, SPRITE_GIRL, WALK, LEFT_RIGHT, 5 ; Tauros farmer

	def_warps_to SEVII_TWO_ISLAND_HOUSES
