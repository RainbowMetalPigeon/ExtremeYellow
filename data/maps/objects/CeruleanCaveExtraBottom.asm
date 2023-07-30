CeruleanCaveExtraBottom_Object:
	db $3 ; border block

	def_warp_events
	warp_event   5, 39, CERULEAN_CAVE_EXTRA_MIDDLE, 8	; 1
	warp_event   9, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 3	; 2
	warp_event  16, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 2	; 3
	warp_event  25, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 5	; 4
	warp_event  32, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 6	; 5

	def_bg_events

	def_object_events

	def_warps_to CERULEAN_CAVE_EXTRA_BOTTOM
