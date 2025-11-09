SeviiRoute33DiveCavernF1_Object:
	db $20 ; border block

	def_warp_events
	warp_event 10, 19, SEVII_ROUTE_33_DIVE, 1
	warp_event 11, 19, SEVII_ROUTE_33_DIVE, 1
	warp_event  6, 13, SEVII_ROUTE_33_DIVE_CAVERN_F2,  1
	warp_event 10,  7, SEVII_ROUTE_33_DIVE_CAVERN_F2,  6
	warp_event 14, 13, SEVII_ROUTE_33_DIVE_CAVERN_F2, 11 ; R1

	def_bg_events
;	bg_event 15, 35, 1 ; SeviiRoute32Text1
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 21,  5, SPRITE_DIVER, STAY, DOWN, 1, OPP_DIVER, 1
;	object_event  4, 92, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_ROUTE_33_DIVE_CAVERN_F1