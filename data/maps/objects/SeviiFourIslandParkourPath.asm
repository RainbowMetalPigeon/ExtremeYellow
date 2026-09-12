SeviiFourIslandParkourPath_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 10, 37, SEVII_FOUR_ISLAND_DOCK, 1

	def_bg_events
	bg_event  7, 10,  2 ; SeviiFourIslandParkourPathSignText1
	bg_event  7, 39,  3 ; SeviiFourIslandParkourPathSignText2

	def_object_events
	object_event  7,  6, SPRITE_GIRL, STAY, LEFT, 1

	def_warps_to SEVII_FOUR_ISLAND_PARKOUR_PATH
