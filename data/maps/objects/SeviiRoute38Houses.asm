SeviiRoute38Houses_Object:
	db $0A ; border block

	def_warp_events
	warp_event  2,  7, SEVII_ROUTE_38, 1
	warp_event  3,  7, SEVII_ROUTE_38, 1
	warp_event 16,  7, SEVII_ROUTE_38, 2
	warp_event 17,  7, SEVII_ROUTE_38, 2

	def_bg_events
	bg_event  2,  0, 4 ; SeviiRoute38HousesSignText1
	bg_event  3,  0, 5 ; SeviiRoute38HousesSignText2
	bg_event  3,  4, 6 ; SeviiRoute38HousesSignText3

	def_object_events
	object_event  3,  5, SPRITE_GAMBLER, STAY, UP, 1 ; Dive Expert
	object_event 16,  4, SPRITE_COOLTRAINER_M, STAY, RIGHT, 2
	object_event 19,  2, SPRITE_LITTLE_GIRL, WALK, ANY_DIR, 3

	def_warps_to SEVII_ROUTE_38_HOUSES
