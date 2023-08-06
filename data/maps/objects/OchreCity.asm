OchreCity_Object:
	db $f ; border block

	def_warp_events
	warp_event  9,  9, REDS_HOUSE_1F, 1
	warp_event 35, 11, REDS_HOUSE_1F, 1

	def_bg_events
	bg_event 28, 11, 1 ; MartSignText
	bg_event 36, 11, 2 ; PokeCenterSignText
	bg_event 39, 21, 3 ; OchreCityText1, city sign

	def_object_events

	def_warps_to OCHRE_CITY
