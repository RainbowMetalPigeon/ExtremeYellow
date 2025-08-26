SeviiLostCave3_Object:
	db $03 ; border block

	def_warp_events
; secret room 1
	warp_event  0,  4, SEVII_LOST_CAVE_1, 10 ; id= 1
	warp_event  0,  5, SEVII_LOST_CAVE_1,  9 ; id= 2
; secret room 2
	warp_event 20,  9, SEVII_LOST_CAVE_1, 20 ; id= 3
	warp_event 21,  9, SEVII_LOST_CAVE_1, 19 ; id= 4
; secret room 3
	warp_event 41,  5, SEVII_LOST_CAVE_2,  6 ; id= 5
	warp_event 41,  4, SEVII_LOST_CAVE_2,  5 ; id= 6
; secret room 4
	warp_event 53,  0, SEVII_LOST_CAVE_2, 24 ; id= 7
	warp_event 52,  0, SEVII_LOST_CAVE_2, 23 ; id= 8

	def_bg_events

	def_object_events
	object_event  6,  4, SPRITE_POKE_BALL, STAY, NONE, 1, RARE_CANDY
	object_event 20,  4, SPRITE_POKE_BALL, STAY, NONE, 2, NUGGET
	object_event 36,  4, SPRITE_POKE_BALL, STAY, NONE, 3, MAX_ELIXER
	object_event 52,  5, SPRITE_POKE_BALL, STAY, NONE, 4, PP_UP

	def_warps_to SEVII_LOST_CAVE_3
