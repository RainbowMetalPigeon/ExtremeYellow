MrPsychicsHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 8
	warp_event  3,  7, LAST_MAP, 8
	; poly pidgey house
	warp_event 16,  7, LAST_MAP, 4
	warp_event 17,  7, LAST_MAP, 4
	; apartments, new
	warp_event 30,  7, SAFFRON_CITY, 10 ; 5
	warp_event 31,  7, SAFFRON_CITY, 10 ; 6
	warp_event 35,  1, MR_PSYCHICS_HOUSE,  8 ;  7
	warp_event 42,  1, MR_PSYCHICS_HOUSE,  7 ;  8
	warp_event 49,  1, MR_PSYCHICS_HOUSE, 10 ;  9
	warp_event 56,  1, MR_PSYCHICS_HOUSE,  9 ; 10

	def_bg_events
	bg_event 46,  4, 13 ; SaffronNewApartmentsSignText1

	def_object_events
	object_event  5,  3, SPRITE_FISHING_GURU, STAY, LEFT, 1 ; person
	object_event  2,  3, SPRITE_SABRINA, STAY, RIGHT, 2 ; new, Sabrina 
	; poly pidgey house
	object_event 16,  3, SPRITE_BRUNETTE_GIRL, STAY, RIGHT, 3 ; person
	object_event 14,  4, SPRITE_BIRD, WALK, UP_DOWN, 4 ; person
	object_event 18,  1, SPRITE_COOLTRAINER_M, STAY, DOWN, 5 ; person, edited
	object_event 17,  3, SPRITE_PAPER, STAY, NONE, 6 ; person
	; apartments, new
	object_event 30,  4, SPRITE_FISHING_GURU, STAY, RIGHT, 7 ; person
	object_event 33,  3, SPRITE_BRUNETTE_GIRL, STAY, LEFT, 8 ; person
	object_event 33,  4, SPRITE_COOLTRAINER_M, STAY, LEFT, 9 ; person
	object_event 46,  6, SPRITE_LITTLE_GIRL, STAY, UP, 10 ; person
	object_event 44,  4, SPRITE_GAMEBOY_KID, STAY, DOWN, 11 ; person
	object_event 59,  4, SPRITE_COOLTRAINER_M, STAY, DOWN, 12 ; person

	def_warps_to MR_PSYCHICS_HOUSE
