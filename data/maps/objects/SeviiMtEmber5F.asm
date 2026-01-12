SeviiMtEmber5F_Object:
	db $03 ; border block

	def_warp_events
	warp_event  8, 27, SEVII_MT_EMBER,     18 ;  1
	warp_event  9, 27, SEVII_MT_EMBER,     18 ;  2

	warp_event  0,  6, SEVII_MT_EMBER,     19 ;  3
	warp_event  0,  7, SEVII_MT_EMBER,     19 ;  4

	warp_event 17,  7, SEVII_MT_EMBER_6F,   3 ;  5

	warp_event  3, 13, SEVII_MT_EMBER_4F,  14 ;  6

	warp_event  5, 11, SEVII_MT_EMBER_6F,   4 ;  7

	warp_event 13, 25, SEVII_MT_EMBER_6F,   6 ;  8

	warp_event 14, 27, SEVII_MT_EMBER,     20 ;  9
	warp_event 15, 27, SEVII_MT_EMBER,     20 ; 10

	warp_event 25, 21, SEVII_MT_EMBER_6F,  12 ; 11

	warp_event 27, 24, SEVII_MT_EMBER,     21 ; 12
	warp_event 27, 25, SEVII_MT_EMBER,     21 ; 13

	warp_event  0, 18, SEVII_MT_EMBER,     22 ; 14
	warp_event  0, 19, SEVII_MT_EMBER,     22 ; 15

	warp_event  2,  2, SEVII_MT_EMBER_6F,  19 ; 16

	warp_event 14,  2, SEVII_MT_EMBER_6F,  20 ; 17

	warp_event 11, 10, SEVII_MT_EMBER_6F,  21 ; 18

	warp_event 20, 12, SEVII_MT_EMBER_6F,  22 ; 19

	warp_event  5, 15, SEVII_MT_EMBER_6F,  23 ; 20

	warp_event 17, 15, SEVII_MT_EMBER_6F,  24 ; 21

	warp_event  1, 11, SEVII_MT_EMBER_4F,  20 ; 22

	warp_event  1, 15, SEVII_MT_EMBER_4F,  21 ; 23

	warp_event 27, 15, SEVII_MT_EMBER_4F,  22 ; 24

	warp_event  4, 26, SEVII_MT_EMBER_4F,  23 ; 25

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_5F
