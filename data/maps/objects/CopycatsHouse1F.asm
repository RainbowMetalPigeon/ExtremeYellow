CopycatsHouse1F_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 1
	warp_event  3,  7, LAST_MAP, 1
	warp_event  7,  1, COPYCATS_HOUSE_1F, 4
	; 2F
	warp_event 21,  1, COPYCATS_HOUSE_1F, 3

	def_bg_events
	; 2F
	bg_event 17,  5, 9  ; CopycatsHouse2FText6
	bg_event 14,  1, 10 ; CopycatsHouse2FText7
	bg_event 16,  1, 11 ; CopycatsHouse2FText8 ; new

	def_object_events
	object_event  2,  2, SPRITE_MIDDLE_AGED_WOMAN, STAY, DOWN, 1 ; parent 1
	object_event  5,  4, SPRITE_ERIKA, STAY, LEFT, 2 ; parent 2, edited
	object_event  1,  4, SPRITE_CHANSEY, STAY, NONE, 3 ; person
	; 2F
	object_event 18,  3, SPRITE_BRUNETTE_GIRL, WALK, ANY_DIR, 4 ; person
	object_event 18,  6, SPRITE_BIRD, WALK, LEFT_RIGHT, 5 ; person
	object_event 19,  1, SPRITE_MONSTER, STAY, DOWN, 6 ; person
	object_event 16,  0, SPRITE_BIRD, STAY, DOWN, 7 ; person
	object_event 15,  6, SPRITE_FAIRY, STAY, RIGHT, 8 ; person

	def_warps_to COPYCATS_HOUSE_1F
