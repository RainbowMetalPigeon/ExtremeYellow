ObsidianHouses_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, OBSIDIAN_ISLAND, 1
	warp_event  3,  7, OBSIDIAN_ISLAND, 1
	warp_event 16,  7, OBSIDIAN_ISLAND, 5
	warp_event 17,  7, OBSIDIAN_ISLAND, 5
	warp_event 30,  7, OBSIDIAN_ISLAND, 6
	warp_event 31,  7, OBSIDIAN_ISLAND, 6

	def_bg_events
	bg_event  3,  3,  8 ; ObsidianHousesTextFlowerNotes
	bg_event 16,  0,  9 ; ObsidianHousesTextFishingBoard
	bg_event 17,  0, 10 ; ObsidianHousesTextFishingBoard

	def_object_events
	object_event  3,  4, SPRITE_GIRL, STAY, UP, 1 ; flower enthusiast
	object_event 16,  3, SPRITE_FISHING_GURU, STAY, RIGHT, 2 ; fishing super guru
	object_event 30,  3, SPRITE_YOUNGSTER, STAY, RIGHT, 3 ; family
	object_event 30,  4, SPRITE_COOLTRAINER_M, STAY, RIGHT, 4 ; family
	object_event 33,  3, SPRITE_HIKER, STAY, LEFT, 5 ; family
	object_event 33,  4, SPRITE_LITTLE_GIRL, STAY, LEFT, 6 ; family
	object_event 32,  2, SPRITE_GRANNY, STAY, DOWN, 7 ; family

	def_warps_to OBSIDIAN_HOUSES
