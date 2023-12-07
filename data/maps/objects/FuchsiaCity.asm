FuchsiaCity_Object:
	db $f ; border block

	def_warp_events
	warp_event  5, 13, FUCHSIA_MART, 1
	warp_event 11, 27, FUCHSIA_BILLS_GRANDPAS_HOUSE, 1
	warp_event 19, 27, FUCHSIA_POKECENTER, 1
	warp_event 27, 27, WARDENS_HOUSE, 1
	warp_event 18,  3, SAFARI_ZONE_GATE, 1
	warp_event  5, 27, FUCHSIA_GYM, 1
	warp_event 22, 13, FUCHSIA_MEETING_ROOM, 1
	warp_event 31, 27, FUCHSIA_GOOD_ROD_HOUSE, 2
	warp_event 31, 24, FUCHSIA_GOOD_ROD_HOUSE, 1

	def_bg_events
	bg_event 25, 15, 15 ; FuchsiaCityText12
	bg_event 17,  5, 16 ; FuchsiaCityText13
	bg_event  6, 13, 17 ; MartSignText
	bg_event 20, 27, 18 ; PokeCenterSignText
	bg_event 27, 29, 19 ; FuchsiaCityText16
	bg_event 21, 15, 20 ; FuchsiaCityText17
	bg_event  5, 29, 21 ; FuchsiaCityText18
	bg_event 33,  7, 22 ; FuchsiaCityText19
	bg_event 27,  7, 23 ; FuchsiaCityText20
	bg_event 13,  7, 24 ; FuchsiaCityText21
	bg_event 31, 13, 25 ; FuchsiaCityText22
	bg_event 13, 15, 26 ; FuchsiaCityText23
	bg_event  7,  7, 27 ; FuchsiaCityText24

	def_object_events
	object_event 10, 12, SPRITE_FISHER, WALK, LEFT_RIGHT, 1 ; edited, it was SPRITE_YOUNGSTER
	object_event 28, 17, SPRITE_GAMBLER, WALK, LEFT_RIGHT, 2 ; person
	object_event 30, 14, SPRITE_FISHER, STAY, DOWN, 3 ; Erik waiting for Sara
	object_event 24,  8, SPRITE_GAMBLER, STAY, UP, 4 ; edited, it was SPRITE_YOUNGSTER
	object_event 31,  5, SPRITE_MONSTER, STAY, DOWN, 5 ; zoo mon ; edited sprite
	object_event 25,  6, SPRITE_POKE_BALL, STAY, NONE, 6 ; zoo mon
	object_event 12,  6, SPRITE_MONSTER, WALK, LEFT_RIGHT, 7 ; zoo mon
	object_event 30, 12, SPRITE_MONSTER, WALK, LEFT_RIGHT, 8 ; zoo mon
	object_event  8, 17, SPRITE_FOSSIL, WALK, ANY_DIR, 9 ; zoo mon ; edited sprite
	object_event  6,  5, SPRITE_FOSSIL, STAY, NONE, 10 ; zoo mon
	object_event 18,  4, SPRITE_ROCKET, STAY, DOWN, 11 ; new
	object_event 30, 14, SPRITE_FISHER, STAY, LEFT, 12 ; new, Erik happy
	object_event 29, 14, SPRITE_GIRL, STAY, RIGHT, 13 ; new, Sara happy
	object_event 21, 19, SPRITE_TRAVELER, STAY, ANY_DIR, 14 ; new, traveler

	def_warps_to FUCHSIA_CITY
