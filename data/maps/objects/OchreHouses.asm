OchreHouses_Object:
	db $a ; border block

	def_warp_events
	; house 1
	warp_event  2, 11, OCHRE_CITY, 1 ; 1
	warp_event  3, 11, OCHRE_CITY, 1 ; 2
	; house 2
	warp_event 30, 11, OCHRE_CITY, 2 ; 3
	warp_event 31, 11, OCHRE_CITY, 2 ; 4
	; brib fun club
	warp_event 46, 11, OCHRE_CITY, 5 ; 5
	warp_event 47, 11, OCHRE_CITY, 5 ; 6
	; internal, stairs
	warp_event  7,  5, OCHRE_HOUSES, 8 ; 7
	warp_event 21,  5, OCHRE_HOUSES, 7 ; 8

	def_bg_events
	bg_event 31,  9, 13 ; OchreHousesTextNotebook

	def_object_events
	; room 1: deleter and reminder
	object_event  2,  8, SPRITE_GRANNY, STAY, RIGHT, 1 ; person
	object_event  5,  8, SPRITE_GRANNY, STAY, LEFT, 2 ; person
	; room 2: reactivate trainers
	object_event 17, 10, SPRITE_CHANNELER, STAY, UP, 3 ; person
	; room 3: magikarp tutor
	object_event 32,  6, SPRITE_SCIENTIST, STAY, UP, 4 ; person
	; room 4: brib fun club
	object_event 45,  6, SPRITE_GIRL, STAY, RIGHT, 5 ; person
	object_event 48,  3, SPRITE_COOLTRAINER_M, STAY, DOWN, 6 ; person
	object_event 50,  5, SPRITE_COOLTRAINER_F, STAY, LEFT, 7 ; person
	object_event 51,  9, SPRITE_BIRD, WALK, ANY_DIR, 8 ; bird
	object_event 44,  8, SPRITE_BIRD, WALK, ANY_DIR, 9 ; bird
	object_event 45,  2, SPRITE_BIRD, WALK, ANY_DIR, 10 ; bird
	object_event 52,  3, SPRITE_BIRD, WALK, ANY_DIR, 11 ; bird
	object_event 48,  0, SPRITE_PAPER, STAY, NONE, 12 ; piece of map

	def_warps_to OCHRE_HOUSES
