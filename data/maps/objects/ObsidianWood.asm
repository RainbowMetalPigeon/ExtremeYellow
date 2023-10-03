ObsidianWood_Object:
	db $3 ; border block

	def_warp_events
	warp_event 22,  0, OBSIDIAN_ISLAND, 3
	warp_event 23,  0, OBSIDIAN_ISLAND, 3
	warp_event  0, 30, OBSIDIAN_ISLAND, 7
	warp_event  0, 31, OBSIDIAN_ISLAND, 8

	def_bg_events
	bg_event 24,  2, 5 ; ObsidianWoodTextSignEntrance
	bg_event 32, 10, 6 ; ObsidianWoodTextSignSpiral
	bg_event 10,  9, 7 ; ObsidianWoodTextSignPlateau
	bg_event  2, 30, 8 ; ObsidianWoodTextSignExit

	def_object_events
	object_event 24, 25, SPRITE_YOUNGSTER, STAY, ANY_DIR, 1, OPP_BUG_CATCHER, 12

	object_event  1, 46, SPRITE_POKE_BALL, STAY, NONE, 2, MAX_ETHER
	object_event 32, 46, SPRITE_POKE_BALL, STAY, NONE, 3, MAX_ELIXER
	object_event 14, 16, SPRITE_POKE_BALL, STAY, NONE, 4, ULTRA_BALL

	def_warps_to OBSIDIAN_WOOD
