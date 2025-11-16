BluesHouse_Object:
	db $a ; border block

	def_warp_events
	warp_event  2,  7, PALLET_TOWN, 2
	warp_event  3,  7, PALLET_TOWN, 2
	warp_event  7,  1, BLUES_HOUSE, 4 ; new
	warp_event 21,  1, BLUES_HOUSE, 3 ; new

	def_bg_events ; new
	bg_event 18,  0,  8 ; BluesHouseSignText1
	bg_event 14,  1,  9 ; BluesHouseSignText2
	bg_event 14,  6, 10 ; BluesHouseSignText3
	bg_event 21,  7, 11 ; BluesHouseSignText4

	def_object_events
	object_event  2,  3, SPRITE_DAISY, STAY, RIGHT, 1
	object_event  6,  4, SPRITE_DAISY, WALK, UP_DOWN, 2
	object_event  3,  3, SPRITE_POKEDEX, STAY, NONE, 3
	object_event  3,  2, SPRITE_BLUE, STAY, DOWN, 4 ; new
	object_event  5,  3, SPRITE_BLUES_DAD, STAY, LEFT, 5 ; new
	object_event  5,  4, SPRITE_BLUES_MOM, STAY, LEFT, 6 ; new
	object_event  2,  4, SPRITE_OAK, STAY, RIGHT, 7 ; new

	def_warps_to BLUES_HOUSE
