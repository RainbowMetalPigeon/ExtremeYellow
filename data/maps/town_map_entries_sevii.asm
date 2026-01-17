;MACRO external_map
;	dn \2, \1
;	dw \3
;ENDM

; the appearance of towns and routes in the town map
ExternalMapEntries_Sevii:
	table_width 3, ExternalMapEntries_Sevii
	; x, y, name
	external_map  0,  4, OneIslandName
	external_map  6,  3, TwoIslandName
	external_map 14,  3, ThreeIslandName
	external_map  2,  8, FourIslandName
	external_map  8,  9, FiveIslandName
	external_map 14, 11, SixIslandName
	external_map  4, 12, SevenIslandName
	external_map 11, 15, EightIslandName
	external_map  1,  3, Route31Name
	external_map  1,  1, MtEmberName
	external_map  0,  5, Route32Name
	external_map 13,  3, Route33Name
	external_map  7,  8, Route34Name
	external_map  9,  7, Route35Name
	external_map 10, 11, Route36Name
	external_map 15, 11, Route37Name
	external_map 15,  9, Route38Name
	external_map 13,  8, Route39Name
	external_map 15, 13, Route40Name
	external_map  4, 11, Route41Name
	external_map  4, 13, Route42Name
	external_map  5, 14, Route43Name
	external_map  4, 15, Route44Name
	assert_table_length FIRST_INDOOR_MAP_SEVII


;MACRO internal_map
;	db \1 + 1
;	dn \3, \2
;	dw \4
;ENDM

; the appearance of buildings and dungeons in the town map
InternalMapEntries_Sevii:
	; maximum map id subject to this rule, x, y, name
; 1-island
	internal_map SEVII_ONE_ISLAND_HOUSES,                           0,  4, OneIslandName
	internal_map SEVII_EMBER_SPA,                                   2,  3, EmberSpaName
	internal_map SEVII_ROUTE_32_DIVE,                               0,  5, Route32DiveName
	internal_map SEVII_MT_EMBER_11F,                                1,  1, MtEmberName
; 2-island
	internal_map SEVII_TWO_ISLAND_HOUSES,                           6,  3, TwoIslandName
	internal_map SEVII_TWO_ISLAND_CITY_DIVE,                        6,  3, TwoIslandDiveName
; 3-island
	internal_map SEVII_THREE_ISLAND_SECRET_GARDEN,                 14,  3, ThreeIslandName
	internal_map SEVII_THREE_ISLAND_CAVES,                         15,  4, ThreeIslandCavesName
	internal_map SEVII_BERRY_FOREST,                               12,  3, BerryForestName
	internal_map SEVII_ROUTE_33_DIVE_CAVERN_F4,                    13,  3, Route33DiveName
; 4-island
	internal_map SEVII_FOUR_ISLAND_HAZARD_ROOM,                     2,  8, FourIslandName
	internal_map SEVII_ICEFALL_CAVE_2F,                             3,  7, IcefallCaveName
	internal_map SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN,                2,  8, FourIslandDiveName
; 5-island
	internal_map SEVII_FIVE_ISLAND_HOUSES,                          8,  9, FiveIslandName
	internal_map SEVII_FIVE_ISLAND_WAREHOUSE_2F,                    9, 10, FiveIslandWarehouseName
	internal_map SEVII_RESORT_GORGEOUS,                             9,  7, Route35Name
	internal_map SEVII_LOST_CAVE_3,                                10,  7, LostCaveName
	internal_map SEVII_FIVE_ISLAND_CITY_DIVE_CAVERN,                8,  9, FiveIslandDiveName
; 6-island
	internal_map SEVII_SIX_ISLAND_GYM_3,                           14, 11, SixIslandName
	internal_map SEVII_ROUTE_38_HOUSES,                            15,  9, Route38Name
	internal_map SEVII_PATTERN_BUSH,                               14,  9, PatternBushName
	internal_map SEVII_ALTERING_CAVE,                              13,  6, AlteringCaveName
	internal_map SEVII_DOTTED_HOLE,                                14, 13, DottedHoleName
	internal_map SEVII_ROUTE_38_DIVE_CAVERN,                       15,  9, Route38DiveName
	internal_map SEVII_ROUTE_39_DIVE,                              13,  8, Route39DiveName
; 7-island
	internal_map SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART,        4, 12, SevenIslandName
	internal_map SEVII_SEVEN_ISLAND_GYM_3,                          4, 11, Route41Name
	internal_map SEVII_SEVEN_ISLAND_HOUSES,                         4, 12, SevenIslandName
	internal_map SEVII_ROUTE_43_CAVES,                              5, 14, Route43Name
	internal_map SEVII_TANOBY_CHAMBERS,                             7, 15, TanobyChambersName
; 8-island
	internal_map SEVII_EIGHT_ISLAND_CAVE,                          11, 15, EightIslandName
; extra
	internal_map SEVII_DESOLATED_ROCK,                              0, 11, DesolatedRockName
	db -1 ; end
