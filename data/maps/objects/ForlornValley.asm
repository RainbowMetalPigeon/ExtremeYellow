ForlornValley_Object:
	db $2c ; border block

	def_warp_events
;	warp_event  6,  7, VERMILION_CITY, 10

	def_bg_events
;	bg_event  1,  0,  9

	def_object_events
	object_event  2, 55, SPRITE_POKE_BALL, STAY, NONE, 1 ; give fly coordinates

	def_warps_to FORLORN_VALLEY
