Route20Dive_Object:
	db $08 ; border block

	def_warp_events
;	warp_event 48,  5, SEAFOAM_ISLANDS_1F, 1

	def_bg_events
;	bg_event 51,  7, 12 ; Route20Text11

	def_object_events
;	object_event 61,  4, SPRITE_MISTY, STAY, ANY_DIR, 1 ; new, TBE
	object_event 43, 12, SPRITE_DIVER, STAY, UP, 1, OPP_DIVER,  8
	object_event 74,  8, SPRITE_DIVER, STAY, UP, 2, OPP_DIVER,  9
	object_event 24,  9, SPRITE_DIVER, STAY, RIGHT, 3, OPP_DIVER, 10

	def_warps_to ROUTE_20_DIVE
