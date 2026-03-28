LakeOfMist_Object:
	db $2c ; border block

	def_warp_events

	def_bg_events
	bg_event 11, 31, 12 ; LakeOfMistSignText1

	def_object_events
	object_event 29, 25, SPRITE_GIRL, STAY, UP,  1 ; special NPC for Forlorn Coordinates
	; trainers
	object_event 42, 39, SPRITE_SCIENTIST, STAY, DOWN,  2, OPP_SCIENTIST, 17 ; SCIENTIST
	object_event 34,  7, SPRITE_FISHER, STAY, DOWN,  3, OPP_FISHER, 13 ; FISHER
	object_event 40, 18, SPRITE_BIKER, STAY, UP,  4, OPP_BIKER, 17 ; BIKER
	object_event 19, 16, SPRITE_COOLTRAINER_F, STAY, LEFT,  5, OPP_COOLTRAINER, 102 ; COOLTRAINER
	object_event 15,  4, SPRITE_CHANNELER, STAY, DOWN,  6, OPP_CHANNELER, 26 ; CHANNELER
	; NPCs
	object_event 25, 42, SPRITE_LITTLE_GIRL, WALK, LEFT_RIGHT,  7
	object_event 43, 27, SPRITE_COOLTRAINER_M, STAY, RIGHT,  8
	object_event 10, 33, SPRITE_COOLTRAINER_F, WALK, ANY_DIR,  9
	; items
	object_event  3, 23, SPRITE_POKE_BALL, STAY, NONE, 10, SMASH_BALL
	object_event  4, 17, SPRITE_ROCKSMASHABLE_ROCK, STAY, ROCKSMASHABLE_ROCK_MOVEMENT_BYTE_2, 11

	def_warps_to LAKE_OF_MIST
