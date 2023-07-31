CeruleanCaveExtraTop_Object:
	db $3 ; border block

	def_warp_events
	; room 1-1
	warp_event   5,  3, CERULEAN_CAVE_EXTRA_MIDDLE, 1	; 1, stairs down
	warp_event   9,  4, CERULEAN_CAVE_EXTRA_TOP, 6		; 2, room 2-1, west
	warp_event   9,  5, CERULEAN_CAVE_EXTRA_TOP, 7		; 3, room 2-1, west
	warp_event   4,  9, CERULEAN_CAVE_EXTRA_TOP, 13 	; 4, room 1-2, north
	warp_event   5,  9, CERULEAN_CAVE_EXTRA_TOP, 14 	; 5, room 1-2, north
	; room 2-1
	warp_event  16,  4, CERULEAN_CAVE_EXTRA_TOP, 2		; 6, room 1-1, east
	warp_event  16,  5, CERULEAN_CAVE_EXTRA_TOP, 3		; 7, room 1-1, east
	warp_event  25,  4, CERULEAN_CAVE_EXTRA_TOP, 10 	; 8, room 3-1, west
	warp_event  25,  5, CERULEAN_CAVE_EXTRA_TOP, 11 	; 9, room 3-1, west
	; room 3-1
	warp_event  32,  4, CERULEAN_CAVE_EXTRA_TOP, 8		; 10, room 2-1, east
	warp_event  32,  5, CERULEAN_CAVE_EXTRA_TOP, 9		; 11, room 2-1, east
	warp_event  39,  7, CERULEAN_CAVE_EXTRA_MIDDLE, 6	; 12, stairs down
	; room 1-2
	warp_event   4, 16, CERULEAN_CAVE_EXTRA_TOP, 4		; 13, room 1-1, south
	warp_event   5, 16, CERULEAN_CAVE_EXTRA_TOP, 5		; 14, room 1-1, south
	warp_event   9, 20, CERULEAN_CAVE_EXTRA_TOP, 17 	; 15, room 2-2, west
	warp_event   9, 21, CERULEAN_CAVE_EXTRA_TOP, 18 	; 16, room 2-2, west
	; room 2-2
	warp_event  16, 20, CERULEAN_CAVE_EXTRA_TOP, 15		; 17, room 1-2, east
	warp_event  16, 21, CERULEAN_CAVE_EXTRA_TOP, 16		; 18, room 1-2, east
	warp_event  25, 20, CERULEAN_CAVE_EXTRA_TOP, 22 	; 19, room 3-2, west
	warp_event  25, 21, CERULEAN_CAVE_EXTRA_TOP, 23 	; 20, room 3-2, west
	; room 3-2
	warp_event  35, 19, CERULEAN_CAVE_EXTRA_MIDDLE, 10	; 21, stairs down
	warp_event  32, 20, CERULEAN_CAVE_EXTRA_TOP, 19		; 22, room 2-2, west
	warp_event  32, 21, CERULEAN_CAVE_EXTRA_TOP, 20		; 23, room 2-2, west
	warp_event  36, 25, CERULEAN_CAVE_EXTRA_TOP, 29 	; 24, room 3-3, north
	warp_event  37, 25, CERULEAN_CAVE_EXTRA_TOP, 30 	; 25, room 3-3, north
	; room 1-3
	warp_event   3, 35, CERULEAN_CAVE_EXTRA_TOP, 13		; 26, stairs down
	; room 2-3
	warp_event  25, 36, CERULEAN_CAVE_EXTRA_TOP, 31 	; 27, room 3-3, west
	warp_event  25, 37, CERULEAN_CAVE_EXTRA_TOP, 32 	; 28, room 3-3, west
	; room 3-3
	warp_event  36, 32, CERULEAN_CAVE_EXTRA_TOP, 24 	; 29, room 3-2, south
	warp_event  37, 32, CERULEAN_CAVE_EXTRA_TOP, 25 	; 30, room 3-2, south
	warp_event  32, 36, CERULEAN_CAVE_EXTRA_TOP, 27 	; 31, room 2-3, east
	warp_event  32, 37, CERULEAN_CAVE_EXTRA_TOP, 28 	; 32, room 2-3, east


	def_bg_events

	def_object_events

	def_warps_to CERULEAN_CAVE_EXTRA_TOP
