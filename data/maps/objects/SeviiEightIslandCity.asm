SeviiEightIslandCity_Object:
	db $43 ; border block

	def_warp_events
	warp_event 12, 37, SEVII_EIGHT_ISLAND_DOCK, 1
	warp_event 13, 37, SEVII_EIGHT_ISLAND_DOCK, 1
	warp_event 12, 11, SEVII_EIGHT_ISLAND_CAVE, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 12, 27, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1

	def_warps_to SEVII_EIGHT_ISLAND_CITY