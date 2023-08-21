ObsidianIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 17,  3, REDS_HOUSE_1F, 1 ; flower person
	warp_event 35,  5, REDS_HOUSE_1F, 1 ; pokemon center
	warp_event 19,  7, REDS_HOUSE_1F, 1 ; entrance to forest, may need to change a tile behaviour
	warp_event 35, 11, REDS_HOUSE_1F, 1 ; poke mart
	warp_event 35, 21, REDS_HOUSE_1F, 1 ; fishing guru
	warp_event 35, 25, REDS_HOUSE_1F, 1 ; workers
	warp_event  9, 16, REDS_HOUSE_1F, 1 ; exit forest, to check
	warp_event  9, 17, REDS_HOUSE_1F, 1 ; exit forest, to check
	warp_event  8,  5, REDS_HOUSE_1F, 1 ; OBSIDIAN_MINES
	warp_event 18, 23, REDS_HOUSE_1F, 1 ; warehouse

	def_bg_events
	bg_event 27,  3, 1 ; welcome to city
	bg_event 36,  5, 2 ; PokeCenterSignText
	bg_event 36, 11, 3 ; MartSignText
	bg_event 39, 15, 4 ; pier
	bg_event 17,  9, 5 ; forest
	bg_event  9, 15, 6 ; forest
	bg_event  9,  6, 7 ; mines
	bg_event 20, 24, 8 ; warehouse

	def_object_events

	def_warps_to OBSIDIAN_ISLAND
