SeviiRoute36_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
	bg_event  4, 37, 15 ; SeviiRoute36SignText1

	def_object_events
	object_event  5, 38, SPRITE_SUPER_NERD, STAY, UP, 1 ; person grieving Onix
	; trainers
	object_event 16,  8, SPRITE_SUPER_NERD, STAY, LEFT, 2, OPP_ROCKER, 9
	object_event 16, 13, SPRITE_SUPER_NERD, STAY, ANY_DIR, 3, OPP_ROCKER, 10
	object_event 14, 26, SPRITE_SUPER_NERD, STAY, UP, 4, OPP_ROCKER, 11
	object_event 14, 18, SPRITE_SUPER_NERD, STAY, RIGHT, 5, OPP_ROCKER, 12
	object_event 17, 18, SPRITE_COOLTRAINER_F, STAY, LEFT, 6, OPP_COOLTRAINER, 82
	object_event 12,  5, SPRITE_SUPER_NERD, STAY, ANY_DIR, 7, OPP_BIRD_KEEPER, 23
	object_event 15, 12, SPRITE_SUPER_NERD, STAY, ANY_DIR, 8, OPP_BIRD_KEEPER, 24
	object_event 15, 27, SPRITE_SUPER_NERD, STAY, RIGHT, 9, OPP_BIRD_KEEPER, 25
	object_event  1, 19, SPRITE_SWIMMER, STAY, RIGHT, 10, OPP_SWIMMER, 25
	object_event  5, 23, SPRITE_SWIMMER, STAY, RIGHT, 11, OPP_SWIMMER, 26
	object_event 10, 12, SPRITE_SWIMMER, STAY, DOWN, 12, OPP_SWIMMER, 27 ; 3
	object_event  7, 17, SPRITE_SWIMMER, STAY, UP, 13, OPP_SWIMMER, 28 ; 4
	; non-persons
;	object_event  5, 29, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 11
	object_event  2, 47, SPRITE_POKE_BALL, STAY, NONE, 14, METAL_COAT

	def_warps_to SEVII_ROUTE_36
