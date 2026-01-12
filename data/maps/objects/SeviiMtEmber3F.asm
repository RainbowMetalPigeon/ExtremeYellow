SeviiMtEmber3F_Object:
	db $03 ; border block

	def_warp_events

	warp_event 23, 13, SEVII_MT_EMBER_2F,   5 ;  1

	warp_event 15, 11, SEVII_MT_EMBER_4F,  13 ;  2

	warp_event 33, 33, SEVII_MT_EMBER_4F,  17 ;  3

	warp_event 32, 22, SEVII_MT_EMBER_2F,   6 ;  4

	warp_event 25, 23, SEVII_MT_EMBER_2F,   7 ;  5

	warp_event 20, 26, SEVII_MT_EMBER_2F,   8 ;  6

	warp_event  7,  9, SEVII_MT_EMBER_4F,  24 ;  7

	warp_event 25,  9, SEVII_MT_EMBER_4F,  25 ;  8

	warp_event 18, 11, SEVII_MT_EMBER_4F,  26 ;  9

	warp_event  7, 12, SEVII_MT_EMBER_4F,  27 ; 10

	warp_event 26, 12, SEVII_MT_EMBER_4F,  28 ; 11

	warp_event 15, 19, SEVII_MT_EMBER_4F,  29 ; 12

	warp_event 26, 21, SEVII_MT_EMBER_4F,  30 ; 13

	warp_event 29, 25, SEVII_MT_EMBER_4F,  31 ; 14

	warp_event  9, 28, SEVII_MT_EMBER_4F,  32 ; 15

	warp_event 17, 28, SEVII_MT_EMBER_4F,  33 ; 16

	warp_event  4, 31, SEVII_MT_EMBER_4F,  34 ; 17

	warp_event 28,  2, SEVII_MT_EMBER_2F,  18 ; 18

	warp_event 17,  5, SEVII_MT_EMBER_2F,  19 ; 19

	warp_event 35,  7, SEVII_MT_EMBER_2F,  20 ; 20

	warp_event 21, 18, SEVII_MT_EMBER_2F,  21 ; 21

	warp_event  3, 19, SEVII_MT_EMBER_2F,  22 ; 22

	warp_event 28, 33, SEVII_MT_EMBER_2F,  23 ; 23

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_3F
