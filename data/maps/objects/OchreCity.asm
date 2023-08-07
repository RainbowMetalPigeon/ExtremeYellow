OchreCity_Object:
	db $f ; border block

	def_warp_events
	warp_event  9,  9, REDS_HOUSE_1F, 1 ; 1, to edit
;	todo ; 2
;	todo ; 3
	warp_event 35, 11, REDS_HOUSE_1F, 1 ; 4, to edit
;	todo ; 5
	warp_event 34, 17, OCHRE_GYM, 1 ; 6
;	todo ; 7
;	todo ; 8
	warp_event 12, 33, OCHRE_WONDERLAND, 1 ; 9

	def_bg_events
	bg_event 28, 11, 1 ; MartSignText
	bg_event 36, 11, 2 ; PokeCenterSignText
	bg_event 39, 21, 3 ; OchreCityText1, city sign

	def_object_events

	def_warps_to OCHRE_CITY
