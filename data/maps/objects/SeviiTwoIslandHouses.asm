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
	object_event  2,  3, SPRITE_YOUNGSTER, WALK, UP_DOWN, 1
	object_event 19,  3, SPRITE_YOUNGSTER, STAY, LEFT, 2
	object_event 19,  4, SPRITE_YOUNGSTER, STAY, LEFT, 3
	object_event 30,  4, SPRITE_YOUNGSTER, STAY, RIGHT, 4
	object_event 34,  2, SPRITE_YOUNGSTER, WALK, LEFT_RIGHT, 5
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_TWO_ISLAND_HOUSES
