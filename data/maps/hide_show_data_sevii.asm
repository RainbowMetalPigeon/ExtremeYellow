; default hidden/shown objects for each map

MapHSPointers_Sevii:
; entries correspond to map ids
	table_width 2, MapHSPointers_Sevii
	dw SeviiOneIslandCityHS ; SEVII_ONE_ISLAND_CITY
	dw SeviiTwoIslandCityHS ; SEVII_TWO_ISLAND_CITY
	dw SeviiThreeIslandCityHS ; SEVII_THREE_ISLAND_CITY
	dw SeviiFourIslandCityHS ; SEVII_FOUR_ISLAND_CITY
	dw SeviiFiveIslandCityHS ; SEVII_FIVE_ISLAND_CITY
	dw SeviiSixIslandCityHS ; SEVII_SIX_ISLAND_CITY
	dw SeviiSevenIslandCityHS ; SEVII_SEVEN_ISLAND_CITY
	dw SeviiRoute31HS ; SEVII_ROUTE_31
	dw NoHS ; SEVII_ONE_ISLAND_DOCK
	assert_table_length NUM_MAPS_SEVII
	dw -1 ; end

;NoHS:
;	db $FF, $FF, $FF

MissableObjects_Sevii:
; entries correspond to HS_* constants (see constants/hide_show_constants_sevii)
	table_width 3, MissableObjects_Sevii ; edited, now it's the "Base" block
; format: map id, object id, HIDE/SHOW

SeviiOneIslandCityHS:
	db SEVII_ONE_ISLAND_CITY, $01, SHOW
SeviiTwoIslandCityHS:
	db SEVII_TWO_ISLAND_CITY, $01, SHOW
SeviiThreeIslandCityHS:
	db SEVII_THREE_ISLAND_CITY, $01, SHOW
SeviiFourIslandCityHS:
	db SEVII_FOUR_ISLAND_CITY, $01, SHOW
SeviiFiveIslandCityHS:
	db SEVII_FIVE_ISLAND_CITY, $01, SHOW
SeviiSevenIslandCityHS:
	db SEVII_SIX_ISLAND_CITY, $01, SHOW
SeviiSixIslandCityHS:
	db SEVII_SEVEN_ISLAND_CITY, $01, SHOW
SeviiRoute31HS:
	db SEVII_ROUTE_31, $01, SHOW ; rock

	db $FF, $01, SHOW ; end, list terminator
	assert_table_length NUM_HS_OBJECTS_SEVII + 1