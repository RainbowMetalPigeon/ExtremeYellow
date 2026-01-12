SeviiMtEmber4BF_Object:
	db $03 ; border block

	def_warp_events

	warp_event 29, 28, SEVII_MT_EMBER_3BF,  4 ;  1

	warp_event 25, 21, SEVII_MT_EMBER_3BF,  5 ;  2

	warp_event 34, 45, SEVII_MT_EMBER_3BF,  8 ;  3

	warp_event 57, 31, SEVII_MT_EMBER_3BF,  9 ;  4

	warp_event 44, 46, SEVII_MT_EMBER_3BF, 12 ;  5

	warp_event 44, 28, SEVII_MT_EMBER_3BF, 13 ;  6

	warp_event  4,  4, SEVII_MT_EMBER_3BF,  22 ; 7

	warp_event 33,  7, SEVII_MT_EMBER_3BF,  23 ; 8

	warp_event 51,  8, SEVII_MT_EMBER_3BF,  24 ; 9

	warp_event 16, 16, SEVII_MT_EMBER_3BF, 25 ; 10

	warp_event 32, 21, SEVII_MT_EMBER_3BF, 26 ; 11

	warp_event 21, 25, SEVII_MT_EMBER_3BF, 27 ; 12

	warp_event 36, 25, SEVII_MT_EMBER_3BF, 28 ; 13

	warp_event 21, 32, SEVII_MT_EMBER_3BF, 29 ; 14

	warp_event 36, 32, SEVII_MT_EMBER_3BF, 30 ; 15

	warp_event 25, 36, SEVII_MT_EMBER_3BF, 31 ; 16

	warp_event 32, 36, SEVII_MT_EMBER_3BF, 32 ; 17

	warp_event 51, 38, SEVII_MT_EMBER_3BF, 33 ; 18

	warp_event  8, 51, SEVII_MT_EMBER_3BF, 34 ; 19

	warp_event 29, 51, SEVII_MT_EMBER_3BF, 35 ; 20

	warp_event 31, 56, SEVII_MT_EMBER_3BF, 36 ; 21

	def_bg_events

	def_object_events
	object_event 45, 29, SPRITE_POKE_BALL, STAY, NONE, 1, FLAME_PLUME

	def_warps_to SEVII_MT_EMBER_4BF
