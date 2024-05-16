ObsidianPokecenter_Object:
	db $0 ; border block

	def_warp_events
	warp_event  3,  7, OBSIDIAN_ISLAND, 2
	warp_event  4,  7, OBSIDIAN_ISLAND, 2
	warp_event 23,  7, OBSIDIAN_ISLAND, 4
	warp_event 24,  7, OBSIDIAN_ISLAND, 4

	def_bg_events

	def_object_events
	object_event  3,  1, SPRITE_NURSE, STAY, DOWN, 1 ; fixed
	object_event  9,  6, SPRITE_FISHING_GURU, STAY, NONE, 2 ; custom
	object_event  6,  4, SPRITE_SAILOR, STAY, NONE, 3 ; custom
	object_event 11,  2, SPRITE_LINK_RECEPTIONIST, STAY, DOWN, 4 ; fixed
	object_event  4,  1, SPRITE_CHANSEY, STAY, DOWN, 5 ; fixed
	; mart
	object_event 20,  5, SPRITE_CLERK, STAY, RIGHT, 6 ; fixed
	object_event 25,  6, SPRITE_FISHER, STAY, NONE, 7 ; custom
	object_event 23,  3, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 8 ; custom
	object_event 20,  6, SPRITE_CLERK, STAY, RIGHT, 9 ; new, TM seller

	def_warps_to OBSIDIAN_POKECENTER
