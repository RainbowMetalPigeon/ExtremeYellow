MACRO hidden_item
	db \1, \3, \2
ENDM

HiddenItemCoords:
	; map id, x, y
	hidden_item SILPH_CO_5F,                   12,   3
	hidden_item VIRIDIAN_CITY,                 13,   4 ; edited, and moved in second position
	hidden_item SILPH_CO_9F,                    2,  15
	hidden_item POKEMON_MANSION_3F,             1,   9
	hidden_item POKEMON_MANSION_B1F,            1,   9
	hidden_item SAFARI_ZONE_WEST,               6,   5
	hidden_item CERULEAN_CAVE_2F,              16,  13
	hidden_item CERULEAN_CAVE_B1F,              8,  14
;	hidden_item UNUSED_MAP_6F,                 14,  11 ; edited, commented away because using the map for else
	hidden_item SEAFOAM_ISLANDS_B2F,           15,  15
	hidden_item SEAFOAM_ISLANDS_B3F,            9,  16
	hidden_item SEAFOAM_ISLANDS_B4F,           25,  17
	hidden_item VIRIDIAN_FOREST,                1,  18
	hidden_item VIRIDIAN_FOREST,               16,  42
	hidden_item MT_MOON_B2F,                   18,  36 ; edited, +24 on the y coordinate
	hidden_item MT_MOON_B2F,                   33,  33 ; edited, +24 on the y coordinate
	hidden_item SS_ANNE_B1F_ROOMS,              3,   1
	hidden_item SS_ANNE_KITCHEN,               13,   9
	hidden_item UNDERGROUND_PATH_NORTH_SOUTH,   3,   4
	hidden_item UNDERGROUND_PATH_NORTH_SOUTH,   4,  34
	hidden_item UNDERGROUND_PATH_WEST_EAST,    12,   2
	hidden_item UNDERGROUND_PATH_WEST_EAST,    21,   5
	hidden_item ROCKET_HIDEOUT_B1F,            21,  15
	hidden_item ROCKET_HIDEOUT_B3F,            27,  17
	hidden_item ROCKET_HIDEOUT_B4F,            25,   1
	hidden_item ROUTE_10,                       9,  17
	hidden_item ROUTE_10,                      16,  53
	hidden_item POWER_PLANT,                   17,  16
	hidden_item POWER_PLANT,                   12,   1
	hidden_item POWER_PLANT,                   28,   2 ; new
	hidden_item ROUTE_11,                      48,   5
	hidden_item ROUTE_12,                       2,  63
	hidden_item ROUTE_13,                      13,   6 ; edited
	hidden_item ROUTE_13,                       1,   4 ; edited
	hidden_item ROUTE_14,                      15,   8 ; new
	hidden_item ROUTE_14,                      14,   9 ; new
	hidden_item ROUTE_14,                      15,  38 ; new
	hidden_item ROUTE_17,                      15,  14
	hidden_item ROUTE_17,                       8,  45
	hidden_item ROUTE_17,                      17,  72
	hidden_item ROUTE_17,                       4,  91
	hidden_item ROUTE_17,                       8, 121
	hidden_item ROUTE_23,                       9,  44
	hidden_item ROUTE_23,                      19,  70
	hidden_item ROUTE_23,                       8,  90
	hidden_item VICTORY_ROAD_2F,                5,   2
	hidden_item VICTORY_ROAD_2F,               26,   7
	hidden_item ROUTE_25,                      38,  37 ; edited, +34 in y
	hidden_item ROUTE_25,                      10,  35 ; edited, +34 in y
	hidden_item ROUTE_4,                       38,   3 ; edited
	hidden_item ROUTE_9,                       14,   7
	hidden_item COPYCATS_HOUSE_2F,              1,   1
	hidden_item CERULEAN_CITY,                 15,   8
	hidden_item CERULEAN_CAVE_1F,              18,   7
	hidden_item POKEMON_TOWER_5F,               4,  12
	hidden_item VERMILION_CITY,                14,  11
	hidden_item CELADON_CITY,                  48,  29 ; edited, +14 on the y coordinate
	hidden_item SAFARI_ZONE_GATE,              10,   1 ; inaccessible
	hidden_item POKEMON_MANSION_1F,             8,  16
	hidden_item OBSIDIAN_WAREHOUSE,            35,  25 ; new
	hidden_item OBSIDIAN_WAREHOUSE,            42,  26 ; new
	hidden_item OBSIDIAN_MINES,                24,  30 ; new, MEGA_STONE_X
	hidden_item OBSIDIAN_MINES,                 5,  57 ; new, IRON
	hidden_item OBSIDIAN_MINES,                19,  56 ; new, CALCIUM
	hidden_item OBSIDIAN_MINES,                49,  58 ; new, NUGGET
	hidden_item OBSIDIAN_MINES,                 3,   2 ; new, KINGS_ROCK
	hidden_item OBSIDIAN_MINES,                 8,  18 ; new, METAL_COAT
	hidden_item OCHRE_WONDERLAND,              56,  21 ; new, MEGA_STONE_Y
	hidden_item PALLET_TOWN,                    5,  11 ; new, MEGA_STONE_X
	hidden_item SECLUDED_ATOLL_SW,             42,  16 ; new, MEGA_STONE_Y
	hidden_item OBSIDIAN_WOOD,                 40,  42 ; new
	hidden_item OBSIDIAN_WOOD,                 29,  45 ; new
	hidden_item CINNABAR_ISLAND,               19,  12 ; new, MEGA_STONE_Y
	hidden_item ROUTE_3,                       20,   9 ; new
	hidden_item ROUTE_4,                        6,  24 ; new
	hidden_item POKEMON_TOWER_6F,              12,  16 ; new
	db -1 ; end
