OchreCity_Object:
	db $f ; border block

	def_warp_events
	warp_event  9,  9, REDS_HOUSE_1F, 1 ; 1, to edit - house 1
	warp_event 17,  9, REDS_HOUSE_1F, 1 ; 2, to edit - house 2
	warp_event 27, 11, REDS_HOUSE_1F, 1 ; 3, to edit - poke mart
	warp_event 35, 11, REDS_HOUSE_1F, 1 ; 4, to edit - poke center
	warp_event 17, 15, REDS_HOUSE_1F, 1 ; 5, to edit - bird fan club
	warp_event 34, 17, OCHRE_GYM, 1 ; 6
	warp_event 10, 19, OCHRE_RESEARCH_CENTER, 1 ; 7
	warp_event 37, 27, REDS_HOUSE_1F, 1 ; 8, to edit - front entrance sanctuary house
	warp_event 12, 33, OCHRE_WONDERLAND, 1 ; 9
;	todo: back entrance to the sanctuary house! - 37, 25; maybe also 36, 25? see cerulean badge house

	def_bg_events
	bg_event 28, 11, 1 ; MartSignText
	bg_event 36, 11, 2 ; PokeCenterSignText
	bg_event 39, 21, 3 ; OchreCityText1, city sign

	def_object_events

	def_warps_to OCHRE_CITY
