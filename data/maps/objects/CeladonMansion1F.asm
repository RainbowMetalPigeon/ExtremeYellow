CeladonMansion1F_Object:
	db $f ; border block

	def_warp_events
	warp_event  4, 11, LAST_MAP, 3
	warp_event  5, 11, LAST_MAP, 3
	warp_event  4,  0, LAST_MAP, 5
	warp_event  7,  1, CELADON_MANSION_2F, 2
	warp_event  2,  1, CELADON_MANSION_2F, 3
	; 3F
	warp_event 20,  1, CELADON_MANSION_2F, 1
	warp_event 21,  1, CELADON_MANSION_ROOF, 1
	warp_event 16,  1, CELADON_MANSION_ROOF, 2
	warp_event 18,  1, CELADON_MANSION_2F, 4

	def_bg_events
	bg_event  4,  9, 9 ; CeladonMansion1Text5
	; 3F
	bg_event 15,  3, 10 ; CeladonMansion3Text5
	bg_event 18,  3, 11 ; CeladonMansion3Text6
	bg_event 15,  6, 12 ; CeladonMansion3Text7
	bg_event 18,  9, 13 ; CeladonMansion3Text8

	def_object_events
	object_event  0,  5, SPRITE_MONSTER, STAY, RIGHT, 1 ; person
	object_event  1,  5, SPRITE_GRANNY, STAY, DOWN, 2 ; person
	object_event  1,  8, SPRITE_FAIRY, WALK, LEFT_RIGHT, 3 ; person
	object_event  4,  4, SPRITE_MONSTER, WALK, UP_DOWN, 4 ; person
	; 3F
	object_event 14,  4, SPRITE_BIKE_SHOP_CLERK, STAY, UP, 5 ; person
	object_event 17,  4, SPRITE_CLERK, STAY, UP, 6 ; person
	object_event 14,  7, SPRITE_SUPER_NERD, STAY, UP, 7 ; person
	object_event 16,  3, SPRITE_SILPH_WORKER, STAY, NONE, 8 ; person

	def_warps_to CELADON_MANSION_1F
