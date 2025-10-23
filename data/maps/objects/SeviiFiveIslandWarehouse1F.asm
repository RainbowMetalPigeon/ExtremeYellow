SeviiFiveIslandWarehouse1F_Object:
	db $2e ; border block

	def_warp_events
	warp_event 22, 21, SEVII_FIVE_ISLAND_CITY, 7
	warp_event 23, 21, SEVII_FIVE_ISLAND_CITY, 7
	warp_event 28, 18, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  4 ; id=3
	warp_event 18,  6, SEVII_FIVE_ISLAND_WAREHOUSE_1F,  3 ; id=4
	warp_event 15,  2, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  1 ; id=5
	warp_event 23,  2, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  1 ; id=6
	warp_event  3, 18, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  3 ; id=7
	warp_event 17, 18, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  7 ; id=8
	warp_event 19, 18, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  4 ; id=9
	warp_event 31,  6, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  5 ; id=10
	warp_event 29, 12, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  6 ; id=11
	warp_event 31, 12, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  5 ; id=12
	warp_event 10,  2, SEVII_FIVE_ISLAND_WAREHOUSE_BF,  2 ; id=13
	warp_event 28,  2, SEVII_FIVE_ISLAND_WAREHOUSE_2F,  6 ; id=14

	def_bg_events
;	bg_event  5, 65, 4 ; Route2Text3

	def_object_events
;	object_event 21, 24, SPRITE_YOUNGSTER, STAY, RIGHT, 1 ; person
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_FIVE_ISLAND_WAREHOUSE_1F
