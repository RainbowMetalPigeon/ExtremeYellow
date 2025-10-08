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

	def_object_events
	object_event 41, 14, SPRITE_SWIMMER, STAY, ANY_DIR, 1

	def_warps_to SEVII_ROUTE_44