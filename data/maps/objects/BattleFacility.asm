BattleFacility_Object:
	db $e ; border block

	def_warp_events
	warp_event  6,  9, VERMILION_CITY, 10
	warp_event  7,  9, VERMILION_CITY, 10
	warp_event  6,  0, BATTLE_FACILITY, 4
	warp_event 21,  9, BATTLE_FACILITY, 3

	def_bg_events
;	bg_event  0,  0, nn ; proxy, tabelloni segnapunti
;	bg_event  1,  0, nn ; proxy, tabelloni segnapunti

	def_object_events
	object_event  4,  4, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; battle facility guide, will be 6,  4
	object_event 28,  2, SPRITE_DARK_GUIDE, STAY, DOWN, 2 ; proxy opponent, to be hidden and moved


	def_warps_to BATTLE_FACILITY
