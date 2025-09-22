SeviiSevenIslandGym2DiveCavern_Object:
	db $09 ; border block

	def_warp_events
	warp_event 12, 25, SEVII_SEVEN_ISLAND_GYM_2_DIVE, 1
	warp_event 13, 25, SEVII_SEVEN_ISLAND_GYM_2_DIVE, 1

	def_bg_events

	def_object_events
	object_event 15, 15, SPRITE_POKE_BALL, STAY, NONE, 6, MAX_REVIVE

	def_warps_to SEVII_SEVEN_ISLAND_GYM_2_DIVE_CAVERN
