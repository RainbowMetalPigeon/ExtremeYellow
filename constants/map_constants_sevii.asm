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
	map_const SEVII_TWO_ISLAND_CITY,         20, 22 ; $01
	map_const SEVII_THREE_ISLAND_CITY,       16, 25 ; $02
	map_const SEVII_FOUR_ISLAND_CITY,        23, 22 ; $03
	map_const SEVII_FIVE_ISLAND_CITY,        20, 20 ; $04
	map_const SEVII_SIX_ISLAND_CITY,         10, 10 ; $05
	map_const SEVII_SEVEN_ISLAND_CITY,       12, 10 ; $06
DEF NUM_CITY_MAPS_SEVII EQU const_value
DEF FIRST_ROUTE_MAP_SEVII EQU const_value
	map_const SEVII_EIGHT_ISLAND_CITY,       13, 21 ; $07 ; special case: it's like a city but treated as a route
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
	map_const SEVII_ROUTE_40,                31, 27 ; $12
	map_const SEVII_ROUTE_41,                17, 26 ; $13
	map_const SEVII_ROUTE_42,                14, 30 ; $14
	map_const SEVII_ROUTE_43,                19, 46 ; $15
	map_const SEVII_ROUTE_44,                50, 15 ; $16
	map_const SEVII_FOUR_ISLAND_PARKOUR_PATH, 9, 80 ; $17
DEF FIRST_INDOOR_MAP_SEVII EQU const_value
; 1-island-related maps
	map_const SEVII_ONE_ISLAND_DOCK,                         10,  6 ; $18
	map_const SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $19
	map_const SEVII_ONE_ISLAND_GYM_1,                         4,  3 ; $1A
	map_const SEVII_ONE_ISLAND_GYM_2,                         5, 10 ; $1B
	map_const SEVII_ONE_ISLAND_HOUSES,                       25,  4 ; $1C
	map_const SEVII_EMBER_SPA,                               10, 10 ; $1D
	map_const SEVII_ROUTE_32_DIVE,                           15, 30 ; $1E
	map_const SEVII_MT_EMBER_4BF,                            30, 30 ; $1F
	map_const SEVII_MT_EMBER_3BF,                            28, 28 ; $20
	map_const SEVII_MT_EMBER_2BF,                            26, 26 ; $21
	map_const SEVII_MT_EMBER_1BF,                            24, 24 ; $22
	map_const SEVII_MT_EMBER_1F,                             22, 22 ; $23
	map_const SEVII_MT_EMBER_2F,                             20, 20 ; $24
	map_const SEVII_MT_EMBER_3F,                             18, 18 ; $25
	map_const SEVII_MT_EMBER_4F,                             16, 16 ; $26
	map_const SEVII_MT_EMBER_5F,                             14, 14 ; $27
	map_const SEVII_MT_EMBER_6F,                             12, 12 ; $28
	map_const SEVII_MT_EMBER_7F,                             10, 10 ; $29
	map_const SEVII_MT_EMBER_8F,                              8,  8 ; $2A
	map_const SEVII_MT_EMBER_9F,                              6,  6 ; $2B
	map_const SEVII_MT_EMBER_10F,                             4,  4 ; $2C
	map_const SEVII_MT_EMBER_11F,                             2,  2 ; $2D
	map_const SEVII_UNDERGROUND_ONE,                         36,  4 ; $2E
; 2-island-related maps
	map_const SEVII_TWO_ISLAND_DOCK,                         10,  6 ; $2F
	map_const SEVII_TWO_ISLAND_POKEMON_CENTER,                4,  4 ; $30
	map_const SEVII_TWO_ISLAND_GYM,                          16,  9 ; $31
	map_const SEVII_TWO_ISLAND_HOUSES,                       33,  4 ; $32
	map_const SEVII_TWO_ISLAND_CITY_DIVE,                    20, 22 ; $33
	map_const SEVII_TWO_ISLET,                               32, 28 ; $34
	map_const SEVII_TWO_ISLET_HOUSES,                        18,  4 ; $35
	map_const SEVII_TWO_ISLET_DIVE,                          32, 28 ; $36
	map_const SEVII_TWO_ISLET_ROCK_MAZE,                     20, 20 ; $37
	map_const SEVII_TWO_ISLET_ROCK_MAZE_DIVE,                20, 20 ; $38
	map_const SEVII_TWO_ISLET_ROCK_MAZE_DIVE_CAVERN,         20, 20 ; $39
	map_const SEVII_UNDERGROUND_TWO,                         12, 16 ; $3A
; 3-island-related maps
	map_const SEVII_THREE_ISLAND_DOCK,                       10,  6 ; $3B
	map_const SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $3C
	map_const SEVII_THREE_ISLAND_GYM,                        18, 11 ; $3D
	map_const SEVII_THREE_ISLAND_HOUSES,                     18,  4 ; $3E
	map_const SEVII_THREE_ISLAND_SECRET_GARDEN,               9,  9 ; $3F
	map_const SEVII_THREE_ISLAND_CAVES,                      17, 10 ; $40
	map_const SEVII_BERRY_FOREST,                            20, 20 ; $41
	map_const SEVII_ROUTE_33_DIVE,                           50, 12 ; $42
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F1,                 11, 10 ; $43
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F2,                 30, 10 ; $44
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F3,                 78,  5 ; $45
	map_const SEVII_ROUTE_33_DIVE_CAVERN_F4,                105,  3 ; $46
	map_const SEVII_UNDERGROUND_THREE,                       28, 12 ; $47
; 4-island-related maps
	map_const SEVII_FOUR_ISLAND_DOCK,                        10,  6 ; $48
	map_const SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $49
	map_const SEVII_FOUR_ISLAND_GYM,                         16,  9 ; $4A
	map_const SEVII_FOUR_ISLAND_HOUSES,                      32,  4 ; $4B
	map_const SEVII_FOUR_ISLAND_HAZARD_ROOM,                  9, 12 ; $4C
	map_const SEVII_ICEFALL_CAVE_1F,                         19, 20 ; $4D
	map_const SEVII_ICEFALL_CAVE_2F,                         11, 11 ; $4E
	map_const SEVII_FOUR_ISLAND_CITY_DIVE,                   23, 22 ; $4F
	map_const SEVII_FOUR_ISLAND_CITY_DIVE_CAVERN,            33, 27 ; $50
	map_const SEVII_UNDERGROUND_FOUR,                        28, 16 ; $51
; 5-island-related maps
	map_const SEVII_FIVE_ISLAND_DOCK,                        10,  6 ; $52
	map_const SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART,     11,  4 ; $53
	map_const SEVII_FIVE_ISLAND_GYM,                         18, 12 ; $54
	map_const SEVII_FIVE_ISLAND_HOUSES,                      11,  4 ; $55
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_BF,                17, 11 ; $56
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_1F,                17, 11 ; $57
	map_const SEVII_FIVE_ISLAND_WAREHOUSE_2F,                17, 11 ; $58
	map_const SEVII_RESORT_GORGEOUS,                          6,  6 ; $59
	map_const SEVII_LOST_CAVE_1,                             29,  5 ; $5A
	map_const SEVII_LOST_CAVE_2,                             29,  5 ; $5B
	map_const SEVII_LOST_CAVE_3,                             29,  5 ; $5C
	map_const SEVII_FIVE_ISLAND_CITY_DIVE,                   20, 20 ; $5D
	map_const SEVII_FIVE_ISLAND_CITY_DIVE_CAVERN,            16, 38 ; $5E
	map_const SEVII_UNDERGROUND_FIVE,                         8, 16 ; $5F
; 6-island-related maps
	map_const SEVII_SIX_ISLAND_DOCK,                         10,  6 ; $60
	map_const SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART,      11,  4 ; $61
	map_const SEVII_SIX_ISLAND_GYM_1,                        32,  4 ; $62
	map_const SEVII_SIX_ISLAND_GYM_2,                        39,  4 ; $63
	map_const SEVII_SIX_ISLAND_GYM_3,                        25,  4 ; $64
	map_const SEVII_SIX_ISLAND_HOUSES,                        4,  4 ; $65
	map_const SEVII_ROUTE_38_HOUSES,                         11,  4 ; $66
	map_const SEVII_PATTERN_BUSH,                            20, 15 ; $67
	map_const SEVII_ALTERING_CAVE,                           13, 21 ; $68
	map_const SEVII_ALTERING_CAVE_2,                         13, 21 ; $69
	map_const SEVII_ALTERING_CAVE_3,                         13, 21 ; $6A
	map_const SEVII_ALTERING_CAVE_4,                          3,  3 ; $6B
	map_const SEVII_DOTTED_HOLE,                             10,  7 ; $6C
	map_const SEVII_ROUTE_38_DIVE,                           14, 15 ; $6D
	map_const SEVII_ROUTE_38_DIVE_CAVERN,                     5, 14 ; $6E
	map_const SEVII_ROUTE_39_DIVE,                           15, 30 ; $6F
	map_const SEVII_SECRET_BEACH,                            30, 30 ; $70
	map_const SEVII_SECRET_BEACH_DIVE,                       30, 30 ; $71
	map_const SEVII_SECRET_BEACH_HOUSE,                       8,  5 ; $72
	map_const SEVII_UNDERGROUND_SIX,                         24, 16 ; $73
; 7-island-related maps
	map_const SEVII_SEVEN_ISLAND_DOCK,                       10,  6 ; $74
	map_const SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART,    11,  4 ; $75
	map_const SEVII_SEVEN_ISLAND_GYM_1,                       4,  3 ; $76
	map_const SEVII_SEVEN_ISLAND_GYM_2,                      20, 20 ; $77
	map_const SEVII_SEVEN_ISLAND_GYM_2_DIVE,                 20, 20 ; $78
	map_const SEVII_SEVEN_ISLAND_GYM_2_DIVE_CAVERN,          13, 13 ; $79
	map_const SEVII_SEVEN_ISLAND_GYM_3,                      22, 22 ; $7A
	map_const SEVII_SEVEN_ISLAND_HOUSES,                     18,  4 ; $7B
	map_const SEVII_ROUTE_43_CAVES,                           7, 25 ; $7C
	map_const SEVII_TANOBY_CHAMBERS,                         43,  8 ; $7D
	map_const SEVII_TANOBY_GARDEN,                            9,  9 ; $7E
	map_const SEVII_TANOBY_DEN,                               9,  5 ; $7F
	map_const SEVII_UNDERGROUND_SEVEN,                       20, 36 ; $80
; 8-island-related maps
	map_const SEVII_EIGHT_ISLAND_DOCK,                       10,  6 ; $81
	map_const SEVII_EIGHT_ISLAND_CAVE,                        7,  6 ; $82
; extra
	map_const SEVII_DESOLATED_ROCK,                          12, 12 ; $83
	map_const SEVII_UNDERGROUND_LOBBY,                       13,  7 ; $84
	map_const SEVII_TEN_ISLAND,                              41, 20 ; $85
DEF NUM_MAPS_SEVII EQU const_value

; Indoor maps, such as houses, use this as the Map ID in their exit warps
; This map ID takes the player back to the last outdoor map they were on, stored in wLastMap
DEF LAST_MAP_SEVII EQU -1
