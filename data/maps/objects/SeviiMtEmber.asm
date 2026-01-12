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
	warp_event 10, 33, SEVII_MT_EMBER_2F, 10 ;  6
	warp_event 17, 49, SEVII_MT_EMBER_2F, 12 ;  7
	warp_event 35, 49, SEVII_MT_EMBER_2F, 14 ;  8
	warp_event 49, 35, SEVII_MT_EMBER_2F, 16 ;  9

; floor 3

; floor 4
	warp_event 45, 17, SEVII_MT_EMBER_4F,  1 ; 10
	warp_event 45, 23, SEVII_MT_EMBER_4F,  3 ; 11
	warp_event 37, 45, SEVII_MT_EMBER_4F,  5 ; 12
	warp_event 23, 45, SEVII_MT_EMBER_4F,  7 ; 13
	warp_event 14, 29, SEVII_MT_EMBER_4F,  9 ; 14 
	warp_event 14, 21, SEVII_MT_EMBER_4F, 11 ; 15
	warp_event 45, 39, SEVII_MT_EMBER_4F, 15 ; 16
	warp_event 17, 45, SEVII_MT_EMBER_4F, 18 ; 17

; floor 5
	warp_event 24, 43, SEVII_MT_EMBER_5F,  1 ; 18
	warp_event 16, 23, SEVII_MT_EMBER_5F,  3 ; 19
	warp_event 30, 43, SEVII_MT_EMBER_5F,  9 ; 20
	warp_event 43, 41, SEVII_MT_EMBER_5F, 12 ; 21
	warp_event 16, 35, SEVII_MT_EMBER_5F, 14 ; 22

; floor 6
	warp_event 41, 23, SEVII_MT_EMBER_6F,  1 ; 23
	warp_event 18, 39, SEVII_MT_EMBER_6F,  7 ; 24
	warp_event 18, 33, SEVII_MT_EMBER_6F,  9 ; 25
	warp_event 39, 41, SEVII_MT_EMBER_6F, 13 ; 26

; floor 7

; floor 8
	warp_event 37, 25, SEVII_MT_EMBER_8F,  1 ; 27
	warp_event 37, 33, SEVII_MT_EMBER_8F,  3 ; 28
	warp_event 33, 37, SEVII_MT_EMBER_8F,  6 ; 29
	warp_event 25, 37, SEVII_MT_EMBER_8F,  8 ; 30
	warp_event 22, 25, SEVII_MT_EMBER_8F, 13 ; 31
	warp_event 22, 33, SEVII_MT_EMBER_8F, 15 ; 32

; floor 9
	warp_event 32, 35, SEVII_MT_EMBER_9F,  1 ; 33
	warp_event 24, 29, SEVII_MT_EMBER_9F,  3 ; 34

; floor 10
	warp_event 29, 33, SEVII_MT_EMBER_10F, 1 ; 35

; floor 11
	warp_event 30, 31, SEVII_MT_EMBER_11F, 2 ; 36

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event 29, 27, SPRITE_POKE_BALL, STAY, NONE, 1, MEGA_STONE_X
	object_event 30, 27, SPRITE_POKE_BALL, STAY, NONE, 2, MEGA_STONE_Y

	def_warps_to SEVII_MT_EMBER
