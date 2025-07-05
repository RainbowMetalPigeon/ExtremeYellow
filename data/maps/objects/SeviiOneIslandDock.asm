SeviiOneIslandDock_Object:
	db $0A ; border block

	def_warp_events
	warp_event  3,  0, SEVII_ONE_ISLAND_CITY, 1
	warp_event  4,  0, SEVII_ONE_ISLAND_CITY, 2

	def_bg_events
	bg_event  2,  3, 1 ; SeviiOneIslandDockText1
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE
;	object_event 13, 45, SPRITE_POKE_BALL, STAY, NONE, 2, HP_UP
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE ; new

	def_warps_to SEVII_ONE_ISLAND_DOCK