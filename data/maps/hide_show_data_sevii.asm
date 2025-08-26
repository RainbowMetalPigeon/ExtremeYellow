; default hidden/shown objects for each map

MapHSPointers_Sevii:
; entries correspond to map ids
	table_width 2, MapHSPointers_Sevii
; cities
	dw SeviiOneIslandCityHS ; SEVII_ONE_ISLAND_CITY
	dw SeviiTwoIslandCityHS ; SEVII_TWO_ISLAND_CITY
	dw SeviiThreeIslandCityHS ; SEVII_THREE_ISLAND_CITY
	dw SeviiFourIslandCityHS ; SEVII_FOUR_ISLAND_CITY
	dw SeviiFiveIslandCityHS ; SEVII_FIVE_ISLAND_CITY
	dw SeviiSixIslandCityHS ; SEVII_SIX_ISLAND_CITY
	dw SeviiSevenIslandCityHS ; SEVII_SEVEN_ISLAND_CITY
; routes
	dw NoHSSevii ; SEVII_EIGHT_ISLAND_CITY
	dw SeviiRoute31HS ; SEVII_ROUTE_31
	dw SeviiMtEmberHS ; SEVII_MT_EMBER
	dw NoHSSevii ; SEVII_ROUTE_32
	dw SeviiRoute33HS ; SEVII_ROUTE_33
	dw NoHSSevii ; SEVII_ROUTE_34
	dw NoHSSevii ; SEVII_ROUTE_35
	dw NoHSSevii ; SEVII_ROUTE_36
	dw NoHSSevii ; SEVII_ROUTE_37
	dw NoHSSevii ; SEVII_ROUTE_38
	dw NoHSSevii ; SEVII_ROUTE_39
	dw NoHSSevii ; SEVII_ROUTE_40
	dw NoHSSevii ; SEVII_ROUTE_41
	dw NoHSSevii ; SEVII_ROUTE_42
	dw NoHSSevii ; SEVII_ROUTE_43
	dw NoHSSevii ; SEVII_ROUTE_44
; indoors
; 1-island
	dw NoHSSevii ; SEVII_ONE_ISLAND_DOCK
	dw NoHSSevii ; SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_ONE_ISLAND_GYM
	dw NoHSSevii ; SEVII_ONE_ISLAND_HOUSES
	dw NoHSSevii ; SEVII_EMBER_SPA
	dw NoHSSevii ; SEVII_ROUTE_32_DIVE
; 2-island
	dw NoHSSevii ; SEVII_TWO_ISLAND_DOCK
	dw NoHSSevii ; SEVII_TWO_ISLAND_POKEMON_CENTER
	dw NoHSSevii ; SEVII_TWO_ISLAND_GYM
	dw NoHSSevii ; SEVII_TWO_ISLAND_HOUSES
; 3-island
	dw NoHSSevii ; SEVII_THREE_ISLAND_DOCK
	dw NoHSSevii ; SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_THREE_ISLAND_GYM
	dw NoHSSevii ; SEVII_THREE_ISLAND_HOUSES
	dw NoHSSevii ; SEVII_THREE_ISLAND_CAVES
	dw NoHSSevii ; SEVII_THREE_ISLAND_SECRET_GARDEN
	dw NoHSSevii ; SEVII_BERRY_FOREST
; 4-island
	dw NoHSSevii ; SEVII_FOUR_ISLAND_DOCK
	dw NoHSSevii ; SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_FOUR_ISLAND_GYM
	dw NoHSSevii ; SEVII_FOUR_ISLAND_HOUSES
	dw NoHSSevii ; SEVII_ICEFALL_CAVE_1F
; 5-island
	dw NoHSSevii ; SEVII_FIVE_ISLAND_DOCK
	dw NoHSSevii ; SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_FIVE_ISLAND_GYM
	dw NoHSSevii ; SEVII_FIVE_ISLAND_HOUSES
	dw NoHSSevii ; SEVII_FIVE_ISLAND_WAREHOUSE
	dw NoHSSevii ; SEVII_RESORT_GORGEOUS
	dw NoHSSevii ; SEVII_LOST_CAVE
; 6-island
	dw NoHSSevii ; SEVII_SIX_ISLAND_DOCK
	dw NoHSSevii ; SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_SIX_ISLAND_GYM
	dw NoHSSevii ; SEVII_ROUTE_38_HOUSES
	dw NoHSSevii ; SEVII_PATTERN_BUSH
	dw NoHSSevii ; SEVII_ALTERING_CAVE
	dw NoHSSevii ; SEVII_DOTTED_HOLE
; 7-island
	dw NoHSSevii ; SEVII_SEVEN_ISLAND_DOCK
	dw NoHSSevii ; SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART
	dw NoHSSevii ; SEVII_SEVEN_ISLAND_GYM
	dw NoHSSevii ; SEVII_SEVEN_ISLAND_HOUSES
	dw NoHSSevii ; SEVII_ROUTE_43_CAVES
	dw NoHSSevii ; SEVII_TANOBY_CHAMBERS
; 8-island
	dw NoHSSevii ; SEVII_EIGHT_ISLAND_DOCK
	dw NoHSSevii ; SEVII_EIGHT_ISLAND_CAVE
; end
	assert_table_length NUM_MAPS_SEVII
	dw -1 ; end

NoHSSevii:
	db $FF, $FF, $FF

MissableObjects_Sevii:
; entries correspond to HS_* constants (see constants/hide_show_constants_sevii)
	table_width 3, MissableObjects_Sevii ; edited, now it's the "Base" block
; format: map id, object id, HIDE/SHOW

; cities ----------------------------------

SeviiOneIslandCityHS:
	db SEVII_ONE_ISLAND_CITY, 1, SHOW
SeviiTwoIslandCityHS:
	db SEVII_TWO_ISLAND_CITY, 1, SHOW
SeviiThreeIslandCityHS:
	db SEVII_THREE_ISLAND_CITY, 1, SHOW
SeviiFourIslandCityHS:
	db SEVII_FOUR_ISLAND_CITY, 1, SHOW
SeviiFiveIslandCityHS:
	db SEVII_FIVE_ISLAND_CITY, 1, SHOW
SeviiSevenIslandCityHS:
	db SEVII_SIX_ISLAND_CITY, 1, SHOW
SeviiSixIslandCityHS:
	db SEVII_SEVEN_ISLAND_CITY, 1, SHOW

; routes ----------------------------------

SeviiRoute31HS:
	db SEVII_ROUTE_31, 1, SHOW ; rock
SeviiMtEmberHS:
	db SEVII_MT_EMBER, 1, SHOW ; MEGA_STONE_X
	db SEVII_MT_EMBER, 2, SHOW ; MEGA_STONE_Y
SeviiRoute33HS:
	db SEVII_ROUTE_33, 1, SHOW ; rock
	db SEVII_ROUTE_33, 2, SHOW ; rock
	db SEVII_ROUTE_33, 3, SHOW ; RARE_CANDY
	db SEVII_ROUTE_33, 4, SHOW ; ULTRA_BALL
	db SEVII_ROUTE_33, 5, SHOW ; PP_UP

; indoors ----------------------------------

	db $FF, $01, SHOW ; end, list terminator
	assert_table_length NUM_HS_OBJECTS_SEVII + 1