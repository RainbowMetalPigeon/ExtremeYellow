;DEF HIDE EQU $11
;DEF SHOW EQU $15

; MissableObjects indexes (see data/maps/hide_show_data_sevii.asm)
; this is a list of the sprites that can be enabled/disabled during the game

	const_def							   ; equivalent to "const_value=0"
; cities
	const HS_SEVII_ONE_ISLAND_CITY_1       ; TBE
	const HS_SEVII_TWO_ISLAND_CITY_1       ; TBE
	const HS_SEVII_THREE_ISLAND_CITY_1     ; TBE
	const HS_SEVII_FOUR_ISLAND_CITY_1      ; TBE
	const HS_SEVII_FIVE_ISLAND_CITY_1      ; TBE
	const HS_SEVII_SIX_ISLAND_CITY_1       ; TBE
	const HS_SEVII_SEVEN_ISLAND_CITY_1     ; TBE
; routes
	const HS_SEVII_ROUTE_31_ROCK_1         ; TBE
	const HS_SEVII_MT_EMBER_MEGA_STONE_1   ; x
	const HS_SEVII_MT_EMBER_MEGA_STONE_2   ; x
	const HS_SEVII_ROUTE_33_ROCK_1         ; x
	const HS_SEVII_ROUTE_33_ROCK_2         ; x
	const HS_SEVII_ROUTE_33_ITEM_1         ; x
	const HS_SEVII_ROUTE_33_ITEM_2         ; x
	const HS_SEVII_ROUTE_33_ITEM_3         ; x
; indoors
DEF NUM_HS_OBJECTS_SEVII EQU const_value