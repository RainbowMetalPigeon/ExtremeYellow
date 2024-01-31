VictoryRoad3F_Object:
	db $7d ; border block

	def_warp_events
	warp_event 23,  7, VICTORY_ROAD_2F, 4
	warp_event 26,  8, VICTORY_ROAD_2F, 6
	warp_event 27, 15, VICTORY_ROAD_2F, 5
	warp_event  2,  0, VICTORY_ROAD_2F, 7

	def_bg_events

	def_object_events
	object_event 28,  5, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 1, OPP_COOLTRAINER, 15
	object_event  7, 13, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 2, OPP_COOLTRAINER, 2
	object_event  6, 14, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 3, OPP_COOLTRAINER, 16
	object_event 13,  3, SPRITE_COOLTRAINER_F, STAY, ANY_DIR, 4, OPP_COOLTRAINER, 3
	object_event 15,  8, SPRITE_SUPER_NERD, STAY, ANY_DIR, 5, OPP_POKEMANIAC, 9 ; new, weeb
	object_event 17,  0, SPRITE_SUPER_NERD, STAY, ANY_DIR, 6, OPP_JUGGLER, 9 ; new, metronome
	object_event 17, 15, SPRITE_YOUNGSTER, STAY, ANY_DIR, 7, OPP_PSYCHIC_TR, 6 ; new, full psychic team
	object_event 27,  9, SPRITE_YOUNGSTER, STAY, ANY_DIR, 8, OPP_BUG_CATCHER, 17 ; new, bug prodigy
	object_event 26,  5, SPRITE_POKE_BALL, STAY, NONE, 9, MAX_REVIVE
	object_event  7,  7, SPRITE_POKE_BALL, STAY, NONE, 10, TM_EXPLOSION
	object_event 22,  3, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 11 ; person
	object_event 13, 12, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 12 ; person
	object_event 24, 10, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 13 ; person
	object_event 22, 15, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 14 ; person

	def_warps_to VICTORY_ROAD_3F
