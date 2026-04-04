SeviiTenIsland_Object:
	db $43 ; border block

	def_warp_events
	warp_event 40, 17, SEVII_UNDERGROUND_LOBBY, 10

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 20, 20, SPRITE_OAK, STAY, DOWN, 1

	def_warps_to SEVII_TEN_ISLAND