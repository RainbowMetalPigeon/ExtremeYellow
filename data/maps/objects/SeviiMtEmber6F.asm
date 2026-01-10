SeviiMtEmber6F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 23,  4, SEVII_MT_EMBER,     14 ;  1
	warp_event 23,  5, SEVII_MT_EMBER,     14 ;  2

	warp_event 15,  5, SEVII_MT_EMBER_5F,   5 ;  3

	warp_event  3,  9, SEVII_MT_EMBER_5F,   7 ;  4

	warp_event  7,  5, SEVII_MT_EMBER_7F,   1 ;  5

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_6F
