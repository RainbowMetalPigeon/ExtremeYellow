SecludedAtollSW_Object:
	db $43 ; border block

	def_warp_events
	warp_event 42, 13, SECLUDED_CAVES, 4

	def_bg_events

	def_object_events
	object_event 42, 18, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 1

	def_warps_to SECLUDED_ATOLL_SW