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
	map_const SEVII_THREE_ISLAND_CITY,       16, 25 ; $02
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
	map_const SEVII_ROUTE_42,                14, 30 ; $14
	map_const SEVII_ROUTE_43,                19, 46 ; $15
	map_const SEVII_ROUTE_44,                50, 15 ; $16
DEF FIRST_INDOOR_MAP_SEVII EQU const_value
; 1-island-related maps
	map_const SEVII_ONE_ISLAND_DOCK,                         10,  6 ; $17
	map_const SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $18
	map_const SEVII_ONE_ISLAND_GYM_1,                         4,  3 ; $19
	map_const SEVII_ONE_ISLAND_GYM_2,                         5, 10 ; $1A
	map_const SEVII_ONE_ISLAND_HOUSES,                       11,  4 ; $1B
	map_const SEVII_EMBER_SPA,                               10, 10 ; $1C
	map_const SEVII_ROUTE_32_DIVE,                           15, 30 ; $1D
	map_const SEVII_MT_EMBER_4BF,                            30, 30 ; $1E
	map_const SEVII_MT_EMBER_3BF,                            28, 28 ; $1F
	map_const SEVII_MT_EMBER_2BF,                            26, 26 ; $20
	map_const SEVII_MT_EMBER_1BF,                            24, 24 ; $21
	map_const SEVII_MT_EMBER_1F,                             22, 22 ; $22
	map_const SEVII_MT_EMBER_2F,                             20, 20 ; $23
	map_const SEVII_MT_EMBER_3F,                             18, 18 ; $24
	map_const SEVII_MT_EMBER_4F,                             16, 16 ; $25
	map_const SEVII_MT_EMBER_5F,                             14, 14 ; $26
	map_const SEVII_MT_EMBER_6F,                             12, 12 ; $27
	map_const SEVII_MT_EMBER_7F,                             10, 10 ; $28
	map_const SEVII_MT_EMBER_8F,                              8,  8 ; $29
	map_const SEVII_MT_EMBER_9F,                              6,  6 ; $2A
	map_const SEVII_MT_EMBER_10F,                             4,  4 ; $2B
	map_const SEVII_MT_EMBER_11F,                             2,  2 ; $2C
; 2-island-related maps
	map_const SEVII_TWO_ISLAND_DOCK,                         10,  6 ; $2D
	map_const SEVII_TWO_ISLAND_POKEMON_CENTER,                4,  4 ; $2E
	map_const SEVII_TWO_ISLAND_GYM,                          16,  9 ; $2F
	map_const SEVII_TWO_ISLAND_HOUSES,                       18,  4 ; $30
	map_const SEVII_TWO_ISLAND_CITY_DIVE,                    20, 21 ; $31
; 3-island-related maps
	map_const SEVII_THREE_ISLAND_DOCK,                       10,  6 ; $32
	map_const SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $33
	map_const SEVII_THREE_ISLAND_GYM,                        18, 11 ; $34
	map_const SEVII_THREE_ISLAND_HOUSES,                     11,  4 ; $35
	map_const SEVII_THREE_ISLAND_SECRET_GARDEN,               9,  9 ; $36
	map_const SEVII_THREE_ISLAND_CAVES,                      17, 10 ; $37
	map_const SEVII_BERRY_FOREST,                            20, 20 ; $38
	map_const SEVII_ROUTE_33_DIVE,                           50, 12 ; $39
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F1,                 11, 10 ; $3A
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F2,                 30, 10 ; $3B
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F3,                 78,  5 ; $3C
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F4,                105,  3 ; $3D
; 4-island-related maps
	map_const SEVII_FOUR_ISLAND_DOCK,                        10,  6 ; $3E
	map_const SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $3F
	map_const SEVII_FOUR_ISLAND_GYM,                         16,  9 ; $40
	map_const SEVII_FOUR_ISLAND_HOUSES,                      25,  4 ; $41
	map_const SEVII_FOUR_ISLAND_HAZARD_ROOM,                  9, 12 ; $42
	map_const SEVII_ICEFALL_CAVE_1F,                         19, 20 ; $43
	map_const SEVII_ICEFALL_CAVE_2F,                         11, 11 ; $44
	map_const SEVII_FOUR_ISLAND_CITY_DIVE,                   20, 20 ; $45
	map_const SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN,            33, 27 ; $46
; 5-island-related maps
	map_const SEVII_FIVE_ISLAND_DOCK,                        10,  6 ; $47
	map_const SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $48
	map_const SEVII_FIVE_ISLAND_GYM,                         18, 12 ; $49
	map_const SEVII_FIVE_ISLAND_HOUSES,                       4,  4 ; $4A
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_BF,                17, 11 ; $4B
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_1F,                17, 11 ; $4C
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_2F,                17, 11 ; $4D
	map_const SEVII_RESORT_GORGEOUS,                          6,  6 ; $4E
	map_const SEVII_LOST_CAVE_1,                             29,  5 ; $4F
	map_const SEVII_LOST_CAVE_2,                             29,  5 ; $50
	map_const SEVII_LOST_CAVE_3,                             29,  5 ; $51
	map_const SEVII_FIVE_ISLAND_CITY_DIVE,                   20, 20 ; $52
	map_const SEVII_FIVE_ISLAND_CITY_DIVE_CAVERN,            16, 38 ; $53
; 6-island-related maps
	map_const SEVII_SIX_ISLAND_DOCK,                         10,  6 ; $54
	map_const SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $55
	map_const SEVII_SIX_ISLAND_GYM_1,                        32,  4 ; $56
	map_const SEVII_SIX_ISLAND_GYM_2,                        39,  4 ; $57
	map_const SEVII_SIX_ISLAND_GYM_3,                        25,  4 ; $58
	map_const SEVII_ROUTE_38_HOUSES,                         11,  4 ; $59
	map_const SEVII_PATTERN_BUSH,                            20, 15 ; $6A
	map_const SEVII_ALTERING_CAVE,                           12, 12 ; $6B
	map_const SEVII_DOTTED_HOLE,                              7,  7 ; $6C
	map_const SEVII_ROUTE_38_DIVE,                           14, 15 ; $6D
	map_const SEVII_ROUTE_38_DIVE_CAVERN,                     5, 14 ; $6E
	map_const SEVII_ROUTE_39_DIVE,                           15, 30 ; $6F
; 7-island-related maps
	map_const SEVII_SEVEN_ISLAND_DOCK,                       10,  6 ; $70
	map_const SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $71
	map_const SEVII_SEVEN_ISLAND_GYM_1,                       4,  3 ; $72
	map_const SEVII_SEVEN_ISLAND_GYM_2,                      20, 20 ; $73
	map_const SEVII_SEVEN_ISLAND_GYM_2_DIVE,                 20, 20 ; $74
	map_const SEVII_SEVEN_ISLAND_GYM_2_DIVE_CAVERN,          13, 13 ; $75
	map_const SEVII_SEVEN_ISLAND_GYM_3,                      22, 22 ; $76
	map_const SEVII_SEVEN_ISLAND_HOUSES,                     11,  4 ; $77
	map_const SEVII_ROUTE_43_CAVES,                           7, 25 ; $78
	map_const SEVII_TANOBY_CHAMBERS,                         43,  7 ; $79
; 8-island-related maps
	map_const SEVII_EIGHT_ISLAND_DOCK,                       10,  6 ; $7A
	map_const SEVII_EIGHT_ISLAND_CAVE,                        5,  5 ; $7B
; extra
	map_const SEVII_DESOLATED_ROCK,                          12, 12 ; $7C
DEF NUM_MAPS_SEVII EQU const_value

; Indoor maps, such as houses, use this as the Map ID in their exit warps
; This map ID takes the player back to the last outdoor map they were on, stored in wLastMap
DEF LAST_MAP_SEVII EQU -1
