SeviiSixIslandDock_Object:
	db $0F ; border block

	def_warp_events
	warp_event 10,  0, SEVII_SIX_ISLAND_CITY, 1

	def_bg_events
	bg_event  9,  0, 2 ; SeviiSixIslandDockBgText1
	bg_event 18,  0, 3 ; SeviiSixIslandDockBgText2
	bg_event 19,  0, 4 ; SeviiSixIslandDockBgText3

	def_object_events
	object_event 10,  4, SPRITE_SAILOR, STAY, UP, 1

	def_warps_to SEVII_SIX_ISLAND_DOCK