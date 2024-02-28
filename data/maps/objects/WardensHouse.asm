WardensHouse_Object:
	db $17 ; border block

	def_warp_events
	warp_event  4,  7, LAST_MAP, 4
	warp_event  5,  7, LAST_MAP, 4
	; new, ANTIQUITIES shop
	warp_event 20,  7, LAST_MAP, 10
	warp_event 21,  7, LAST_MAP, 10

	def_bg_events
	bg_event  4,  3, 8 ; FuchsiaHouse2Text4
	bg_event  5,  3, 9 ; FuchsiaHouse2Text5
	; new, ANTIQUITIES shop
	bg_event 16,  1, 10 ; FuchsiaHouse2AntiquitiesSign1
	bg_event 17,  1, 11 ; FuchsiaHouse2AntiquitiesSign2
	bg_event 18,  1, 12 ; FuchsiaHouse2AntiquitiesSign3
	bg_event 19,  1, 13 ; FuchsiaHouse2AntiquitiesSign4
	bg_event 22,  1, 14 ; FuchsiaHouse2AntiquitiesSign5
	bg_event 23,  1, 15 ; FuchsiaHouse2AntiquitiesSign6
	bg_event 24,  1, 16 ; FuchsiaHouse2AntiquitiesSign7
	bg_event 25,  1, 17 ; FuchsiaHouse2AntiquitiesSign8

	def_object_events
	object_event  2,  3, SPRITE_WARDEN, STAY, NONE, 1 ; person
	object_event 20,  3, SPRITE_GRAMPS, STAY, DOWN, 2 ; new, antiquities seller
	object_event 16,  5, SPRITE_AMBER_2, STAY, DOWN, 3 ; new, antique stuff
	object_event 25,  5, SPRITE_AMBER_2, STAY, DOWN, 4 ; new, antique stuff
	object_event 17,  5, SPRITE_FOSSIL, STAY, NONE, 5 ; new, antique stuff
	object_event 24,  5, SPRITE_FOSSIL, STAY, NONE, 6 ; new, antique stuff
	object_event 21,  0, SPRITE_PAPER, STAY, NONE, 7 ; new, piece of map
;	object_event  8,  3, SPRITE_POKE_BALL, STAY, NONE, 8, RARE_CANDY
;	object_event  8,  4, SPRITE_BOULDER, STAY, BOULDER_MOVEMENT_BYTE_2, 9

	def_warps_to WARDENS_HOUSE
