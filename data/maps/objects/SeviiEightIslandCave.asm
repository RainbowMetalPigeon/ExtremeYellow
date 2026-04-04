SeviiEightIslandCave_Object:
	db $03 ; border block

	def_warp_events
	warp_event  5, 11, SEVII_EIGHT_ISLAND_CITY, 3 ; 1
	warp_event  6, 11, SEVII_EIGHT_ISLAND_CITY, 3 ; 2
	warp_event  7, 11, SEVII_EIGHT_ISLAND_CITY, 3 ; 3

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event  6,  3, SPRITE_SUUJERO, STAY, DOWN, 1 ; person
	object_event  5,  9, SPRITE_BLUE, STAY, DOWN, 2 ; person
	object_event  7,  9, SPRITE_PINK, STAY, DOWN, 3 ; person
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_EIGHT_ISLAND_CAVE
