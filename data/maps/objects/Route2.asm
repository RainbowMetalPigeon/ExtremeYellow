Route2_Object:
	db $f ; border block

	def_warp_events
	warp_event 12,  9, DIGLETTS_CAVE_ROUTE_2, 1
	warp_event  3, 11, ROUTE_2_ALL_GATES, 10
	warp_event 15, 19, ROUTE_2_TRADE_HOUSE, 1
	warp_event 16, 35, ROUTE_2_ALL_GATES, 2
	warp_event 15, 39, ROUTE_2_ALL_GATES, 3
	warp_event  3, 43, ROUTE_2_ALL_GATES, 7
	warp_event 17, 35, ROUTE_2_ALL_GATES, 2

	def_bg_events
	bg_event  5, 65, 4 ; Route2Text3
	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to ROUTE_2

	; unused; edited, commented out
;	warp_to 2, 7, 4
;	db $12, $c7, $9, $7
;	warp_to 2, 7, 4
;	warp_to 2, 7, 4
;	warp_to 2, 7, 4
