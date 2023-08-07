OchreWonderland_Object:
	db $3 ; border block

	def_warp_events
	warp_event  2, 59, OCHRE_CITY, 4 ; will be 9
	warp_event  3, 59, OCHRE_CITY, 4 ; will be 9
	warp_event  3, 55, OCHRE_WONDERLAND, 4
	warp_event 18, 40, OCHRE_WONDERLAND, 3

	def_bg_events
	bg_event  5, 57, 1 ; OchreWonderlandText1

	def_object_events

	def_warps_to OCHRE_WONDERLAND
