SecludedCaves_Object:
	db $52 ; border block

	def_warp_events
	warp_event  6, 31, SECLUDED_ATOLL_SE, 1
	warp_event  7, 31, SECLUDED_ATOLL_SE, 1
	warp_event  6, 28, ONIX_BURROWING, 7
	warp_event 18, 21, SECLUDED_ATOLL_SW, 1
	warp_event 19, 21, SECLUDED_ATOLL_SW, 1

	def_bg_events

	def_object_events
	object_event  4, 16, SPRITE_MONSTER, STAY, DOWN, 1, MZYGARDE, 99 | OW_POKEMON ; edited, to go beyond 200
	object_event 33, 14, SPRITE_MONSTER, STAY, DOWN, 2, UNECROZMA, 99 | OW_POKEMON ; edited, to go beyond 200
	object_event  4,  4, SPRITE_MONSTER, STAY, DOWN, 3, MRAYQUAZA, 99 | OW_POKEMON ; edited, to go beyond 200
	object_event 32,  4, SPRITE_MONSTER, STAY, DOWN, 4, EETERNATUS, 99 | OW_POKEMON ; edited, to go beyond 200
	object_event 18,  4, SPRITE_MONSTER, STAY, DOWN, 5, ARCEUS, 99 | OW_POKEMON ; edited, to go beyond 200

	def_warps_to SECLUDED_CAVES
