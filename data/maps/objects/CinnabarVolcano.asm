CinnabarVolcano_Object:
	db $7d ; border block

	def_warp_events
	warp_event 20, 41, CINNABAR_ISLAND, 6
	warp_event 21, 41, CINNABAR_ISLAND, 6
	warp_event 20, 20, CINNABAR_VOLCANO_BF, 1
	warp_event 20, 32, CINNABAR_VOLCANO_BF, 2
	warp_event 35, 25, CINNABAR_VOLCANO_BF, 3
	warp_event  4, 24, CINNABAR_VOLCANO_BF, 4
	warp_event 29, 22, CINNABAR_VOLCANO_BF, 5
	warp_event 27,  2, CINNABAR_VOLCANO_BF, 6

	def_bg_events
	bg_event 19, 41,  1 ; CinnabarVolcanoText1

	def_object_events
;	object_event  5, 30, SPRITE_HIKER, STAY, DOWN, 1, OPP_HIKER, 1
;	object_event  2, 44, SPRITE_POKE_BALL, STAY, NONE, 8, POTION

	def_warps_to CINNABAR_VOLCANO
