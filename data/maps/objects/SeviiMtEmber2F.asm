SeviiMtEmber2F_Object:
	db $03 ; border block

	def_warp_events
	warp_event  0,  4, SEVII_MT_EMBER,      5 ;  1
	warp_event  0,  5, SEVII_MT_EMBER,      5 ;  2

	warp_event  1, 14, SEVII_MT_EMBER_1F,   9 ;  3

	warp_event 29, 16, SEVII_MT_EMBER_1F,  12 ;  4

	warp_event 25, 15, SEVII_MT_EMBER_3F,   1 ;  5

	warp_event 34, 24, SEVII_MT_EMBER_3F,   4 ;  6

	warp_event 27, 25, SEVII_MT_EMBER_3F,   5 ;  7

	warp_event 22, 28, SEVII_MT_EMBER_3F,   6 ;  8

	warp_event 24,  1, SEVII_MT_EMBER_1F,  13 ;  9

	warp_event  0, 22, SEVII_MT_EMBER,      6 ; 10
	warp_event  0, 23, SEVII_MT_EMBER,      6 ; 11

	warp_event  6, 39, SEVII_MT_EMBER,      7 ; 12
	warp_event  7, 39, SEVII_MT_EMBER,      7 ; 13

	warp_event 24, 39, SEVII_MT_EMBER,      8 ; 14
	warp_event 25, 39, SEVII_MT_EMBER,      8 ; 15

	warp_event 39, 24, SEVII_MT_EMBER,      9 ; 16
	warp_event 39, 25, SEVII_MT_EMBER,      9 ; 17

	warp_event 30,  4, SEVII_MT_EMBER_3F,  18 ; 18

	warp_event 19,  7, SEVII_MT_EMBER_3F,  19 ; 19

	warp_event 37,  9, SEVII_MT_EMBER_3F,  20 ; 20

	warp_event 23, 20, SEVII_MT_EMBER_3F,  21 ; 21

	warp_event  5, 21, SEVII_MT_EMBER_3F,  22 ; 22

	warp_event 30, 35, SEVII_MT_EMBER_3F,  23 ; 23

	warp_event  0,  0, SEVII_MT_EMBER_1F,  15 ; 24

	warp_event 18,  0, SEVII_MT_EMBER_1F,  16 ; 25

	warp_event 39,  3, SEVII_MT_EMBER_1F,  17 ; 26

	warp_event  7,  8, SEVII_MT_EMBER_1F,  18 ; 27

	warp_event 28,  9, SEVII_MT_EMBER_1F,  19 ; 28

	warp_event 13, 14, SEVII_MT_EMBER_1F,  20 ; 29

	warp_event 39, 16, SEVII_MT_EMBER_1F,  21 ; 30

	warp_event 34, 20, SEVII_MT_EMBER_1F,  22 ; 31

	warp_event 10, 24, SEVII_MT_EMBER_1F,  23 ; 32

	warp_event 17, 24, SEVII_MT_EMBER_1F,  24 ; 33

	warp_event  6, 28, SEVII_MT_EMBER_1F,  25 ; 34

	warp_event  0, 35, SEVII_MT_EMBER_1F,  26 ; 35

	warp_event 13, 37, SEVII_MT_EMBER_1F,  27 ; 36

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_2F
