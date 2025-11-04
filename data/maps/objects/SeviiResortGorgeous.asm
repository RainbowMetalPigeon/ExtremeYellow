SeviiResortGorgeous_Object:
	db $0A ; border block

	def_warp_events
	warp_event  4, 11, SEVII_ROUTE_35, 1
	warp_event  5, 11, SEVII_ROUTE_35, 1

	def_bg_events
	bg_event  0,  1,  4 ; SeviiResortGorgeousText3
	bg_event  4,  0,  5 ; SeviiResortGorgeousText4
	bg_event  6,  1,  6 ; SeviiResortGorgeousText5
	bg_event  9,  0,  7 ; SeviiResortGorgeousText6
	bg_event  3,  5,  8 ; SeviiResortGorgeousText7
	bg_event  4,  5,  9 ; SeviiResortGorgeousText8
	bg_event  9,  5, 10 ; SeviiResortGorgeousText9
	bg_event  0, 11, 11 ; SeviiResortGorgeousText10
	bg_event  9,  9, 12 ; SeviiResortGorgeousText11
	bg_event 11,  1, 13 ; SeviiResortGorgeousText12
	bg_event 11, 10, 14 ; SeviiResortGorgeousText13
	bg_event 11, 11, 15 ; SeviiResortGorgeousText14

	def_object_events
	object_event  8,  5, SPRITE_BEAUTY, STAY, RIGHT, 1 ; Selphy
	object_event  6,  7, SPRITE_GYM_GUIDE, WALK, ANY_DIR, 2 ; Butler
	object_event  8,  1, SPRITE_PAPER, STAY, NONE, 3

	def_warps_to SEVII_RESORT_GORGEOUS
