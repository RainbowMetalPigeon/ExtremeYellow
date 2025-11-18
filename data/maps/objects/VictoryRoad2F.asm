VictoryRoad2F_Object:
	db $7d ; border block

	def_warp_events
	warp_event  0,  8, VICTORY_ROAD_1F, 3
	warp_event 29,  7, ROUTE_23, 4
	warp_event 29,  8, ROUTE_23, 4
	warp_event 23,  7, VICTORY_ROAD_3F, 1
	warp_event 25, 14, VICTORY_ROAD_3F, 3
	warp_event 27,  7, VICTORY_ROAD_3F, 2
	warp_event  1,  1, VICTORY_ROAD_3F, 4

	def_bg_events

	def_object_events
	object_event 12,  9, SPRITE_HIKER, STAY, ANY_DIR, 1, OPP_BLACKBELT, 9
	object_event 21, 13, SPRITE_SUPER_NERD, STAY, ANY_DIR, 2, OPP_JUGGLER, 2
	object_event 19,  8, SPRITE_COOLTRAINER_M, STAY, ANY_DIR, 3, OPP_TAMER, 5
	object_event  4,  1, SPRITE_SUPER_NERD, STAY, ANY_DIR, 4, OPP_POKEMANIAC, 6
	object_event 26,  2, SPRITE_SUPER_NERD, STAY, ANY_DIR, 5, OPP_JUGGLER, 5
	object_event 11,  5, SPRITE_COOLTRAINER_M, STAY, ANY_DIR, 6, OPP_BIRD_KEEPER, 19 ; new, it was Moltres
;	object_event 11,  5, SPRITE_MOLTRES, STAY, DOWN, 6, MOLTRES, 50 ; move to Volcano
	object_event 27,  5, SPRITE_POKE_BALL, STAY, NONE, 7, TM_DRAININGKISS
	object_event 18,  9, SPRITE_POKE_BALL, STAY, NONE, 8, FULL_HEAL
	object_event  9, 11, SPRITE_POKE_BALL, STAY, NONE, 9, TM_DRAGON_CLAW
	object_event 11,  0, SPRITE_POKE_BALL, STAY, NONE, 10, GUARD_SPEC
	object_event  4, 14, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 11 ; person
	object_event  5,  5, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 12 ; person
	object_event 23, 16, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 13 ; person
	object_event 20,  1, SPRITE_KOGA_GL, STAY, ANY_DIR, 14 ; new, Koga, testing as last

	def_warps_to VICTORY_ROAD_2F
