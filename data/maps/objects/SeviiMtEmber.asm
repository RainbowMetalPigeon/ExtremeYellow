SeviiMtEmber_Object:
	db $43 ; border block

	def_warp_events

; floor 1
	warp_event 24, 51, SEVII_MT_EMBER_1F,  1 ;  1
	warp_event 51, 41, SEVII_MT_EMBER_1F,  3 ;  2
	warp_event 51, 17, SEVII_MT_EMBER_1F,  5 ;  3
	warp_event  8, 29, SEVII_MT_EMBER_1F,  7 ;  4

; floor 2
	warp_event 10, 15, SEVII_MT_EMBER_2F,  1 ;  5

; floor 3

; floor 4
	warp_event 45, 17, SEVII_MT_EMBER_4F,  1 ;  6 ; R1
	warp_event 45, 23, SEVII_MT_EMBER_4F,  3 ;  7
	warp_event 37, 45, SEVII_MT_EMBER_4F,  5 ;  8
	warp_event 19, 45, SEVII_MT_EMBER_4F,  7 ;  9
	warp_event 14, 29, SEVII_MT_EMBER_4F,  9 ; 10
	warp_event 14, 21, SEVII_MT_EMBER_4F, 11 ; 11

; floor 5
	warp_event 22, 43, SEVII_MT_EMBER_5F,  1 ; 12
	warp_event 16, 23, SEVII_MT_EMBER_5F,  1 ; 13

; floor 6
	warp_event 41, 23, SEVII_MT_EMBER_6F,  1 ; 14

; floor 7

; floor 8
	warp_event 37, 25, SEVII_MT_EMBER_8F,  1 ; 15
	warp_event 37, 35, SEVII_MT_EMBER_8F,  3 ; 16

; floor 9
	warp_event 32, 35, SEVII_MT_EMBER_9F,  1 ; 17
	warp_event 24, 29, SEVII_MT_EMBER_9F,  3 ; 18

; floor 10
	warp_event 29, 33, SEVII_MT_EMBER_10F, 1 ; 19

; floor 11
	warp_event 30, 31, SEVII_MT_EMBER_11F, 2 ; 20

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 29, 27, SPRITE_POKE_BALL, STAY, NONE, 1, MEGA_STONE_X
	object_event 30, 27, SPRITE_POKE_BALL, STAY, NONE, 2, MEGA_STONE_Y

	def_warps_to SEVII_MT_EMBER
