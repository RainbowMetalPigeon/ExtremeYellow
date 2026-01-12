SeviiMtEmber1F_Object:
	db $03 ; border block

	def_warp_events
	warp_event 16, 43, SEVII_MT_EMBER,      1 ;  1
	warp_event 17, 43, SEVII_MT_EMBER,      1 ;  2

	warp_event 43, 32, SEVII_MT_EMBER,      2 ;  3
	warp_event 43, 33, SEVII_MT_EMBER,      2 ;  4
	
	warp_event 43,  8, SEVII_MT_EMBER,      3 ;  5
	warp_event 43,  9, SEVII_MT_EMBER,      3 ;  6
	
	warp_event  0, 20, SEVII_MT_EMBER,      4 ;  7
	warp_event  0, 21, SEVII_MT_EMBER,      4 ;  8

	warp_event  3, 16, SEVII_MT_EMBER_2F,   3 ;  9
	
	warp_event 13, 21, SEVII_MT_EMBER_1BF,  1 ; 10

	warp_event 35, 34, SEVII_MT_EMBER_1BF,  4 ; 11

	warp_event 31, 18, SEVII_MT_EMBER_2F,   4 ; 12

	warp_event 26,  3, SEVII_MT_EMBER_2F,   9 ; 13

	warp_event 20, 21, SEVII_MT_EMBER_1BF,  5 ; 14

	warp_event  2,  2, SEVII_MT_EMBER_2F,  24 ; 15

	warp_event 20,  2, SEVII_MT_EMBER_2F,  25 ; 16

	warp_event 41,  5, SEVII_MT_EMBER_2F,  26 ; 17

	warp_event  9, 10, SEVII_MT_EMBER_2F,  27 ; 18

	warp_event 30, 11, SEVII_MT_EMBER_2F,  28 ; 19

	warp_event 15, 16, SEVII_MT_EMBER_2F,  29 ; 20

	warp_event 41, 18, SEVII_MT_EMBER_2F,  30 ; 21

	warp_event 36, 22, SEVII_MT_EMBER_2F,  31 ; 22

	warp_event 12, 26, SEVII_MT_EMBER_2F,  32 ; 23

	warp_event 19, 26, SEVII_MT_EMBER_2F,  33 ; 24

	warp_event  8, 30, SEVII_MT_EMBER_2F,  34 ; 25

	warp_event  2, 37, SEVII_MT_EMBER_2F,  35 ; 26

	warp_event 15, 39, SEVII_MT_EMBER_2F,  36 ; 27

	warp_event  8, 11, SEVII_MT_EMBER_1BF,  9 ; 28

	warp_event 18, 11, SEVII_MT_EMBER_1BF, 10 ; 29

	warp_event 25, 21, SEVII_MT_EMBER_1BF, 11 ; 30

	warp_event 37, 21, SEVII_MT_EMBER_1BF, 12 ; 31

	warp_event 33, 27, SEVII_MT_EMBER_1BF, 13 ; 32

	warp_event 16, 30, SEVII_MT_EMBER_1BF, 14 ; 33

	warp_event 32, 36, SEVII_MT_EMBER_1BF, 15 ; 34

	warp_event 18, 40, SEVII_MT_EMBER_1BF, 16 ; 35

	warp_event  8, 43, SEVII_MT_EMBER_1BF, 17 ; 36

	def_bg_events

	def_object_events
;	object_event 13, 54, SPRITE_POKE_BALL, STAY, NONE, 1, MOON_STONE

	def_warps_to SEVII_MT_EMBER_1F
