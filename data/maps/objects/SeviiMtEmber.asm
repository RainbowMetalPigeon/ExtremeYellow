SeviiMtEmber_Object:
	db $43 ; border block

	def_warp_events
;	warp_event 28, 33, SEVII_ONE_ISLAND_DOCK, 1
;	warp_event 29, 33, SEVII_ONE_ISLAND_DOCK, 2

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3
;	bg_event 11, 11, 5 ; Route2Text4

	def_object_events
	object_event 29, 27, SPRITE_POKE_BALL, STAY, NONE, 1, MEGA_STONE_X
	object_event 30, 27, SPRITE_POKE_BALL, STAY, NONE, 2, MEGA_STONE_Y
;	object_event 19, 68, SPRITE_POKE_BALL, STAY, NONE, 3, LINK_CABLE
;	object_event  4, 92, SPRITE_ROCKSMASHABLE_ROCK, STAY, NONE, 1

	def_warps_to SEVII_MT_EMBER