FightingDojo_Object:
	db $3 ; border block

	def_warp_events
	warp_event  6, 15, LAST_MAP, 2
	warp_event  7, 15, LAST_MAP, 2

	def_bg_events

	def_object_events
	object_event 10,  2, SPRITE_BRUNO, STAY, ANY_DIR, 1 ; new
	object_event  7,  4, SPRITE_HIKER, STAY, DOWN, 2, OPP_BLACKBELT, 1 ; it was in XY 5,  3

	object_event  5,  8, SPRITE_HIKER, STAY, RIGHT, 3, OPP_BLACKBELT, 2
	object_event  5, 10, SPRITE_HIKER, STAY, RIGHT, 4, OPP_BLACKBELT, 3
	object_event  8,  8, SPRITE_HIKER, STAY, LEFT, 5, OPP_BLACKBELT, 4
	object_event  8, 10, SPRITE_HIKER, STAY, LEFT, 6, OPP_BLACKBELT, 5

	object_event  5,  1, SPRITE_POKE_BALL, STAY, NONE, 7 ; person
	object_event  6,  1, SPRITE_POKE_BALL, STAY, NONE, 8 ; person
	object_event  7,  1, SPRITE_POKE_BALL, STAY, NONE, 9 ; person, new, for HITMONTOP

	def_warps_to FIGHTING_DOJO
