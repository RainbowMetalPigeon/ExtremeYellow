MACRO map_const
	const \1
	DEF \1_WIDTH EQU \2
	DEF \1_HEIGHT EQU \3
ENDM

; map ids
; indexes for:
; - MapHeaderBanks (see data/maps/map_header_banks.asm)
; - MapHeaderPointers (see data/maps/map_header_pointers.asm)
; - MapSongBanks (see data/maps/songs.asm)
; - MapHSPointers (see data/maps/hide_show_data.asm)
; - MapSpriteSets (see data/maps/sprite_sets.asm)
; - ExternalMapEntries (see data/maps/town_map_entries.asm)
; - WildDataPointers (see data/wild/grass_water.asm)
; Each map also has associated data in maps.asm.
; Order: towns/cities, then routes, then indoor/dungeon maps
	const_def
	map_const PALLET_TOWN,                   10,  9 ; $00
	map_const VIRIDIAN_CITY,                 20, 18 ; $01
	map_const PEWTER_CITY,                   20, 18 ; $02
	map_const CERULEAN_CITY,                 20, 18 ; $03
	map_const LAVENDER_TOWN,                 10,  9 ; $04
	map_const VERMILION_CITY,                20, 18 ; $05
	map_const CELADON_CITY,                  25, 28 ; $06 ; edited
	map_const OCHRE_CITY,                    23, 23 ; $07 ; new
	map_const FUCHSIA_CITY,                  20, 18 ; $08
	map_const OBSIDIAN_ISLAND,               20, 20 ; $09 ; new
	map_const CINNABAR_ISLAND,               25, 15 ; $0A ; edited
	map_const INDIGO_PLATEAU,                10,  9 ; $0B
	map_const SAFFRON_CITY,                  20, 18 ; $0C
DEF NUM_CITY_MAPS EQU const_value
DEF FIRST_ROUTE_MAP EQU const_value
	map_const ROUTE_1,                       10, 18 ; $0D
	map_const ROUTE_2,                       10, 36 ; $0E
	map_const ROUTE_3,                       35,  9 ; $0F
	map_const ROUTE_4,                       45, 19 ; $10 ; edited
	map_const ROUTE_5,                       20, 18 ; $11 ; edited
	map_const ROUTE_6,                       10, 18 ; $12
	map_const ROUTE_7,                       10,  9 ; $13
	map_const ROUTE_8,                       30,  9 ; $14
	map_const ROUTE_9,                       30,  9 ; $15
	map_const ROUTE_10,                      10, 36 ; $16
	map_const ROUTE_11,                      30, 11 ; $17 ; edited
	map_const ROUTE_12,                      10, 54 ; $18
	map_const ROUTE_13,                      25,  9 ; $19 ; edited
	map_const ROUTE_14,                      10, 22 ; $1A ; edited
	map_const ROUTE_15,                      30,  9 ; $1B
	map_const ROUTE_16,                      20,  9 ; $1C
	map_const ROUTE_17,                      10, 72 ; $1D
	map_const ROUTE_18,                      25,  9 ; $1E
	map_const ROUTE_19,                      10, 27 ; $1F
	map_const ROUTE_20,                      50,  9 ; $20
	map_const ROUTE_21,                      10, 45 ; $21
	map_const ROUTE_22,                      20, 11 ; $22
	map_const ROUTE_23,                      10, 72 ; $23
	map_const ROUTE_24,                      10, 18 ; $24
	map_const ROUTE_25,                      30, 26 ; $25, edited
	map_const ROUTE_26,                      30, 30 ; $26
	map_const ROUTE_27,                      11, 15 ; $27
	map_const ROUTE_28,                      12,  9 ; $28
	map_const ROUTE_29,                      14, 32 ; $29
	map_const ROUTE_30,                      20,  8 ; $2A
	map_const LAKE_OF_MIST,                  25, 25 ; $2B ; new
DEF FIRST_INDOOR_MAP EQU const_value
	map_const REDS_HOUSE_1F,                  4,  5 ; $2C ; edited
	map_const REDS_HOUSE_2F,                  4,  4 ; $2D
	map_const BLUES_HOUSE,                   11,  4 ; $2E ; edited
	map_const OAKS_LAB,                       5,  6 ; $2F
	map_const VIRIDIAN_POKECENTER,            7,  4 ; $30
	map_const VIRIDIAN_MART,                  4,  4 ; $31
	map_const VIRIDIAN_SCHOOL_HOUSE,          5,  4 ; $32
	map_const VIRIDIAN_NICKNAME_HOUSE,       11,  4 ; $33 ; edited
	map_const VIRIDIAN_GYM,                  10,  9 ; $34
	map_const DIGLETTS_CAVE_ROUTE_2,          4,  4 ; $35
	map_const HAUNTED_REDS_HOUSE,            11,  5 ; $36 ; new
	map_const ROUTE_2_TRADE_HOUSE,            4,  4 ; $37
	map_const ROUTE_2_ALL_GATES,             28,  4 ; $38 ; new, merge of all Route 2 gates
	map_const HAUNTED_PALLET_TOWN,           14, 13 ; $39 ; new
	map_const VIRIDIAN_FOREST,               17, 24 ; $3A
	map_const MUSEUM_1F,                     10,  4 ; $3B
	map_const MUSEUM_2F,                      7,  4 ; $3C
	map_const PEWTER_GYM,                     5,  7 ; $3D
	map_const ROUTE_21_DIVE,                 10, 45 ; $3E ; new
	map_const PEWTER_HOUSES,                 18,  4 ; $3F ; edited
	map_const PEWTER_POKECENTER,             14,  4 ; $40 ; edited, Center+Mart
	map_const MT_MOON_1F,                    30, 30 ; $41 ; edited
	map_const MT_MOON_B1F,                   30, 30 ; $42 ; edited
	map_const MT_MOON_B2F,                   30, 30 ; $43 ; edited
	map_const SUNKEN_SHIP_1F,                20, 40 ; $44 ; new
	map_const CERULEAN_MELANIES_HOUSE,       39,  4 ; $45 ; edited, enlarged for more houses
	map_const CERULEAN_POKECENTER,           14,  4 ; $46 ; edited, Center+Mart
	map_const CERULEAN_GYM,                   5,  7 ; $47
	map_const BIKE_SHOP,                      4,  4 ; $48
	map_const PIKACHU_GROTTO,                11, 11 ; $49 ; new
	map_const MT_MOON_POKECENTER,             7,  4 ; $4A
	map_const ONIX_BURROWING,                26, 26 ; $4B ; new, was a copy of the trashed house
	map_const ROUTE_5_GATE,                   4,  3 ; $4C
	map_const UNDERGROUND_PATH_ROUTE_5,       4,  4 ; $4D
	map_const DAYCARE,                        4,  4 ; $4E
	map_const ROUTE_6_GATE,                   4,  3 ; $4F
	map_const UNDERGROUND_PATH_ROUTE_6,       4,  4 ; $50
	map_const SECLUDED_CAVES,                19, 18 ; $51 ; new, was a copy of the underground path route 6
	map_const ROUTE_7_GATE,                   3,  4 ; $52
	map_const UNDERGROUND_PATH_ROUTE_7,       4,  4 ; $53
	map_const OCHRE_HOUSES,                  27,  6 ; $54 ; new, was a copy of the underground path route 7
	map_const ROUTE_8_GATE,                   3,  4 ; $55
	map_const UNDERGROUND_PATH_ROUTE_8,       4,  4 ; $56
	map_const ROCK_TUNNEL_POKECENTER,         7,  4 ; $57
	map_const ROCK_TUNNEL_1F,                20, 18 ; $58
	map_const POWER_PLANT,                   20, 18 ; $59
	map_const ROUTE_11_GATE_1F,               4, 11 ; $5A ; edited because of MERGING
	map_const DIGLETTS_CAVE_ROUTE_11,         4,  4 ; $5B
	map_const SAFFRON_CLIMB_CLUB,            18, 10 ; $5C ; new
	map_const ROUTE_12_GATE_1F,              12,  4 ; $5D ; edited
	map_const BILLS_HOUSE,                    4,  4 ; $5E
	map_const VERMILION_POKECENTER,          14,  4 ; $5F ; edited, Center+Mart
	map_const POKEMON_FAN_CLUB,               4,  4 ; $60
	map_const BATTLE_FACILITY,               15,  4 ; $61 ; mew
	map_const VERMILION_GYM,                  5,  9 ; $62
	map_const VERMILION_HOUSES,              18,  4 ; $63 ; new, merge of all Vermilion houses
	map_const VERMILION_DOCK,                14,  6 ; $64
	map_const SS_ANNE_1F,                    20,  9 ; $65
	map_const SS_ANNE_2F,                    20,  9 ; $66
	map_const SS_ANNE_3F,                    10,  3 ; $67
	map_const SS_ANNE_B1F,                   15,  4 ; $68
	map_const SS_ANNE_BOW,                   10,  7 ; $69
	map_const SS_ANNE_KITCHEN,                7,  8 ; $6A
	map_const SS_ANNE_CAPTAINS_ROOM,          3,  4 ; $6B
	map_const SS_ANNE_1F_ROOMS,              12,  8 ; $6C
	map_const SS_ANNE_2F_ROOMS,              12,  8 ; $6D
	map_const SS_ANNE_B1F_ROOMS,             12,  8 ; $6E
	map_const OCHRE_GYM,                     15, 17 ; $6F ; new
	map_const OCHRE_WONDERLAND,              30, 30 ; $70 ; new
	map_const OCHRE_RESEARCH_CENTER_1,        6, 16 ; $71 ; new
	map_const VICTORY_ROAD_1F,               10,  9 ; $72
	map_const SECLUDED_ATOLL_NW,             27, 15 ; $73 ; new
	map_const SECLUDED_ATOLL_NE,             15, 15 ; $74 ; new
	map_const SECLUDED_ATOLL_SE,             15, 24 ; $75 ; new
	map_const SECLUDED_ATOLL_SW,             27, 24 ; $76 ; new
	map_const LANCES_ROOM,                   13, 13 ; $77
	map_const OBSIDIAN_WOOD,                 24, 24 ; $78 ; new
	map_const OBSIDIAN_WAREHOUSE,            30, 22 ; $79 ; new
	map_const OBSIDIAN_WAREHOUSE_FINAL,       6, 11 ; $7A ; new
	map_const OBSIDIAN_MINES,                30, 30 ; $7B ; new
	map_const HALL_OF_FAME,                   5,  4 ; $7C
	map_const UNDERGROUND_PATH_NORTH_SOUTH,   4, 24 ; $7D ; UndergroundPathNorthSouth.blk is actually 4x23
	map_const CHAMPIONS_ROOM,                 4,  4 ; $7E
	map_const UNDERGROUND_PATH_WEST_EAST,    25,  4 ; $7F
	map_const CELADON_MART_1F,               10,  4 ; $80
	map_const CELADON_MART_2F,               10,  4 ; $81
	map_const CELADON_MART_3F,               10,  4 ; $82
	map_const CELADON_MART_4F,               10,  4 ; $83
	map_const CELADON_MART_ROOF,             10,  4 ; $84
	map_const CELADON_MART_ELEVATOR,          2,  2 ; $85
	map_const CELADON_MANSION_1F,            11,  6 ; $86 ; edited for MERGING
	map_const CELADON_MANSION_2F,             5,  6 ; $87 ; edited, enlarged to host the pret meetup
	map_const ROUTE_19_DIVE,                 10, 27 ; $88 ; new
	map_const CELADON_MANSION_ROOF,           4,  6 ; $89
	map_const CELADON_MANSION_ROOF_HOUSE,     4,  4 ; $8A
	map_const CELADON_POKECENTER,             7,  4 ; $8B
	map_const CELADON_GYM,                    5,  9 ; $8C
	map_const GAME_CORNER,                   10,  9 ; $8D
	map_const CELADON_MART_5F,               10,  4 ; $8E
	map_const GAME_CORNER_PRIZE_ROOM,         5,  4 ; $8F
	map_const CELADON_DINER,                  5,  4 ; $90
	map_const CELADON_CHIEF_HOUSE,           14,  7 ; $91 ; edited
	map_const CELADON_HOTEL,                  7,  4 ; $92
	map_const LAVENDER_POKECENTER,           14,  4 ; $93 ; edited, Center+Mart
	map_const POKEMON_TOWER_1F,              10,  9 ; $94
	map_const POKEMON_TOWER_2F,              10,  9 ; $95
	map_const POKEMON_TOWER_3F,              10,  9 ; $96
	map_const POKEMON_TOWER_4F,              10,  9 ; $97
	map_const POKEMON_TOWER_5F,              10,  9 ; $98
	map_const POKEMON_TOWER_6F,              10,  9 ; $99
	map_const POKEMON_TOWER_7F,              10,  9 ; $9A
	map_const LAVENDER_HOUSES,               18,  4 ; $9B ; new, merge of all Lavender houses
	map_const HAUNTED_HOUSE_2,               15, 18 ; $9C ; new
	map_const HAUNTED_HOUSE_3,               30, 30 ; $9D ; new, was LAVENDER_CUBONE_HOUSE
	map_const OCHRE_RESEARCH_CENTER_2,        6, 10 ; $9E ; new
	map_const FUCHSIA_BILLS_GRANDPAS_HOUSE,   4,  4 ; $9F
	map_const FUCHSIA_POKECENTER,            14,  4 ; $A0 ; edited, Center+Mart
	map_const WARDENS_HOUSE,                 13,  4 ; $A1 ; edited
	map_const SAFARI_ZONE_GATE,               4,  3 ; $A2
	map_const FUCHSIA_GYM,                    5,  9 ; $A3
	map_const FUCHSIA_MEETING_ROOM,           7,  4 ; $A4
	map_const SEAFOAM_ISLANDS_B1F,           15,  9 ; $A5
	map_const SEAFOAM_ISLANDS_B2F,           15,  9 ; $A6
	map_const SEAFOAM_ISLANDS_B3F,           15,  9 ; $A7
	map_const SEAFOAM_ISLANDS_B4F,           15,  9 ; $A8
	map_const HAUNTED_HOUSE_4,               30, 30 ; $A9 ; new, was VERMILION_OLD_ROD_HOUSE
	map_const FUCHSIA_GOOD_ROD_HOUSE,         4,  4 ; $AA
	map_const POKEMON_MANSION_1F,            15, 14 ; $AB
	map_const CINNABAR_GYM,                  10,  9 ; $AC
	map_const CINNABAR_LAB,                  51,  4 ; $AD ; edited because of MERGING
	map_const ROUTE_20_DIVE,                 50,  9 ; $AE ; new
	map_const ROUTE_19_DIVE_CAVERN,          11, 10 ; $AF ; new
	map_const ROUTE_21_DIVE_CAVERN,          30, 30 ; $B0 ; new
	map_const CINNABAR_POKECENTER,           14,  4 ; $B1 ; edited, Center+Mart
	map_const HAUNTED_ISLAND_OF_NUMBERS,     30, 30 ; $B2 ; new, was CINNABAR_MART
	map_const OBSIDIAN_HOUSES,               18,  4 ; $B3, new
	map_const INDIGO_PLATEAU_LOBBY,           8,  6 ; $B4
	map_const COPYCATS_HOUSE_1F,             11,  4 ; $B5 ; edited because of MERGING
	map_const FIGHTING_DOJO,                  7,  8 ; $B6
	map_const SAFFRON_GYM,                   10,  9 ; $B7
	map_const SAFARI_ZONE_EXTRA,             20, 18 ; $B8 ; new
	map_const CELADON_HOTEL_HALL,            10,  2 ; $B9 ; new, was SAFFRON_MART
	map_const SILPH_CO_1F,                   15,  9 ; $BA
	map_const SAFFRON_POKECENTER,            14,  4 ; $BB ; edited, Center+Mart
	map_const MR_PSYCHICS_HOUSE,             11,  4 ; $BC ; edited for MERGING
	map_const ROUTE_15_GATE_1F,               4, 11 ; $BD ; edited because of MERGING
	map_const FORLORN_VALLEY,                30, 30 ; $BE ; new
	map_const ROUTE_16_GATE_1F,               4, 13 ; $BF ; edited
	map_const SUNKEN_SHIP_ROOMS,             21, 40 ; $C0 ; new
	map_const ROUTE_16_FLY_HOUSE,             4,  4 ; $C1
	map_const ROUTE_12_SUPER_ROD_HOUSE,       4,  4 ; $C2
	map_const ROUTE_18_GATE_1F,               4, 11 ; $C3 ; edited because of MERGING
	map_const ROUTE_18_GATE_2F,               4,  4 ; $C4 ; UNUSED
	map_const SEAFOAM_ISLANDS_1F,            15,  9 ; $C5
	map_const ROUTE_22_GATE,                  5,  4 ; $C6
	map_const VICTORY_ROAD_2F,               15,  9 ; $C7
	map_const ROUTE_12_GATE_2F,               4,  4 ; $C8 ; UNUSED
	map_const CELADON_HOTEL_ROOMS,           29,  4 ; $C9 ; new, was VERMILION_TRADE_HOUSE
	map_const DIGLETTS_CAVE,                 20, 18 ; $CA
	map_const VICTORY_ROAD_3F,               15,  9 ; $CB
	map_const ROCKET_HIDEOUT_B1F,            15, 14 ; $CC
	map_const ROCKET_HIDEOUT_B2F,            15, 14 ; $CD
	map_const ROCKET_HIDEOUT_B3F,            15, 14 ; $CE
	map_const ROCKET_HIDEOUT_B4F,            15, 12 ; $CF
	map_const ROCKET_HIDEOUT_ELEVATOR,        3,  4 ; $D0
	map_const OCHRE_REHABILITATION_CENTER,   20,  4 ; $D1, new
	map_const OCHRE_POKECENTER,              14,  4 ; $D2, new, Center+Mart
	map_const OBSIDIAN_POKECENTER,           14,  4 ; $D3, new, Center+Mart
	map_const SILPH_CO_2F,                   15,  9 ; $D4
	map_const SILPH_CO_3F,                   15,  9 ; $D5
	map_const SILPH_CO_4F,                   15,  9 ; $D6
	map_const SILPH_CO_5F,                   15,  9 ; $D7
	map_const SILPH_CO_6F,                   13,  9 ; $D8
	map_const SILPH_CO_7F,                   13,  9 ; $D9
	map_const SILPH_CO_8F,                   13,  9 ; $DA
	map_const POKEMON_MANSION_2F,            15, 14 ; $DB
	map_const POKEMON_MANSION_3F,            15,  9 ; $DC
	map_const POKEMON_MANSION_B1F,           15, 14 ; $D8
	map_const SAFARI_ZONE_EAST,              15, 13 ; $D9
	map_const SAFARI_ZONE_NORTH,             20, 18 ; $E0
	map_const SAFARI_ZONE_WEST,              15, 13 ; $E1
	map_const SAFARI_ZONE_CENTER,            15, 13 ; $E2
	map_const SAFARI_ZONE_QUADRUPLE_REST_HOUSE, 25,  4 ; $E3 ; edited because of MERGING
	map_const SAFARI_ZONE_SECRET_HOUSE,       4,  4 ; $E4
	map_const HAUNTED_HOUSE_1,               30, 30 ; $E5 ; new
	map_const SAFARI_ZONE_EAST_REST_HOUSE,    4,  4 ; $E6 ; edited, made UNUSED because of map MERGING
	map_const CERULEAN_CAVE_2F,              15,  9 ; $E7
	map_const CERULEAN_CAVE_B1F,             15,  9 ; $E8
	map_const CERULEAN_CAVE_1F,              15,  9 ; $E9
	map_const NAME_RATERS_HOUSE,              4,  4 ; $EA ; edited, made UNUSED because of map MERGING
	map_const CERULEAN_BADGE_HOUSE,           4,  4 ; $EB
	map_const CELADON_UNIVERSITY_1,          10, 15 ; $EC, new
	map_const CELADON_UNIVERSITY_2,          25, 17 ; $ED, new
	map_const ROCK_TUNNEL_B1F,               20, 18 ; $EE
	map_const SILPH_CO_9F,                   13,  9 ; $EF
	map_const SILPH_CO_10F,                   8,  9 ; $F0
	map_const SILPH_CO_11F,                   9,  9 ; $F1
	map_const SILPH_CO_ELEVATOR,              2,  2 ; $F2
	map_const CINNABAR_VOLCANO,              21, 21 ; $F3, new
	map_const CINNABAR_VOLCANO_BF,           12, 13 ; $F4, new
	map_const TRADE_CENTER,                   5,  4 ; $F5
	map_const COLOSSEUM,                      5,  4 ; $F6
	map_const CERULEAN_CAVE_EXTRA_TOP,       21, 21 ; $F7 ; edited
	map_const CERULEAN_CAVE_EXTRA_MIDDLE,    21, 21 ; $F8 ; edited
	map_const CERULEAN_CAVE_EXTRA_BOTTOM,    21, 21 ; $F9 ; edited
	map_const CERULEAN_CAVE_EXTRA_FINAL,     30, 30 ; $FA ; edited, final Labyrinth
	map_const LORELEIS_ROOM,                  5,  6 ; $FB
	map_const BRUNOS_ROOM,                    5,  6 ; $FC
	map_const AGATHAS_ROOM,                   5,  6 ; $FD
	map_const SUMMER_BEACH_HOUSE,             7,  4 ; $FE
DEF NUM_MAPS EQU const_value

; Indoor maps, such as houses, use this as the Map ID in their exit warps
; This map ID takes the player back to the last outdoor map they were on, stored in wLastMap
DEF LAST_MAP EQU -1
