SeviiRoute31_Object:
	db $43 ; border block

	def_warp_events
	warp_event 20, 17, SEVII_EMBER_SPA, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  4, 92, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_ROUTE_31