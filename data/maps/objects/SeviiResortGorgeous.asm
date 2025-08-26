SeviiResortGorgeous_Object:
	db $0A ; border block

	def_warp_events
	warp_event  4, 11, SEVII_ROUTE_35, 1
	warp_event  5, 11, SEVII_ROUTE_35, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  8,  5, SPRITE_BEAUTY, STAY, RIGHT, 1 ; Selphy
	object_event  6,  7, SPRITE_GYM_GUIDE, WALK, ANY_DIR, 2 ; Butler

	def_warps_to SEVII_RESORT_GORGEOUS
