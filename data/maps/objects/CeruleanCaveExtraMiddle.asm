CeruleanCaveExtraMiddle_Object:
	db $3 ; border block

	def_warp_events
	; room 1-1
	warp_event   5,  3, CERULEAN_CAVE_EXTRA_TOP, 1		; 1, stairs up
	; room 2-1
	warp_event  20,  0, CERULEAN_CAVE_EXTRA_FINAL, 1	; 2, exit, testing
	warp_event  21,  0, CERULEAN_CAVE_EXTRA_FINAL, 2	; 3, exit, testing
	warp_event  19,  7, CERULEAN_CAVE_EXTRA_BOTTOM, 1	; 4, stairs down
	; room 3-1
	warp_event  35,  3, CERULEAN_CAVE_EXTRA_BOTTOM, 4	; 5, stairs down
	warp_event  39,  7, CERULEAN_CAVE_EXTRA_TOP, 12		; 6, stairs up
	; room 1-2
	warp_event   1, 17, CERULEAN_CAVE_EXTRA_BOTTOM, 7	; 7, stairs down
	; room 2-2
	warp_event  20, 25, CERULEAN_CAVE_EXTRA_MIDDLE, 17	; 8, room 2-3, north
	warp_event  21, 25, CERULEAN_CAVE_EXTRA_MIDDLE, 18	; 9, room 2-3, north
	; room 3-2
	warp_event  35, 19, CERULEAN_CAVE_EXTRA_TOP, 21		; 10, stairs up
	warp_event  36, 25, CERULEAN_CAVE_EXTRA_MIDDLE, 25	; 11, room 3-3, north
	warp_event  37, 25, CERULEAN_CAVE_EXTRA_MIDDLE, 26	; 12, room 3-3, north
	; room 1-3
	warp_event   3, 35, CERULEAN_CAVE_EXTRA_TOP, 26		; 13, stairs up
	warp_event   9, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 19	; 14, room 2-3, west
	warp_event   9, 37, CERULEAN_CAVE_EXTRA_MIDDLE, 20	; 15, room 2-3, west
	warp_event   5, 39, CERULEAN_CAVE_EXTRA_BOTTOM, 20	; 16, stairs down
	; room 2-3
	warp_event  20, 32, CERULEAN_CAVE_EXTRA_MIDDLE, 8	; 17, room 2-2, south
	warp_event  21, 32, CERULEAN_CAVE_EXTRA_MIDDLE, 9	; 18, room 2-2, south
	warp_event  16, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 14	; 19, room 1-3, east
	warp_event  16, 37, CERULEAN_CAVE_EXTRA_MIDDLE, 15	; 20, room 1-3, east
	warp_event  25, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 27	; 21, room 3-3, west
	warp_event  25, 37, CERULEAN_CAVE_EXTRA_MIDDLE, 28	; 22, room 3-3, west
	warp_event  20, 41, CERULEAN_CAVE_1F, 10			; 23, entrance, testing
	warp_event  21, 41, CERULEAN_CAVE_1F, 11			; 24, entrance, testing
	; room 3-3
	warp_event  36, 32, CERULEAN_CAVE_EXTRA_MIDDLE, 11	; 25, room 3-2, south
	warp_event  37, 32, CERULEAN_CAVE_EXTRA_MIDDLE, 12	; 26, room 3-2, south
	warp_event  32, 36, CERULEAN_CAVE_EXTRA_MIDDLE, 21	; 27, room 2-3, east
	warp_event  32, 37, CERULEAN_CAVE_EXTRA_MIDDLE, 23	; 28, room 2-3, east

	def_bg_events

	def_object_events

	def_warps_to CERULEAN_CAVE_EXTRA_MIDDLE
