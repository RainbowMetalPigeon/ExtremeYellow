PewterHouses_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, LAST_MAP, 6
	warp_event  3,  7, LAST_MAP, 6
	warp_event 16,  7, LAST_MAP, 8
	warp_event 17,  7, LAST_MAP, 8
	warp_event 30,  7, LAST_MAP, 4
	warp_event 31,  7, LAST_MAP, 4

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_GAMBLER, STAY, RIGHT, 1 ; person
	object_event  4,  5, SPRITE_YOUNGSTER, STAY, NONE, 2 ; person
	; new
	object_event 19,  3, SPRITE_CHANNELER, STAY, LEFT, 3
	object_event 17,  3, SPRITE_CLIPBOARD, STAY, NONE, 4
	; Nidoran house
	object_event 32,  5, SPRITE_MONSTER, STAY, LEFT, 5 ; person
	object_event 31,  5, SPRITE_LITTLE_BOY, STAY, RIGHT, 6 ; person
	object_event 29,  2, SPRITE_MIDDLE_AGED_MAN, STAY, NONE, 7 ; person

	def_warps_to PEWTER_HOUSES
