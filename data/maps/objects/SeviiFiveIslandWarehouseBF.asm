SeviiFiveIslandWarehouseBF_Object:
	db $2e ; border block

	def_warp_events
	warp_event 23,  2, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  6 ; id=1
	warp_event  2,  2, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 13 ; id=2
	warp_event 10,  6, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  4 ; id=3
	warp_event 26,  2, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  3 ; id=4
	warp_event 31,  6, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 10 ; id=5
	warp_event 29, 12, SEVII_FIVE_ISLAND_WAREHOUSE_1F, 11 ; id=6
	warp_event 17, 18, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  8 ; id=7
	warp_event 30, 18, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  2 ; id=8

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 21, 24, SPRITE_YOUNGSTER, STAY, RIGHT, 1 ; person
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_FIVE_ISLAND_WAREHOUSE_BF
