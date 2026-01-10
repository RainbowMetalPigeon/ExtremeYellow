SeviiMtEmber1BF_Object:
	db $03 ; border block

	def_warp_events

	warp_event 15, 23, SEVII_MT_EMBER_1F,  10 ;  1

	warp_event 47,  0, SEVII_MT_EMBER_2BF,  1 ;  2

	warp_event 27, 47, SEVII_MT_EMBER_2BF,  4 ;  3

	warp_event 37, 36, SEVII_MT_EMBER_1F,  11 ;  4

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_1BF
