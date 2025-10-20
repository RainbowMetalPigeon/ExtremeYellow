SeviiFourIslandHazardRoom_Object:
	db $2E ; border block

	def_warp_events
	warp_event  8, 23, SEVII_FOUR_ISLAND_HOUSES, 9
	warp_event  9, 23, SEVII_FOUR_ISLAND_HOUSES, 9

	def_bg_events
	bg_event  9,  3,  1 ; SeviiFourIslandHazardRoomSignText1

	def_object_events
;	object_event  2,  6, SPRITE_PINK, STAY, DOWN, 1

	def_warps_to SEVII_FOUR_ISLAND_HAZARD_ROOM
