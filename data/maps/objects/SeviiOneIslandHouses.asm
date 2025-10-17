SeviiOneIslandHouses_Object:
	db $0c ; border block

	def_warp_events
	warp_event  2,  7, SEVII_ONE_ISLAND_CITY, 6
	warp_event  3,  7, SEVII_ONE_ISLAND_CITY, 6
	warp_event 16,  7, SEVII_ONE_ISLAND_CITY, 7
	warp_event 17,  7, SEVII_ONE_ISLAND_CITY, 7
	warp_event 16,  0, SEVII_ONE_ISLAND_CITY, 8

	def_bg_events
	bg_event  0,  7,  9 ; SeviiOneIslandHousesSignText1
	bg_event 19,  3, 10 ; SeviiOneIslandHousesSignText2
	bg_event 14,  1, 11 ; SeviiOneIslandHousesSignText3
	bg_event 21,  1, 12 ; SeviiOneIslandHousesSignText4

	def_object_events
	object_event  2,  3, SPRITE_FISHING_GURU, STAY, LEFT, 1 ; weather move tutor
	; Celio's house
	object_event 17,  4, SPRITE_SUPER_NERD, WALK, ANY_DIR, 2 ; Celio, before rescue
	object_event 17,  3, SPRITE_SUPER_NERD, STAY, LEFT, 3 ; Celio, right after rescue
	object_event 19,  1, SPRITE_SUPER_NERD, STAY, DOWN, 4 ; Celio, after rescue
	object_event 16,  3, SPRITE_LITTLE_GIRL, WALK, RIGHT, 5 ; Mayoi (Lostelle) right after rescue
	object_event 16,  4, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 6 ; Mayoi after rescue
	object_event 17,  7, SPRITE_PINK, STAY, UP, 7 ; Pink
	object_event 15,  2, SPRITE_MONSTER, STAY, DOWN, 8 ; plushie

	def_warps_to SEVII_ONE_ISLAND_HOUSES
