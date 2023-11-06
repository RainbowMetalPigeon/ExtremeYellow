ObsidianIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 17,  3, REDS_HOUSE_1F, 1 ; flower person - TODO
	warp_event 35,  5, REDS_HOUSE_1F, 1 ; pokemon center - TODO
	warp_event 19,  7, OBSIDIAN_WOOD, 1 ; entrance to wood
	warp_event 35, 11, REDS_HOUSE_1F, 1 ; poke mart - TODO
	warp_event 35, 21, REDS_HOUSE_1F, 1 ; fishing guru - TODO
	warp_event 35, 25, REDS_HOUSE_1F, 1 ; workers - TODO
	warp_event  9, 16, OBSIDIAN_WOOD, 3 ; exit wood
	warp_event  9, 17, OBSIDIAN_WOOD, 4 ; exit wood
	warp_event  8,  5, OBSIDIAN_MINES, 1 ; mines
	warp_event 17, 23, OBSIDIAN_WAREHOUSE, 1 ; warehouse1
	warp_event 20, 23, OBSIDIAN_WAREHOUSE, 3 ; warehouse2

	def_bg_events
	bg_event 27,  3, 14 ; welcome to city
	bg_event 36,  5, 15 ; PokeCenterSignText
	bg_event 36, 11, 16 ; MartSignText
	bg_event 39, 15, 17 ; pier
	bg_event 17,  9, 18 ; forest
	bg_event  9, 15, 19 ; forest
	bg_event  9,  6, 20 ; mines
	bg_event 18, 24, 21 ; warehouse

	def_object_events
	; seen before Giovanni's defeat
	object_event  8,  6, SPRITE_ROCKET, STAY, DOWN, 1 ; guarding the mines
	object_event 28, 32, SPRITE_ROCKET, STAY, DOWN, 2 ; guarding the south bridge
	object_event 29, 32, SPRITE_ROCKET, STAY, DOWN, 3 ; guarding the south bridge
;	object_event 39, 16 ; former Rocket guarding east bridge, nice spot for Traveler?
	object_event 28, 33, SPRITE_YOUNGSTER, STAY, DOWN, 4 ; enslaved at the bridge
	object_event 29, 33, SPRITE_SUPER_NERD, STAY, DOWN, 5 ; enslaved at the bridge
	; seen before Giovanni's defeat
	object_event 14, 32, SPRITE_SCIENTIST, WALK, LEFT_RIGHT, 6 ; platform
	object_event  6, 36, SPRITE_SCIENTIST, STAY, RIGHT, 7 ; platform
	object_event 19, 24, SPRITE_OFFICER_JENNY, STAY, DOWN, 8 ; in front of warehouse
	object_event 25,  6, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 9 ; random citizen, north
	object_event 29, 12, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 10 ; random citizen, center
	object_event 34, 16, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 11 ; random citizen, east
	object_event 34, 29, SPRITE_FISHER, STAY, DOWN, 12 ; random citizen, south
	; items
	object_event  9,  1, SPRITE_POKE_BALL, STAY, NONE, 13, RARE_CANDY
	
	def_warps_to OBSIDIAN_ISLAND
