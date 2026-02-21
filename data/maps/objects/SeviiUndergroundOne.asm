SeviiUndergroundOne_Object:
	db $03 ; border block

	def_warp_events
	warp_event  3,  7, SEVII_ROUTE_32, 1
	warp_event 70,  4, SEVII_UNDERGROUND_LOBBY, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 25,  5, SPRITE_POKE_BALL, STAY, NONE, 1, NUGGET

	def_warps_to SEVII_UNDERGROUND_ONE
