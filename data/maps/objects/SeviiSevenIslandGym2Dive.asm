SeviiSevenIslandGym2Dive_Object:
	db $08 ; border block

	def_warp_events
	warp_event 32,  7, SEVII_SEVEN_ISLAND_GYM_2_DIVE_CAVERN, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 28,  8, SPRITE_DIVER, STAY, UP, 1, OPP_DIVER, 4
	object_event 32, 20, SPRITE_DIVER, STAY, RIGHT, 2, OPP_DIVER, 6
	object_event 11, 32, SPRITE_DIVER, STAY, LEFT, 3, OPP_DIVER, 2
	object_event  7,  7, SPRITE_DIVER, STAY, LEFT, 4, OPP_DIVER, 3
	object_event 16, 23, SPRITE_DIVER, STAY, RIGHT, 5, OPP_DIVER, 5
	; items
	object_event 19, 16, SPRITE_POKE_BALL, STAY, NONE, 6, COFFEE
	object_event  4, 33, SPRITE_POKE_BALL, STAY, NONE, 7, BEER
	object_event  9,  8, SPRITE_POKE_BALL, STAY, NONE, 8, FRESH_WATER
	object_event 23, 29, SPRITE_POKE_BALL, STAY, NONE, 9, LEMONADE
	object_event 34, 33, SPRITE_POKE_BALL, STAY, NONE, 10, SODA_POP
	object_event 35, 11, SPRITE_POKE_BALL, STAY, NONE, 11, HYPER_POTION

	def_warps_to SEVII_SEVEN_ISLAND_GYM_2_DIVE
