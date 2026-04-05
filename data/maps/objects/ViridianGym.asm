ViridianGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event 16, 17, LAST_MAP, 5
	warp_event 17, 17, LAST_MAP, 5

	def_bg_events

	def_object_events
	object_event  2,  1, SPRITE_GIOVANNI, STAY, DOWN, 1, OPP_GIOVANNI, 4 ; edited, it was 3, but now we'll have Obsidian Island
	object_event 11, 11, SPRITE_HIKER, STAY, UP, 2, OPP_BLACKBELT, 6
	object_event 10,  7, SPRITE_ROCKER, STAY, DOWN, 3, OPP_TAMER, 3
	object_event  3,  7, SPRITE_HIKER, STAY, LEFT, 4, OPP_BLACKBELT, 7
	object_event 13,  5, SPRITE_COOLTRAINER_F, STAY, RIGHT, 5, OPP_COOLTRAINER, 62 ; edited
	object_event 10,  1, SPRITE_HIKER, STAY, DOWN, 6, OPP_BLACKBELT, 8
	object_event  2, 16, SPRITE_ROCKER, STAY, RIGHT, 7, OPP_TAMER, 4
	object_event  6,  5, SPRITE_COOLTRAINER_F, STAY, DOWN, 8, OPP_COOLTRAINER, 60 ; edited
	object_event  1,  4, SPRITE_COOLTRAINER_F, STAY, RIGHT, 9, OPP_COOLTRAINER, 59 ; new

	object_event 16, 15, SPRITE_GYM_GUIDE, STAY, DOWN, 10 ; person
	object_event 16,  9, SPRITE_POKE_BALL, STAY, NONE, 11, REVIVE
	object_event  1,  1, SPRITE_POKE_BALL, STAY, NONE, 12, TM_FISSURE ; new

	def_warps_to VIRIDIAN_GYM
