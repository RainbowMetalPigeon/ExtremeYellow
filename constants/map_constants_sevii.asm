;MACRO map_const
;	const \1
;	DEF \1_WIDTH EQU \2
;	DEF \1_HEIGHT EQU \3
;ENDM

; map ids
; indexes for:
; - MapHeaderBanks (see data/maps/map_header_banks.asm)
; - MapHeaderPointers (see data/maps/map_header_pointers.asm)
; - MapSongBanks (see data/maps/songs.asm)
; - MapHSPointers (see data/maps/hide_show_data.asm)
; - MapSpriteSets (see data/maps/sprite_sets_sevii.asm)
; - ExternalMapEntries (see data/maps/town_map_entries_sevii.asm)
; - WildDataPointers (see data/wild/grass_water_sevii.asm)
; Each map also has associated data in maps.asm.
; Order: towns/cities, then routes, then indoor/dungeon maps
	const_def
	map_const SEVII_ONE_ISLAND_CITY,         20, 20 ; $00
	map_const SEVII_TWO_ISLAND_CITY,         20, 21 ; $01
	map_const SEVII_THREE_ISLAND_CITY,       15, 25 ; $02
	map_const SEVII_FOUR_ISLAND_CITY,        20, 20 ; $03
	map_const SEVII_FIVE_ISLAND_CITY,        20, 20 ; $04
	map_const SEVII_SIX_ISLAND_CITY,         10, 10 ; $05
	map_const SEVII_SEVEN_ISLAND_CITY,       12, 10 ; $06
DEF NUM_CITY_MAPS_SEVII EQU const_value
DEF FIRST_ROUTE_MAP_SEVII EQU const_value
	map_const SEVII_EIGHT_ISLAND_CITY,       13, 20 ; $07 ; special case: it's like a city but treated as a route
	map_const SEVII_ROUTE_31,                15, 55 ; $08
	map_const SEVII_MT_EMBER,                30, 30 ; $09
	map_const SEVII_ROUTE_32,                15, 30 ; $0A
	map_const SEVII_ROUTE_33,                50, 12 ; $0B
	map_const SEVII_ROUTE_34,                25, 10 ; $0C
	map_const SEVII_ROUTE_35,                25, 10 ; $0D
	map_const SEVII_ROUTE_36,                10, 25 ; $0E
	map_const SEVII_ROUTE_37,                10, 26 ; $0F
	map_const SEVII_ROUTE_38,                14, 15 ; $10
	map_const SEVII_ROUTE_39,                15, 30 ; $11
	map_const SEVII_ROUTE_40,                30, 23 ; $12
	map_const SEVII_ROUTE_41,                17, 26 ; $13
	map_const SEVII_ROUTE_42,                12, 30 ; $14
	map_const SEVII_ROUTE_43,                19, 46 ; $15
	map_const SEVII_ROUTE_44,                50, 15 ; $16
DEF FIRST_INDOOR_MAP_SEVII EQU const_value
; 1-island-related maps
	map_const SEVII_ONE_ISLAND_DOCK,                         10,  6 ; $17
	map_const SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $18
	map_const SEVII_ONE_ISLAND_GYM,                          20, 20 ; $19
	map_const SEVII_ONE_ISLAND_HOUSES,                       11,  4 ; $1A
	map_const SEVII_EMBER_SPA,                               10, 10 ; $1B
	map_const SEVII_ROUTE_32_DIVE,                           15, 30 ; $1C
; 2-island-related maps
	map_const SEVII_TWO_ISLAND_DOCK,                         10,  6 ; $1D
	map_const SEVII_TWO_ISLAND_POKEMON_CENTER,                4,  4 ; $1E
	map_const SEVII_TWO_ISLAND_GYM,                          20, 20 ; $1F
	map_const SEVII_TWO_ISLAND_HOUSES,                       18,  4 ; $20
; 3-island-related maps
	map_const SEVII_THREE_ISLAND_DOCK,                       10,  6 ; $21
	map_const SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $22
	map_const SEVII_THREE_ISLAND_GYM,                        20, 20 ; $23
	map_const SEVII_THREE_ISLAND_HOUSES,                     11,  4 ; $24
	map_const SEVII_THREE_ISLAND_SECRET_GARDEN,               9,  9 ; $25
	map_const SEVII_THREE_ISLAND_CAVES,                      15, 10 ; $26
	map_const SEVII_BERRY_FOREST,                            20, 20 ; $27
; 4-island-related maps
	map_const SEVII_FOUR_ISLAND_DOCK,                        10,  6 ; $28
	map_const SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $29
	map_const SEVII_FOUR_ISLAND_GYM,                         20, 20 ; $2A
	map_const SEVII_FOUR_ISLAND_HOUSES,                      25,  4 ; $1A
	map_const SEVII_ICEFALL_CAVE_1F,                         15, 15 ; $23
; 5-island-related maps
	map_const SEVII_FIVE_ISLAND_DOCK,                        10,  6 ; $24
	map_const SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $25
	map_const SEVII_FIVE_ISLAND_GYM,                         20, 20 ; $19
	map_const SEVII_FIVE_ISLAND_HOUSES,                       4,  4 ; $1A
	map_const SEVII_FIVE_ISLAND_WAREHOUSE,                   10,  6 ; $1A
	map_const SEVII_RESORT_GORGEOUS,                          6,  6 ; $1A
	map_const SEVII_LOST_CAVE_1,                             29,  5 ; $1A
	map_const SEVII_LOST_CAVE_2,                             29,  5 ; $1A
	map_const SEVII_LOST_CAVE_3,                             29,  5 ; $1A
; 6-island-related maps
	map_const SEVII_SIX_ISLAND_DOCK,                         10,  6 ; $26
	map_const SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $27
	map_const SEVII_SIX_ISLAND_GYM,                          20, 20 ; $19
	map_const SEVII_ROUTE_38_HOUSES,                         11,  4 ; $19
	map_const SEVII_PATTERN_BUSH,                            20, 15 ; $19
	map_const SEVII_ALTERING_CAVE,                           12, 12 ; $19
	map_const SEVII_DOTTED_HOLE,                              7,  7 ; $19
; 7-island-related maps
	map_const SEVII_SEVEN_ISLAND_DOCK,                       10,  6 ; $28
	map_const SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $29
	map_const SEVII_SEVEN_ISLAND_GYM,                        20, 20 ; $19
	map_const SEVII_SEVEN_ISLAND_HOUSES,                      4,  4 ; $1A
	map_const SEVII_ROUTE_43_CAVES,                           7, 25 ; $1A
	map_const SEVII_TANOBY_CHAMBERS,                         43,  7 ; $1A
; 8-island-related maps
	map_const SEVII_EIGHT_ISLAND_DOCK,                       10,  6 ; $2A
	map_const SEVII_EIGHT_ISLAND_CAVE,                        5,  5 ; $2A
DEF NUM_MAPS_SEVII EQU const_value

; Indoor maps, such as houses, use this as the Map ID in their exit warps
; This map ID takes the player back to the last outdoor map they were on, stored in wLastMap
DEF LAST_MAP_SEVII EQU -1
