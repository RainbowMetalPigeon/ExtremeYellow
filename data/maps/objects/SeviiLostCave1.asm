SeviiLostCave1_Object:
	db $03 ; border block

	def_warp_events
; room 1
	warp_event  9,  5, SEVII_LOST_CAVE_1,  7 ; id= 1
	warp_event  9,  4, SEVII_LOST_CAVE_1,  7 ; id= 2
	warp_event  5,  0, SEVII_LOST_CAVE_1,  7 ; id= 3
	warp_event  4,  0, SEVII_LOST_CAVE_1,  7 ; id= 4
	warp_event  0,  4, SEVII_LOST_CAVE_1, 10 ; id= 5
	warp_event  0,  5, SEVII_LOST_CAVE_1,  9 ; id= 6
	warp_event  4,  9, SEVII_ROUTE_35, 2     ; id= 7
	warp_event  5,  9, SEVII_ROUTE_35, 2     ; id= 8
; room 2
	warp_event 25,  5, SEVII_LOST_CAVE_3,  2 ; id= 9 ; secret room 1
	warp_event 25,  4, SEVII_LOST_CAVE_3,  1 ; id=10 ; secret room 1
	warp_event 21,  0, SEVII_LOST_CAVE_1,  7 ; id=11
	warp_event 20,  0, SEVII_LOST_CAVE_1,  7 ; id=12
	warp_event 16,  4, SEVII_LOST_CAVE_1, 18 ; id=13
	warp_event 16,  5, SEVII_LOST_CAVE_1, 17 ; id=14
	warp_event 20,  9, SEVII_LOST_CAVE_1,  7 ; id=15
	warp_event 21,  9, SEVII_LOST_CAVE_1,  7 ; id=16
; room 3
	warp_event 41,  5, SEVII_LOST_CAVE_1,  7 ; id=17
	warp_event 41,  4, SEVII_LOST_CAVE_1,  7 ; id=18
	warp_event 37,  0, SEVII_LOST_CAVE_3,  4 ; id=19 ; secret room 2
	warp_event 36,  0, SEVII_LOST_CAVE_3,  3 ; id=20 ; secret room 2
	warp_event 32,  4, SEVII_LOST_CAVE_1,  7 ; id=21
	warp_event 32,  5, SEVII_LOST_CAVE_1,  7 ; id=22
	warp_event 36,  9, SEVII_LOST_CAVE_1, 28 ; id=23
	warp_event 37,  9, SEVII_LOST_CAVE_1, 27 ; id=24
; room 4
	warp_event 57,  5, SEVII_LOST_CAVE_1,  7 ; id=25
	warp_event 57,  4, SEVII_LOST_CAVE_1,  7 ; id=26
	warp_event 53,  0, SEVII_LOST_CAVE_2,  8 ; id=27
	warp_event 52,  0, SEVII_LOST_CAVE_2,  7 ; id=28
	warp_event 48,  4, SEVII_LOST_CAVE_1,  7 ; id=29
	warp_event 48,  5, SEVII_LOST_CAVE_1,  7 ; id=30
	warp_event 52,  9, SEVII_LOST_CAVE_1,  7 ; id=31
	warp_event 53,  9, SEVII_LOST_CAVE_1,  7 ; id=32

	def_bg_events

	def_object_events

	def_warps_to SEVII_LOST_CAVE_1
