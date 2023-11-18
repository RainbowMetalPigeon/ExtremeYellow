CeruleanCaveExtraBottom_Object:
	db $3 ; border block

	def_warp_events
	; room 1-1
	; room 2-1
	warp_event  19,  7, CERULEAN_CAVE_EXTRA_MIDDLE, 4	; 1, stairs up
	warp_event  20,  9, CERULEAN_CAVE_EXTRA_BOTTOM, 10	; 2, room 2-2, north
	warp_event  21,  9, CERULEAN_CAVE_EXTRA_BOTTOM, 11	; 3, room 2-2, north
	; room 3-1
	warp_event  35,  3, CERULEAN_CAVE_EXTRA_MIDDLE, 5	; 4, stairs up
	warp_event  36,  9, CERULEAN_CAVE_EXTRA_BOTTOM, 16	; 5, room 3-2, north
	warp_event  37,  9, CERULEAN_CAVE_EXTRA_BOTTOM, 17	; 6, room 3-2, north
	; room 1-2
	warp_event   1, 17, CERULEAN_CAVE_EXTRA_MIDDLE, 7	; 7, stairs up
	warp_event   9, 20, CERULEAN_CAVE_EXTRA_BOTTOM, 12	; 8, room 2-2, west
	warp_event   9, 21, CERULEAN_CAVE_EXTRA_BOTTOM, 13	; 9, room 2-2, west
	; room 2-2
	warp_event  20, 16, CERULEAN_CAVE_EXTRA_BOTTOM, 2	; 10, room 2-1, south
	warp_event  21, 16, CERULEAN_CAVE_EXTRA_BOTTOM, 3	; 11, room 2-1, south
	warp_event  16, 20, CERULEAN_CAVE_EXTRA_BOTTOM, 8	; 12, room 1-2, east
	warp_event  16, 21, CERULEAN_CAVE_EXTRA_BOTTOM, 9	; 13, room 1-2, east
	warp_event  25, 20, CERULEAN_CAVE_EXTRA_BOTTOM, 18	; 14, room 3-2, west
	warp_event  25, 21, CERULEAN_CAVE_EXTRA_BOTTOM, 19	; 15, room 3-2, west
	; room 3-2
	warp_event  36, 16, CERULEAN_CAVE_EXTRA_BOTTOM, 5	; 16, room 3-1, south
	warp_event  37, 16, CERULEAN_CAVE_EXTRA_BOTTOM, 6	; 17, room 3-1, south
	warp_event  32, 20, CERULEAN_CAVE_EXTRA_BOTTOM, 14	; 18, room 2-2, east
	warp_event  32, 21, CERULEAN_CAVE_EXTRA_BOTTOM, 15	; 19, room 2-2, east
	; room 1-3
	warp_event   5, 39, CERULEAN_CAVE_EXTRA_MIDDLE, 16	; 20, stairs up
	warp_event   9, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 23	; 21, room 2-3, west
	warp_event   9, 37, CERULEAN_CAVE_EXTRA_BOTTOM, 24	; 22, room 2-3, west
	; room 2-3
	warp_event  16, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 21	; 23, room 1-3, east
	warp_event  16, 37, CERULEAN_CAVE_EXTRA_BOTTOM, 22	; 24, room 1-3, east
	warp_event  25, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 27	; 25, room 3-3, west
	warp_event  25, 37, CERULEAN_CAVE_EXTRA_BOTTOM, 28	; 26, room 3-3, west
	; room 3-3
	warp_event  32, 36, CERULEAN_CAVE_EXTRA_BOTTOM, 25	; 27, room 2-3, east
	warp_event  32, 37, CERULEAN_CAVE_EXTRA_BOTTOM, 26	; 28, room 2-3, east


	def_bg_events

	def_object_events
	object_event  0,  0, SPRITE_POKE_BALL, STAY, NONE, 1, ESCAPE_ROPE

	def_warps_to CERULEAN_CAVE_EXTRA_BOTTOM
