SeviiTanobyChambers_Object:
	db $03 ; border block

	def_warp_events
	warp_event  2, 15, SEVII_ROUTE_44, 1
	warp_event  3, 15, SEVII_ROUTE_44, 1
	
	warp_event 14, 15, SEVII_ROUTE_44, 2
	warp_event 15, 15, SEVII_ROUTE_44, 2
	
	warp_event 26, 15, SEVII_ROUTE_44, 3
	warp_event 27, 15, SEVII_ROUTE_44, 3
	
	warp_event 38, 15, SEVII_ROUTE_44, 4
	warp_event 39, 15, SEVII_ROUTE_44, 4
	
	warp_event 50, 15, SEVII_ROUTE_44, 5
	warp_event 51, 15, SEVII_ROUTE_44, 5
	
	warp_event 62, 15, SEVII_ROUTE_44, 6
	warp_event 63, 15, SEVII_ROUTE_44, 6
	
	warp_event 78, 15, SEVII_ROUTE_44, 7
	warp_event 79, 15, SEVII_ROUTE_44, 7
	warp_event 78,  6, SEVII_TANOBY_GARDEN, 1

	def_bg_events
	bg_event  2, 10, 4 ; SeviiTanobyChambersSignText1
	bg_event 14, 10, 5 ; SeviiTanobyChambersSignText2
	bg_event 26, 10, 6 ; SeviiTanobyChambersSignText3
	bg_event 38, 10, 7 ; SeviiTanobyChambersSignText4
	bg_event 50, 10, 8 ; SeviiTanobyChambersSignText5
	bg_event 62, 10, 9 ; SeviiTanobyChambersSignText6

	def_object_events
	object_event 77, 13, SPRITE_ORM, STAY, UP, 1
	object_event 78, 13, SPRITE_CARR, STAY, UP, 2
	object_event 79, 13, SPRITE_SIRD, STAY, UP, 3

	def_warps_to SEVII_TANOBY_CHAMBERS
