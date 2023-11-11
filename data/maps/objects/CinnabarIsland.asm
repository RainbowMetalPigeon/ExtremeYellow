CinnabarIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 36,  3, POKEMON_MANSION_1F, 2
	warp_event 48,  3, CINNABAR_GYM, 1
	warp_event 36,  9, CINNABAR_LAB, 1
	warp_event 41, 11, CINNABAR_POKECENTER, 1
	warp_event 45, 11, CINNABAR_MART, 1
	warp_event 17, 17, REDS_HOUSE_1F, 1 ; new, testing

	def_bg_events
	bg_event 39,  5, 7 ; CinnabarIslandText3
	bg_event 46, 11, 8 ; MartSignText
	bg_event 42, 11, 9 ; PokeCenterSignText
	bg_event 39, 11, 10 ; CinnabarIslandText6
	bg_event 43,  3, 11 ; CinnabarIslandText7
	bg_event 33, 17, 12 ; CinnabarIslandTextVulcano, new

	def_object_events
	object_event 42,  5, SPRITE_GIRL, WALK, LEFT_RIGHT, 1 ; person
	object_event 44,  6, SPRITE_GAMBLER, STAY, NONE, 2 ; person
	object_event 34, 13, SPRITE_COOLTRAINER_M, WALK, ANY_DIR, 3 ; new
	object_event 42, 16, SPRITE_GIRL, WALK, ANY_DIR, 4 ; new
	object_event 38, 24, SPRITE_SWIMMER, WALK, ANY_DIR, 5 ; new
	object_event 16, 14, SPRITE_SWIMMER, STAY, ANY_DIR, 6 ; new

	def_warps_to CINNABAR_ISLAND
