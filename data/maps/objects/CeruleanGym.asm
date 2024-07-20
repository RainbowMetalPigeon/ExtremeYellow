CeruleanGym_Object:
	db $3 ; border block

	def_warp_events
	warp_event  4, 13, LAST_MAP, 4
	warp_event  5, 13, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  4,  2, SPRITE_MISTY, STAY, DOWN, 1, OPP_MISTY, 1 ; edited
	object_event  2,  3, SPRITE_COOLTRAINER_F, STAY, RIGHT, 2, OPP_JR_TRAINER, 1
	object_event  8,  7, SPRITE_SWIMMER, STAY, LEFT, 3, OPP_SWIMMER, 1
	object_event  5,  2, SPRITE_COOLTRAINER_F, STAY, DOWN, 4, OPP_COOLTRAINER, 9 ; new
	object_event  7, 10, SPRITE_GYM_GUIDE, STAY, DOWN, 5 ; person

	def_warps_to CERULEAN_GYM
