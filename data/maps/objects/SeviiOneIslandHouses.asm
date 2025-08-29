SeviiOneIslandHouses_Object:
	db $0c ; border block

	def_warp_events
	warp_event  2,  7, SEVII_ONE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_ONE_ISLAND_CITY, 6
	warp_event 16,  7, SEVII_ONE_ISLAND_CITY, 7
	warp_event 17,  7, SEVII_ONE_ISLAND_CITY, 7
	warp_event 16,  0, SEVII_ONE_ISLAND_CITY, 8

	def_bg_events
	bg_event  0,  7, 4 ; SeviiOneIslandHousesSignText1
	bg_event 19,  3, 5 ; SeviiOneIslandHousesSignText2
	bg_event 14,  1, 6 ; SeviiOneIslandHousesSignText3
	bg_event 21,  1, 7 ; SeviiOneIslandHousesSignText4

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, STAY, LEFT, 1 ; weather move tutor
	object_event 19,  1, SPRITE_SUPER_NERD, STAY, DOWN, 2 ; Celio
	object_event 16,  4, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 3 ; Mayoi (Lostelle)

	def_warps_to SEVII_ONE_ISLAND_HOUSES
