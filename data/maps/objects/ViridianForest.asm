ViridianForest_Object:
	db $3 ; border block

	def_warp_events ; edited because of map MERGING
	warp_event  1,  0, ROUTE_2_ALL_GATES, 11
	warp_event  2,  0, ROUTE_2_ALL_GATES, 11
	warp_event 15, 47, ROUTE_2_ALL_GATES, 6
	warp_event 16, 47, ROUTE_2_ALL_GATES, 6
	warp_event 17, 47, ROUTE_2_ALL_GATES, 6
	warp_event 18, 47, ROUTE_2_ALL_GATES, 6

	def_bg_events
	bg_event 24, 40, 12 ; ViridianForestText9
	bg_event 16, 32, 13 ; ViridianForestText10
	bg_event 26, 17, 14 ; ViridianForestText11
	bg_event  4, 24, 15 ; ViridianForestText12
	bg_event 18, 45, 16 ; ViridianForestText13
	bg_event  2,  1, 17 ; ViridianForestText14

	def_object_events
	object_event  1, 30, SPRITE_ERIKA, STAY, ANY_DIR, 1 ; new
	object_event 16, 43, SPRITE_YOUNGSTER, STAY, NONE, 2 ; person
	object_event 30, 33, SPRITE_YOUNGSTER, STAY, LEFT, 3, OPP_BUG_CATCHER, 1
	object_event 30, 19, SPRITE_YOUNGSTER, STAY, LEFT, 4, OPP_BUG_CATCHER, 2
	object_event  2, 18, SPRITE_YOUNGSTER, STAY, LEFT, 5, OPP_BUG_CATCHER, 3
	object_event  2, 41, SPRITE_COOLTRAINER_F, STAY, NONE, 6, OPP_LASS, 19
	object_event 13, 17, SPRITE_YOUNGSTER, STAY, RIGHT, 7, OPP_BUG_CATCHER, 15
	object_event 25, 11, SPRITE_POKE_BALL, STAY, NONE, 8, POTION
	object_event 12, 29, SPRITE_POKE_BALL, STAY, NONE, 9, POTION
	object_event  1, 31, SPRITE_POKE_BALL, STAY, NONE, 10, POKE_BALL
	object_event 27, 40, SPRITE_YOUNGSTER, STAY, NONE, 11 ; person

	def_warps_to VIRIDIAN_FOREST
