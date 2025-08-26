SeviiTanobyChambers_Object:
	db $03 ; border block

	def_warp_events
	warp_event  2, 13, SEVII_ROUTE_44, 1
	warp_event  3, 13, SEVII_ROUTE_44, 1
	
	warp_event 14, 13, SEVII_ROUTE_44, 2
	warp_event 15, 13, SEVII_ROUTE_44, 2
	
	warp_event 26, 13, SEVII_ROUTE_44, 3
	warp_event 27, 13, SEVII_ROUTE_44, 3
	
	warp_event 38, 13, SEVII_ROUTE_44, 4
	warp_event 39, 13, SEVII_ROUTE_44, 4
	
	warp_event 50, 13, SEVII_ROUTE_44, 5
	warp_event 51, 13, SEVII_ROUTE_44, 5
	
	warp_event 62, 13, SEVII_ROUTE_44, 6
	warp_event 63, 13, SEVII_ROUTE_44, 6
	
	warp_event 78, 13, SEVII_ROUTE_44, 7
	warp_event 79, 13, SEVII_ROUTE_44, 7

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 21, 24, SPRITE_YOUNGSTER, STAY, RIGHT, 1 ; person
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_TANOBY_CHAMBERS
