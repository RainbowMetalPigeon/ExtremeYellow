SafariZoneExtra_Object:
	db $0 ; border block

	def_warp_events
	warp_event 18, 35, SAFARI_ZONE_NORTH, 10
	warp_event 19, 35, SAFARI_ZONE_NORTH, 11

	def_bg_events
	bg_event 23, 31, 5 ; SafariZoneExtraText1
	bg_event 19, 15, 6 ; SafariZoneExtraText2

	def_object_events
	object_event 36, 32, SPRITE_POKE_BALL, STAY, NONE, 1, BIG_NUGGET
	object_event  9, 10, SPRITE_POKE_BALL, STAY, NONE, 2, RARE_CANDY
	object_event  2,  2, SPRITE_POKE_BALL, STAY, NONE, 3, PP_UP
	object_event 25,  1, SPRITE_POKE_BALL, STAY, NONE, 4, MAX_ELIXER

	def_warps_to SAFARI_ZONE_EXTRA
