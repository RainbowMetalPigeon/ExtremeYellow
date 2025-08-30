SeviiRoute32DiveCavern1F1_Object:
	db $20 ; border block

	def_warp_events
	warp_event  8, 19, SEVII_ROUTE_32_DIVE, 1
	warp_event  9, 19, SEVII_ROUTE_32_DIVE, 1

	def_bg_events
;	bg_event 15, 35, 1 ; SeviiRoute32Text1
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 21,  5, SPRITE_DIVER, STAY, DOWN, 1, OPP_DIVER, 1
;	object_event  4, 92, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_ROUTE_32_DIVE_CAVERN_1_F1