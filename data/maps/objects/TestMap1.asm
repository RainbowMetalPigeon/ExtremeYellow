TestMap1_Object:
	db $3 ; border block

	def_warp_events
	warp_event  20, 41, REDS_HOUSE_2F, 1	; 1, entrance left
	warp_event  21, 41, REDS_HOUSE_2F, 1	; 2, entrance right
	warp_event   0, 36, REDS_HOUSE_2F, 1	; 3
	warp_event   9, 36, REDS_HOUSE_2F, 1	; 4
	warp_event  16, 36, REDS_HOUSE_2F, 1	; 5
	warp_event  25, 36, TEST_MAP_1, 7		; 6
	warp_event  32, 36, TEST_MAP_1, 6		; 7
	warp_event  41, 36, REDS_HOUSE_2F, 1	; 8

	def_bg_events

	def_object_events

	def_warps_to TEST_MAP_1
