SeviiResortGorgeous_Object:
	db $0A ; border block

	def_warp_events
	warp_event  4, 11, SEVII_ROUTE_35, 1
	warp_event  5, 11, SEVII_ROUTE_35, 1

	def_bg_events
	bg_event  0,  1,  3 ; SeviiResortGorgeousText3
	bg_event  4,  0,  4 ; SeviiResortGorgeousText4
	bg_event  6,  1,  5 ; SeviiResortGorgeousText5
	bg_event  9,  0,  6 ; SeviiResortGorgeousText6
	bg_event  3,  5,  7 ; SeviiResortGorgeousText7
	bg_event  4,  5,  8 ; SeviiResortGorgeousText8
	bg_event  9,  5,  9 ; SeviiResortGorgeousText9
	bg_event  0, 11, 10 ; SeviiResortGorgeousText10
	bg_event  9,  9, 11 ; SeviiResortGorgeousText11

	def_object_events
	object_event  8,  5, SPRITE_BEAUTY, STAY, RIGHT, 1 ; Selphy
	object_event  6,  7, SPRITE_GYM_GUIDE, WALK, ANY_DIR, 2 ; Butler

	def_warps_to SEVII_RESORT_GORGEOUS
