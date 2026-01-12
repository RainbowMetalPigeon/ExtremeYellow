SeviiMtEmber6F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 23,  4, SEVII_MT_EMBER,     23 ;  1
	warp_event 23,  5, SEVII_MT_EMBER,     23 ;  2

	warp_event 15,  5, SEVII_MT_EMBER_5F,   5 ;  3

	warp_event  3,  9, SEVII_MT_EMBER_5F,   7 ;  4

	warp_event  7,  5, SEVII_MT_EMBER_7F,   1 ;  5

	warp_event 11, 23, SEVII_MT_EMBER_5F,   8 ;  6

	warp_event  0, 20, SEVII_MT_EMBER,     24 ;  7
	warp_event  0, 21, SEVII_MT_EMBER,     24 ;  8

	warp_event  0, 16, SEVII_MT_EMBER,     25 ;  9
	warp_event  0, 17, SEVII_MT_EMBER,     25 ; 10

	warp_event  8, 12, SEVII_MT_EMBER_7F,   4 ; 11

	warp_event 23, 19, SEVII_MT_EMBER_5F,  11 ; 12

	warp_event 18, 23, SEVII_MT_EMBER,     26 ; 13
	warp_event 19, 23, SEVII_MT_EMBER,     26 ; 14

	warp_event  8,  9, SEVII_MT_EMBER_7F,   9 ; 15

	warp_event  2, 21, SEVII_MT_EMBER_7F,  10 ; 16

	warp_event 19, 21, SEVII_MT_EMBER_7F,  11 ; 17

	warp_event 12, 14, SEVII_MT_EMBER_7F,  12 ; 18

	warp_event  0,  0, SEVII_MT_EMBER_5F,  16 ; 19

	warp_event 12,  0, SEVII_MT_EMBER_5F,  17 ; 20

	warp_event  9,  8, SEVII_MT_EMBER_5F,  18 ; 21

	warp_event 18, 10, SEVII_MT_EMBER_5F,  19 ; 22

	warp_event  3, 13, SEVII_MT_EMBER_5F,  20 ; 23

	warp_event 15, 13, SEVII_MT_EMBER_5F,  21 ; 24

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_6F
