SeviiFiveIslandWarehouse2F_Object:
	db $2e ; border block

	def_warp_events
	warp_event 15,  2, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 5 ; id=1


	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 21, 24, SPRITE_YOUNGSTER, STAY, RIGHT, 1 ; person
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_FIVE_ISLAND_WAREHOUSE_2F
