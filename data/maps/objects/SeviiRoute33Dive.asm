SeviiRoute33Dive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 38, 19, SEVII_ROUTE_33_DIVE_CAVERN_F1, 1

	def_bg_events
;	bg_event 15, 35, 1 ; SeviiRoute33Text1

	def_object_events
	object_event 83,  7, SPRITE_DIVER, WALK, ANY_DIR, 1
	object_event 22, 16, SPRITE_DIVER, STAY, LEFT, 2, OPP_DIVER,  17
	object_event 48, 21, SPRITE_DIVER, STAY, UP, 3, OPP_DIVER, 18
	object_event 46,  2, SPRITE_DIVER, STAY, DOWN, 4, OPP_DIVER, 19
	object_event 56, 14, SPRITE_DIVER, STAY, UP, 5, OPP_DIVER, 20
	object_event 67,  2, SPRITE_POKE_BALL, STAY, NONE, 6, MAX_REVIVE
	object_event 97, 21, SPRITE_POKE_BALL, STAY, NONE, 7, ELIXER

	def_warps_to SEVII_ROUTE_33_DIVE