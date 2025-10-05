SeviiRoute37_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
	bg_event  4, 37, 15 ; SeviiRoute36SignText1

	def_object_events
;	object_event  5, 38, SPRITE_SUPER_NERD, STAY, UP, 1 ;
	; trainers

	object_event  9, 30, SPRITE_COOLTRAINER_F, STAY, LEFT, 6, OPP_COOLTRAINER, 82 ; 3
	object_event  8, 35, SPRITE_COOLTRAINER_F, STAY, UP, 6, OPP_COOLTRAINER, 82 ; 4
	object_event 10, 32, SPRITE_COOLTRAINER_F, STAY, UP, 6, OPP_COOLTRAINER, 82 ; 4
	object_event  8, 40, SPRITE_COOLTRAINER_F, STAY, RIGHT, 6, OPP_COOLTRAINER, 82 ; 4

	object_event  7, 42, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 6, OPP_COOLTRAINER, 82 ; 4

	; non-persons
;	object_event  5, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 11
;	object_event  2, 47, SPRITE_POKE_BALL, STAY, NONE, 14, METAL_COAT

	def_warps_to SEVII_ROUTE_37
