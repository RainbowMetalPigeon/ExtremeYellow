CeruleanCaveExtraMiddle_Object:
	db $3 ; border block

	def_warp_events
	warp_event  20, 41, REDS_HOUSE_2F, 1	; 1, entrance left
	warp_event  21, 41, REDS_HOUSE_2F, 1	; 2, entrance right
	warp_event   9, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 4	; 3
	warp_event  16, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 3	; 4
	warp_event  25, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 6	; 5
	warp_event  32, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 5	; 6

	warp_event   3, 35, CERULEAN_CAVE_EXTRA_TOP, 1		; 7, stair up
	warp_event   5, 39, CERULEAN_CAVE_EXTRA_BOTTOM, 1	; 8, stair down

	def_bg_events

	def_object_events

	def_warps_to CERULEAN_CAVE_EXTRA_MIDDLE
