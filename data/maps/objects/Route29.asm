Route29_Object:
	db $43 ; border block

	def_warp_events

	def_bg_events
;	bg_event  9, 51, 11 ; Route17Text11

	def_object_events
	object_event 17,  9, SPRITE_COOLTRAINER_F, STAY, DOWN, 1, OPP_COOLTRAINER, 1 ; testing, TBE
	object_event 15, 58, SPRITE_SLOWKING, STAY, DOWN, 2

	def_warps_to ROUTE_29
