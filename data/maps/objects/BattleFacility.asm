BattleFacility_Object:
	db $e ; border block

	def_warp_events
	warp_event  6,  7, VERMILION_CITY, 10
	warp_event  7,  7, VERMILION_CITY, 10
	warp_event  6,  0, BATTLE_FACILITY, 4
	warp_event 21,  7, BATTLE_FACILITY, 3
	warp_event  6,  4, BATTLE_FACILITY, 5 ; testing, for return after battles

	def_bg_events
	bg_event  1,  0,  9 ; proxy, tabelloni segnapunti
	bg_event  2,  0, 10 ; proxy, tabelloni segnapunti

	def_object_events
	object_event  6,  3, SPRITE_GYM_GUIDE, STAY, DOWN, 1 ; battle facility guide
	object_event 28,  0, SPRITE_BLUE, STAY, DOWN, 2 ; proxy opponent, to be hidden and moved
	object_event 28,  0, SPRITE_RED, STAY, DOWN, 3 ; proxy opponent, to be hidden and moved
	object_event 28,  0, SPRITE_YELLOW, STAY, DOWN, 4 ; proxy opponent, to be hidden and moved
	object_event 28,  0, SPRITE_GREEN, STAY, DOWN, 5 ; proxy opponent, to be hidden and moved
	object_event 10,  5, SPRITE_COOLTRAINER_F, WALK, LEFT_RIGHT, 6 ; person
	object_event  1,  2, SPRITE_COOLTRAINER_M, STAY, UP, 7 ; person
	object_event 12,  3, SPRITE_ERIKA, WALK, UP_DOWN, 8 ; person
;	object_event 21,  3, SPRITE_GYM_GUIDE, STAY, RIGHT, 9 ; battle facility guide, arena

	def_warps_to BATTLE_FACILITY
