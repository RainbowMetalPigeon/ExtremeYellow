SeviiSevenIslandDock_Object:
	db $0F ; border block

	def_warp_events
	warp_event 10,  0, SEVII_SEVEN_ISLAND_CITY, 1

	def_bg_events
	bg_event  9,  0, 2 ; SeviiSevenIslandDockBgText1
	bg_event 18,  0, 3 ; SeviiSevenIslandDockBgText2
	bg_event 19,  0, 4 ; SeviiSevenIslandDockBgText3

	def_object_events
	object_event 10,  4, SPRITE_SAILOR, STAY, UP, 1

	def_warps_to SEVII_SEVEN_ISLAND_DOCK