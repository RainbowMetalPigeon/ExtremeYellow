SeviiTanobyDen_Object:
	db $03 ; border block

	def_warp_events
	warp_event  4,  9, SEVII_TANOBY_GARDEN, 3
	warp_event  5,  9, SEVII_TANOBY_GARDEN, 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event  2,  1, SPRITE_MEWTWO, STAY, DOWN, 1, ARM_MEWTWO, 100 | OW_POKEMON ; edited, to go beyond 200
	object_event  7,  1, SPRITE_MEW, STAY, DOWN, 2, MEW, 100 | OW_POKEMON ; edited, to go beyond 200

	def_warps_to SEVII_TANOBY_DEN
