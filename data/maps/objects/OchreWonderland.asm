OchreWonderland_Object:
	db $3 ; border block

	def_warp_events
	warp_event  2, 59, OCHRE_CITY, 9
	warp_event  3, 59, OCHRE_CITY, 9
	warp_event  3, 55, OCHRE_WONDERLAND, 4
	warp_event 18, 40, OCHRE_WONDERLAND, 3

	def_bg_events
	bg_event  5, 57, 2 ; OchreWonderland_Sign1

	def_object_events
	object_event  9,  4, SPRITE_BLUE, STAY, DOWN, 1

	def_warps_to OCHRE_WONDERLAND
