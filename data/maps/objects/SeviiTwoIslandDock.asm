SeviiTwoIslandDock_Object:
	db $0F ; border block

	def_warp_events
	warp_event 10,  0, SEVII_TWO_ISLAND_CITY, 1

	def_bg_events
	bg_event  9,  0, 2 ; SeviiTwoIslandDockBgText1
	bg_event 18,  0, 3 ; SeviiTwoIslandDockBgText2
	bg_event 19,  0, 4 ; SeviiTwoIslandDockBgText3

	def_object_events
	object_event 10,  4, SPRITE_SAILOR, STAY, UP, 1

	def_warps_to SEVII_TWO_ISLAND_DOCK
