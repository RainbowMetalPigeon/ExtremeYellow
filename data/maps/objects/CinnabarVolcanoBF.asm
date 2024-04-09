CinnabarVolcanoBF_Object:
	db $7d ; border block

	def_warp_events
	warp_event  5,  1, CINNABAR_VOLCANO, 3
	warp_event 17,  1, CINNABAR_VOLCANO, 4
	warp_event 17,  7, CINNABAR_VOLCANO, 5
	warp_event 17, 13, CINNABAR_VOLCANO, 6
	warp_event 17, 19, CINNABAR_VOLCANO, 7
	warp_event 17, 25, CINNABAR_VOLCANO, 8

	def_bg_events
;	bg_event 19, 41,  1 ; CinnabarVolcanoText1

	def_object_events
	object_event  5, 21, SPRITE_MOLTRES, STAY, DOWN, 1, MOLTRES, 50 | OW_POKEMON ; edited, to go beyond 200
	object_event 16,  0, SPRITE_POKE_BALL, STAY, NONE, 2, LAVA_STONE ; new items
	object_event 16,  6, SPRITE_POKE_BALL, STAY, NONE, 3, FIRE_STONE
	object_event 16, 12, SPRITE_POKE_BALL, STAY, NONE, 4, MAGMA_STONE ; new items
	object_event 16, 18, SPRITE_POKE_BALL, STAY, NONE, 5, FIRE_STONE
	object_event 16, 24, SPRITE_POKE_BALL, STAY, NONE, 6, MOLTEN_STONE ; new items

	def_warps_to CINNABAR_VOLCANO_BF
