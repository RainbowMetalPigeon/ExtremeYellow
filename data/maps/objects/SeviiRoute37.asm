SeviiRoute37_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
;	bg_event  4, 37, 15 ; SeviiRoute36SignText1

	def_object_events
;	object_event  5, 38, SPRITE_SUPER_NERD, STAY, UP, 1 ;
	; trainers
	object_event  9, 30, SPRITE_COOLTRAINER_F, STAY, LEFT, 1, OPP_COOLTRAINER, 83 ; 3
	object_event  8, 35, SPRITE_COOLTRAINER_F, STAY, UP, 2, OPP_COOLTRAINER, 84 ; 4
	object_event 10, 32, SPRITE_COOLTRAINER_F, STAY, UP, 3, OPP_COOLTRAINER, 85 ; 4
	object_event  8, 40, SPRITE_COOLTRAINER_F, STAY, RIGHT, 4, OPP_COOLTRAINER, 86 ; 4
	object_event  7, 42, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 5, OPP_COOLTRAINER, 87 ; 4
	object_event 11, 42, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 6, OPP_COOLTRAINER, 88 ; 4
	object_event  8, 24, SPRITE_HIKER, STAY, ANY_DIR, 7, OPP_HIKER, 20 ; 4
	object_event 16,  4, SPRITE_SWIMMER, STAY, DOWN, 8, OPP_SWIMMER, 29 ; 4
	object_event 15,  9, SPRITE_SWIMMER, STAY, LEFT, 9, OPP_SWIMMER, 30 ; 4
	object_event 12, 12, SPRITE_SWIMMER, STAY, UP, 10, OPP_SWIMMER, 31 ; 4
	object_event  6, 11, SPRITE_SWIMMER, STAY, RIGHT, 11, OPP_SWIMMER, 32 ; 4
	object_event  9,  5, SPRITE_SWIMMER, STAY, ANY_DIR, 12, OPP_SWIMMER, 33 ; 4
	; non-persons
	object_event 11, 46, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 13
;	object_event  2, 47, SPRITE_POKE_BALL, STAY, NONE, 14, METAL_COAT

	def_warps_to SEVII_ROUTE_37
