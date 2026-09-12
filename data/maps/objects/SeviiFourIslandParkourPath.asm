SeviiFourIslandParkourPath_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 10, 37, SEVII_FOUR_ISLAND_DOCK, 1

	def_bg_events
;	bg_event 18, 26, 15 ; SeviiFourIslandCitySignText1

	def_object_events
;	object_event 18, 12, SPRITE_PINK, STAY, UP, 1

	def_warps_to SEVII_FOUR_ISLAND_PARKOUR_PATH
