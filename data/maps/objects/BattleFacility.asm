BattleFacility_Object:
	db $e ; border block

	def_warp_events
	warp_event  6,  9, VERMILION_CITY, 10
	warp_event  7,  9, VERMILION_CITY, 10
	warp_event  6,  0, BATTLE_FACILITY, 4
	warp_event 21,  9, BATTLE_FACILITY, 3
	warp_event  6,  5, BATTLE_FACILITY, 5 ; testing, for return after battles

	def_bg_events
;	bg_event  0,  0, nn ; proxy, tabelloni segnapunti
;	bg_event  1,  0, nn ; proxy, tabelloni segnapunti

	def_object_events
	object_event  6,  4, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; battle facility guide, will be 6,  4
	object_event 28,  2, SPRITE_BLUE, STAY, DOWN, 2 ; proxy opponent, to be hidden and moved
	object_event 28,  2, SPRITE_RED, STAY, DOWN, 3 ; proxy opponent, to be hidden and moved
	object_event 28,  2, SPRITE_YELLOW, STAY, DOWN, 4 ; proxy opponent, to be hidden and moved
	object_event 28,  2, SPRITE_GREEN, STAY, DOWN, 5 ; proxy opponent, to be hidden and moved


	def_warps_to BATTLE_FACILITY
