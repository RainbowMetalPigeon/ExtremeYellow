SeviiLostCave2_Object:
	db $03 ; border block

	def_warp_events
; room 1 (5)
	warp_event  9,  5, SEVII_LOST_CAVE_2, 14 ; id= 1
	warp_event  9,  4, SEVII_LOST_CAVE_2, 13 ; id= 2
	warp_event  5,  0, SEVII_LOST_CAVE_1,  7 ; id= 3
	warp_event  4,  0, SEVII_LOST_CAVE_1,  7 ; id= 4
	warp_event  0,  4, SEVII_LOST_CAVE_3,  6 ; id= 5 ; secret room 3
	warp_event  0,  5, SEVII_LOST_CAVE_3,  5 ; id= 6 ; secret room 3
	warp_event  4,  9, SEVII_LOST_CAVE_1,  7 ; id= 7
	warp_event  5,  9, SEVII_LOST_CAVE_1,  7 ; id= 8
; room 2 (6)
	warp_event 25,  5, SEVII_LOST_CAVE_1,  7 ; id= 9
	warp_event 25,  4, SEVII_LOST_CAVE_1,  7 ; id=10
	warp_event 21,  0, SEVII_LOST_CAVE_1,  7 ; id=11
	warp_event 20,  0, SEVII_LOST_CAVE_1,  7 ; id=12
	warp_event 16,  4, SEVII_LOST_CAVE_1,  7 ; id=13
	warp_event 16,  5, SEVII_LOST_CAVE_1,  7 ; id=14
	warp_event 20,  9, SEVII_LOST_CAVE_2, 20 ; id=15
	warp_event 21,  9, SEVII_LOST_CAVE_2, 19 ; id=16
; room 3 (7)
	warp_event 41,  5, SEVII_LOST_CAVE_1,  7 ; id=17
	warp_event 41,  4, SEVII_LOST_CAVE_1,  7 ; id=18
	warp_event 37,  0, SEVII_LOST_CAVE_2, 26 ; id=19
	warp_event 36,  0, SEVII_LOST_CAVE_2, 25 ; id=20
	warp_event 32,  4, SEVII_LOST_CAVE_1,  7 ; id=21
	warp_event 32,  5, SEVII_LOST_CAVE_1,  7 ; id=22
	warp_event 36,  9, SEVII_LOST_CAVE_3,  8 ; id=23 ; secret room 4
	warp_event 37,  9, SEVII_LOST_CAVE_3,  7 ; id=24 ; secret room 4
; room 4 (final)
	warp_event 52,  9, SEVII_LOST_CAVE_1,  7 ; id=25
	warp_event 53,  9, SEVII_LOST_CAVE_1,  7 ; id=26

	def_bg_events

	def_object_events
	object_event 52,  4, SPRITE_BEAUTY, STAY, UP, 1 ; Selphy

	def_warps_to SEVII_LOST_CAVE_2
