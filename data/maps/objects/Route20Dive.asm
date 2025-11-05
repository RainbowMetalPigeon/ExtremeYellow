Route20Dive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event 48,  5, SEAFOAM_ISLANDS_1F, 1

	def_bg_events
;	bg_event 51,  7, 12 ; Route20Text11

	def_object_events
;	object_event 61,  4, SPRITE_MISTY, STAY, ANY_DIR, 1 ; new, TBE
;	object_event 87,  8, SPRITE_SWIMMER, STAY, UP, 2, OPP_SWIMMER, 9;

	def_warps_to ROUTE_20_DIVE
