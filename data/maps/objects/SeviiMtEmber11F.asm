SeviiMtEmber11F_Object:
	db $03 ; border block

	def_warp_events

	warp_event  0,  0, SEVII_MT_EMBER_10F,  5 ;  1

	warp_event  2,  3, SEVII_MT_EMBER,     36 ;  2
	warp_event  3,  3, SEVII_MT_EMBER,     36 ;  3

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_11F
