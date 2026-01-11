SeviiMtEmber4BF_Object:
	db $03 ; border block

	def_warp_events

	warp_event 29, 28, SEVII_MT_EMBER_3BF,  4 ;  1

	warp_event 25, 21, SEVII_MT_EMBER_3BF,  5 ;  2

	warp_event 34, 45, SEVII_MT_EMBER_3BF,  8 ;  3

	warp_event 57, 31, SEVII_MT_EMBER_3BF,  9 ;  4

	warp_event 44, 46, SEVII_MT_EMBER_3BF, 12 ;  5

	warp_event 44, 28, SEVII_MT_EMBER_3BF, 13 ;  6

	def_bg_events

	def_object_events
	object_event 45, 29, SPRITE_POKE_BALL, STAY, NONE, 1, FLAME_PLUME

	def_warps_to SEVII_MT_EMBER_4BF
