SeviiFourIslandParkourPath_Object:
	db $43 ; border block

	def_warp_events
	warp_event 13,   3, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 1
	warp_event 11, 153, SEVII_FOUR_ISLAND_PARKOUR_UNDERGROUND, 7

	def_bg_events
	bg_event  7,  10,  2 ; SeviiFourIslandParkourPathSignText1
	bg_event 11, 149,  3 ; SeviiFourIslandParkourPathSignText2

	def_object_events
	object_event  7,  6, SPRITE_GIRL, STAY, LEFT, 1

	def_warps_to SEVII_FOUR_ISLAND_PARKOUR_PATH
