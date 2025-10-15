SeviiBerryForest_Object:
	db $03 ; border block

	def_warp_events
	warp_event 19, 39, SEVII_ROUTE_33, 1
	warp_event 20, 39, SEVII_ROUTE_33, 1
	warp_event 21, 39, SEVII_ROUTE_33, 1
	warp_event 22, 39, SEVII_ROUTE_33, 1

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
	object_event  6,  6, SPRITE_ORM, STAY, DOWN, 1 ; ORM
	object_event  6,  7, SPRITE_LITTLE_GIRL, STAY, UP, 2 ; Mayoi
	object_event 14, 15, SPRITE_POKE_BALL, STAY, NONE, 3, CARBOS
	object_event 31, 31, SPRITE_POKE_BALL, STAY, NONE, 4, HP_UP
	object_event 13, 30, SPRITE_POKE_BALL, STAY, NONE, 5, REVIVE

	def_warps_to SEVII_BERRY_FOREST
