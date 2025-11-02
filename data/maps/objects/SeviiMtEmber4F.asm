SeviiMtEmber4F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 31,  2, SEVII_MT_EMBER,     5 ;  1
	warp_event 31,  3, SEVII_MT_EMBER,     5 ;  2
	warp_event 31,  8, SEVII_MT_EMBER,     6 ;  3 ; R1f
	warp_event 31,  9, SEVII_MT_EMBER,     6 ;  4

	warp_event 22, 31, SEVII_MT_EMBER,     7 ;  5
	warp_event 23, 31, SEVII_MT_EMBER,     7 ;  6
	warp_event  4, 31, SEVII_MT_EMBER,     8 ;  7
	warp_event  5, 31, SEVII_MT_EMBER,     8 ;  8

	warp_event  0, 15, SEVII_MT_EMBER,     9 ;  9
	warp_event  0, 14, SEVII_MT_EMBER,     9 ; 10
	warp_event  0,  3, SEVII_MT_EMBER,    10 ; 11
	warp_event  0,  2, SEVII_MT_EMBER,    10 ; 12

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_4F
