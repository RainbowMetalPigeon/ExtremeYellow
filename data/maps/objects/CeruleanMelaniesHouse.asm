CeruleanMelaniesHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, CERULEAN_CITY, 2
	warp_event  3,  7, CERULEAN_CITY, 2
	; new, trade house
	warp_event 16,  7, CERULEAN_CITY, 11
	warp_event 17,  7, CERULEAN_CITY, 11
	; new, sad elder
	warp_event 30,  7, CERULEAN_CITY, 12
	warp_event 31,  7, CERULEAN_CITY, 12
	; new, baby expert?
	warp_event 44,  7, CERULEAN_CITY, 13
	warp_event 45,  7, CERULEAN_CITY, 13
	
	def_bg_events
	bg_event 45,  0,  9 ; sign
	bg_event 45,  4, 10 ; sign

	def_object_events
	object_event  3,  1, SPRITE_GIRL, STAY, DOWN, 1 ; person
	object_event  4,  1, SPRITE_BULBASAUR, STAY, DOWN, 2 ; person
	object_event  1,  4, SPRITE_ODDISH, STAY, NONE, 3 ; person
	object_event  5,  3, SPRITE_SANDSHREW, STAY, LEFT, 4 ; person
	; new, trade house
	object_event 16,  3, SPRITE_ERIKA, WALK, ANY_DIR, 5 ; person
	object_event 19,  4, SPRITE_MIDDLE_AGED_WOMAN, WALK, ANY_DIR, 6 ; person
	; new, sad elder
	object_event 30,  3, SPRITE_GRAMPS, STAY, RIGHT, 7 ; person
	; new, baby expert?
	object_event 44,  1, SPRITE_GRANNY, STAY, UP, 8 ; person

	def_warps_to CERULEAN_MELANIES_HOUSE
