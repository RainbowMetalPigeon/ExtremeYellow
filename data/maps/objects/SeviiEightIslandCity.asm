SeviiEightIslandCity_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 12, 25, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1

	def_warps_to SEVII_EIGHT_ISLAND_CITY