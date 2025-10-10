SeviiOneIslandDock_Object:
	db $0F ; border block

	def_warp_events
	warp_event 10,  0, SEVII_ONE_ISLAND_CITY, 1
;	warp_event 10,  0, SEVII_TANOBY_CHAMBERS, 1
;	warp_event 10,  0, SEVII_PATTERN_BUSH, 1
;	warp_event 10,  0, SEVII_SEVEN_ISLAND_HOUSES, 4
;	warp_event 10,  0, SEVII_ROUTE_43_CAVES, 1
;	warp_event 10,  0, SEVII_ROUTE_43, 4

	def_bg_events
	bg_event  9,  0, 2 ; SeviiOneIslandDockBgText1
	bg_event 18,  0, 3 ; SeviiOneIslandDockBgText2
	bg_event 19,  0, 4 ; SeviiOneIslandDockBgText3

	def_object_events
	object_event 10,  4, SPRITE_SAILOR, STAY, UP, 1

	def_warps_to SEVII_ONE_ISLAND_DOCK