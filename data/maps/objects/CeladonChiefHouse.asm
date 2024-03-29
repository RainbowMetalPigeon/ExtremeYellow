CeladonChiefHouse_Object:
	db $f ; border block

	def_warp_events
	; old warps, edited, +6 on the y coordinate
	warp_event  2,  13, LAST_MAP, 11 ; edited coz removed useless CELADON warp
	warp_event  3,  13, LAST_MAP, 11 ; edited coz removed useless CELADON warp
	; new warps, LUNAR_SHRINE
	warp_event 20,  13, CELADON_CITY, 15
	warp_event 21,  13, CELADON_CITY, 15

	def_bg_events
	bg_event 20,  1, 13 ; empty shrine

	def_object_events ; edited, +6 on the y coordinate
	object_event  4,  8, SPRITE_GRAMPS, STAY, DOWN, 1 ; person
	object_event  1, 10, SPRITE_ROCKET, WALK, ANY_DIR, 2 ; person
	object_event  5, 12, SPRITE_SAILOR, STAY, LEFT, 3 ; person
	; LUNAR_SHRINE
	object_event 21,  2, SPRITE_CHANNELER, STAY, UP, 4 ; new, monk
	object_event 18,  7, SPRITE_ROCKET, STAY, UP, 5 ; new
	object_event 23,  7, SPRITE_ROCKET, STAY, UP, 6 ; new
	object_event 20,  7, SPRITE_ROCKET, STAY, UP, 7 ; new
	object_event 21,  7, SPRITE_ROCKET, STAY, UP, 8 ; new
	; tourists, initally hidden
	object_event 18,  3, SPRITE_BRUNETTE_GIRL, STAY, UP, 9 ; new
	object_event 19,  5, SPRITE_COOLTRAINER_F, WALK, ANY_DIR, 10 ; new
	object_event 25,  4, SPRITE_FISHER, WALK, ANY_DIR, 11 ; new
	object_event 19, 10, SPRITE_GIRL, STAY, ANY_DIR, 12 ; new

	def_warps_to CELADON_CHIEF_HOUSE
