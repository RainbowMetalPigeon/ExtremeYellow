SeviiRoute32_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
	bg_event 15, 35, 8 ; SeviiRoute32SignText1

	def_object_events
	object_event 17, 38, SPRITE_YOUNGSTER, WALK, ANY_DIR, 1
	object_event 15, 12, SPRITE_SWIMMER, STAY, LEFT, 2, OPP_SWIMMER, 39
	object_event  7, 28, SPRITE_SWIMMER, STAY, RIGHT, 3, OPP_SWIMMER, 40
	object_event 21, 28, SPRITE_SWIMMER, STAY, LEFT, 4, OPP_POKEMANIAC, 18
	object_event 14, 25, SPRITE_POKE_BALL, STAY, NONE, 5, RARE_CANDY
	object_event 27, 35, SPRITE_POKE_BALL, STAY, NONE, 6, PP_UP
	object_event 22, 10, SPRITE_COOLTRAINER_F, STAY, DOWN, 7

	def_warps_to SEVII_ROUTE_32