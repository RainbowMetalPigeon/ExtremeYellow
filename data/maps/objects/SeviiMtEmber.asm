SeviiMtEmber_Object:
	db $43 ; border block

	def_warp_events
	warp_event 24, 51, SEVII_MT_EMBER_1F,  1 ;  1
	warp_event 51, 41, SEVII_MT_EMBER_1F,  3 ;  2
	warp_event 51, 17, SEVII_MT_EMBER_1F,  5 ;  3
	warp_event  8, 29, SEVII_MT_EMBER_1F,  7 ;  4

	warp_event 45, 17, SEVII_MT_EMBER_4F,  1 ;  5
	warp_event 45, 23, SEVII_MT_EMBER_4F,  3 ;  6 ; R1
	warp_event 37, 45, SEVII_MT_EMBER_4F,  5 ;  7
	warp_event 19, 45, SEVII_MT_EMBER_4F,  7 ;  8
	warp_event 14, 29, SEVII_MT_EMBER_4F,  9 ;  9
	warp_event 14, 17, SEVII_MT_EMBER_4F, 11 ; 10

	warp_event 32, 35, SEVII_MT_EMBER_9F,  1 ; 11

	warp_event 29, 33, SEVII_MT_EMBER_10F, 1 ; 12

	warp_event 30, 31, SEVII_MT_EMBER_11F, 2 ; 13

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 29, 27, SPRITE_POKE_BALL, STAY, NONE, 1, MEGA_STONE_X
	object_event 30, 27, SPRITE_POKE_BALL, STAY, NONE, 2, MEGA_STONE_Y
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE
;	object_event  4, 92, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1

	def_warps_to SEVII_MT_EMBER