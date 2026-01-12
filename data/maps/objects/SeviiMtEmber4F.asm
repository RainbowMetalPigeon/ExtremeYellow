SeviiMtEmber4F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 31,  2, SEVII_MT_EMBER,     10 ;  1
	warp_event 31,  3, SEVII_MT_EMBER,     10 ;  2

	warp_event 31,  8, SEVII_MT_EMBER,     11 ;  3
	warp_event 31,  9, SEVII_MT_EMBER,     11 ;  4

	warp_event 22, 31, SEVII_MT_EMBER,     12 ;  5
	warp_event 23, 31, SEVII_MT_EMBER,     12 ;  6

	warp_event  8, 31, SEVII_MT_EMBER,     13 ;  7
	warp_event  9, 31, SEVII_MT_EMBER,     13 ;  8

	warp_event  0, 15, SEVII_MT_EMBER,     14 ;  9
	warp_event  0, 14, SEVII_MT_EMBER,     14 ; 10

	warp_event  0,  6, SEVII_MT_EMBER,     15 ; 11
	warp_event  0,  7, SEVII_MT_EMBER,     15 ; 12

	warp_event 13,  9, SEVII_MT_EMBER_3F,   2 ; 13

	warp_event  5, 15, SEVII_MT_EMBER_5F,   6 ; 14

	warp_event 31, 24, SEVII_MT_EMBER,     16 ; 15
	warp_event 31, 25, SEVII_MT_EMBER,     16 ; 16

	warp_event 31, 31, SEVII_MT_EMBER_3F,   3 ; 17

	warp_event  2, 31, SEVII_MT_EMBER,     17 ; 18
	warp_event  3, 31, SEVII_MT_EMBER,     17 ; 19

	warp_event  3, 13, SEVII_MT_EMBER_5F,  22 ; 20

	warp_event  3, 17, SEVII_MT_EMBER_5F,  23 ; 21

	warp_event 29, 17, SEVII_MT_EMBER_5F,  24 ; 22

	warp_event  6, 28, SEVII_MT_EMBER_5F,  25 ; 23

	warp_event  5,  7, SEVII_MT_EMBER_3F,   7 ; 24

	warp_event 23,  7, SEVII_MT_EMBER_3F,   8 ; 25

	warp_event 16,  9, SEVII_MT_EMBER_3F,   9 ; 26

	warp_event  5, 10, SEVII_MT_EMBER_3F,  10 ; 27

	warp_event 24, 10, SEVII_MT_EMBER_3F,  11 ; 28

	warp_event 13, 17, SEVII_MT_EMBER_3F,  12 ; 29

	warp_event 24, 19, SEVII_MT_EMBER_3F,  13 ; 30

	warp_event 27, 23, SEVII_MT_EMBER_3F,  14 ; 31

	warp_event  7, 26, SEVII_MT_EMBER_3F,  15 ; 32

	warp_event 15, 26, SEVII_MT_EMBER_3F,  16 ; 33

	warp_event  2, 29, SEVII_MT_EMBER_3F,  17 ; 34

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_4F
