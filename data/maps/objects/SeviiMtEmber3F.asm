SeviiMtEmber3F_Object:
	db $03 ; border block

	def_warp_events

	warp_event 23, 13, SEVII_MT_EMBER_2F,   5 ;  1

	warp_event 15, 11, SEVII_MT_EMBER_4F,  13 ;  2

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_3F
