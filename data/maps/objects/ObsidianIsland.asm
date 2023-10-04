ObsidianIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 17,  3, REDS_HOUSE_1F, 1 ; flower person
	warp_event 35,  5, REDS_HOUSE_1F, 1 ; pokemon center
	warp_event 19,  7, OBSIDIAN_WOOD, 1 ; entrance to WOOD - done
	warp_event 35, 11, REDS_HOUSE_1F, 1 ; poke mart
	warp_event 35, 21, REDS_HOUSE_1F, 1 ; fishing guru
	warp_event 35, 25, REDS_HOUSE_1F, 1 ; workers
	warp_event  9, 16, OBSIDIAN_WOOD, 3 ; exit WOOD - done
	warp_event  9, 17, OBSIDIAN_WOOD, 4 ; exit WOOD - done
	warp_event  8,  5, REDS_HOUSE_1F, 1 ; OBSIDIAN_MINES
	warp_event 17, 23, OBSIDIAN_WAREHOUSE, 1 ; warehouse1
	warp_event 20, 23, OBSIDIAN_WAREHOUSE, 3 ; warehouse2

	def_bg_events
	bg_event 27,  3, 15 ; welcome to city
	bg_event 36,  5, 16 ; PokeCenterSignText
	bg_event 36, 11, 17 ; MartSignText
	bg_event 39, 15, 18 ; pier
	bg_event 17,  9, 19 ; forest
	bg_event  9, 15, 20 ; forest
	bg_event  9,  6, 21 ; mines
	bg_event 18, 24, 22 ; warehouse

	def_object_events
	object_event  8,  6, SPRITE_ROCKET, STAY, DOWN, 1 ; guarding the mines
	object_event 28, 32, SPRITE_ROCKET, STAY, DOWN, 2 ; guarding the south bridge
	object_event 29, 32, SPRITE_ROCKET, STAY, DOWN, 3 ; guarding the south bridge
	object_event 39, 16, SPRITE_ROCKET, STAY, RIGHT, 4 ; guarding the east bridge
	object_event 28, 33, SPRITE_YOUNGSTER, STAY, DOWN, 5 ; enslaved at the bridge
	object_event 29, 33, SPRITE_SUPER_NERD, STAY, DOWN, 6 ; enslaved at the bridge
	object_event 14, 32, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 7 ; platform
	object_event  6, 36, SPRITE_SCIENTIST, STAY, RIGHT, 8 ; platform
	object_event 19, 24, SPRITE_OFFICER_JENNY, STAY, DOWN, 9 ; in front of warehouse
	object_event 25,  6, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 10 ; random citizen, north
	object_event 29, 12, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 11 ; random citizen, center
	object_event 34, 16, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 12 ; random citizen, east
	object_event 34, 29, SPRITE_FISHER, STAY, DOWN, 13 ; random citizen, south
	object_event  9,  1, SPRITE_POKE_BALL, STAY, NONE, 14, RARE_CANDY

	def_warps_to OBSIDIAN_ISLAND
