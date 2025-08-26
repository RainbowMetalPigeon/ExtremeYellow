SeviiRoute44_Object:
	db $43 ; border block

	def_warp_events
	warp_event 10, 11, SEVII_TANOBY_CHAMBERS, 1
	warp_event 12, 23, SEVII_TANOBY_CHAMBERS, 3
	warp_event 24, 15, SEVII_TANOBY_CHAMBERS, 5
	warp_event 34, 21, SEVII_TANOBY_CHAMBERS, 7
	warp_event 56, 15, SEVII_TANOBY_CHAMBERS, 9
	warp_event 68, 21, SEVII_TANOBY_CHAMBERS, 11
	warp_event 84, 13, SEVII_TANOBY_CHAMBERS, 13

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_ROUTE_44