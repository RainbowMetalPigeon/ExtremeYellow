MACRO external_map
	dn \2, \1
	dw \3
ENDM

; the appearance of towns and routes in the town map
ExternalMapEntries:
	table_width 3, ExternalMapEntries
	; x, y, name
	external_map  2, 11, PalletTownName
	external_map  2,  8, ViridianCityName
	external_map  2,  3, PewterCityName
	external_map 10,  2, CeruleanCityName
	external_map 14,  5, LavenderTownName
	external_map 10,  9, VermilionCityName
	external_map  7,  5, CeladonCityName
	external_map 11, 11, OchreCityName ; new, moved
	external_map  8, 13, FuchsiaCityName
	external_map  7,  9, ObsidianIslandName ; new
	external_map  2, 15, CinnabarIslandName
	external_map  0,  2, IndigoPlateauName
	external_map 10,  5, SaffronCityName
	external_map  2, 10, Route1Name
	external_map  2,  6, Route2Name
	external_map  4,  3, Route3Name
	external_map  8,  2, Route4Name
	external_map 10,  3, Route5Name
	external_map 10,  7, Route6Name ; edited, 8->7
	external_map  8,  5, Route7Name
	external_map 12,  5, Route8Name ; edited, 13->12
	external_map 13,  2, Route9Name
	external_map 14,  4, Route10Name
	external_map 12,  9, Route11Name
	external_map 14,  9, Route12Name
	external_map 13, 11, Route13Name
	external_map 11, 12, Route14Name
	external_map 10, 13, Route15Name
	external_map  5,  5, Route16Name
	external_map  4,  8, Route17Name
	external_map  6, 13, Route18Name
	external_map  7, 15, Route19Name ; edited, 6->7
	external_map  4, 15, Route20Name
	external_map  2, 13, Route21Name
	external_map  0,  8, Route22Name
	external_map  0,  6, Route23Name
	external_map 10,  1, Route24Name
	external_map 11,  0, Route25Name
	external_map  2,  1, Route26Name ; new
	external_map  7,  7, Route27Name ; new
	external_map  8,  9, Route28Name ; new
	external_map 11, 15, Route29Name ; new
	external_map  3,  7, Route30Name ; new
	external_map 15,  5, LakeOfMistName ; new
	assert_table_length FIRST_INDOOR_MAP


MACRO internal_map
	db \1 + 1
	dn \3, \2
	dw \4
ENDM

; the appearance of buildings and dungeons in the town map
InternalMapEntries:
	; maximum map id subject to this rule, x, y, name
	internal_map OAKS_LAB,                       2, 11, PalletTownName
	internal_map VIRIDIAN_GYM,                   2,  8, ViridianCityName
	internal_map DIGLETTS_CAVE_ROUTE_2,          2,  6, Route2Name ; edited because of map MERGING
	internal_map HAUNTED_REDS_HOUSE,             2, 11, PalletTownName ; edited because of map MERGING
	internal_map ROUTE_2_ALL_GATES,              2,  6, Route2Name ; edited because of map MERGING
	internal_map HAUNTED_PALLET_TOWN,            2, 11, PalletTownName ; edited because of map MERGING
	internal_map VIRIDIAN_FOREST,                2,  4, ViridianForestName
	internal_map PEWTER_GYM,                     2,  3, PewterCityName
	internal_map ROUTE_21_DIVE,                  2, 13, Route21DiveName ; new
	internal_map PEWTER_POKECENTER,              2,  3, PewterCityName
	internal_map MT_MOON_B2F,                    6,  2, MountMoonName
	internal_map SUNKEN_SHIP_1F,                 2, 13, SunkenShipName ; new
	internal_map BIKE_SHOP,                     10,  2, CeruleanCityName ; edited because of map MERGING
	internal_map PIKACHU_GROTTO,                 3,  7, PikachuGrottoName ; new
	internal_map MT_MOON_POKECENTER,             5,  2, Route4Name
	internal_map ONIX_BURROWING,                 2,  1, Route26Name ; new, testing
	internal_map DAYCARE,                       10,  4, Route5Name
	internal_map UNDERGROUND_PATH_ROUTE_6,      10,  6, Route6Name
	internal_map SECLUDED_CAVES,                15, 15, SecludedAtollName ; new, testing
	internal_map UNDERGROUND_PATH_ROUTE_7,       9,  5, Route7Name
	internal_map OCHRE_HOUSES,                  11, 11, OchreCityName ; new
	internal_map UNDERGROUND_PATH_ROUTE_8,      11,  5, Route8Name
	internal_map ROCK_TUNNEL_1F,                14,  3, RockTunnelName
	internal_map POWER_PLANT,                   15,  3, PowerPlantName
	internal_map DIGLETTS_CAVE_ROUTE_11,        13,  9, Route11Name ; edited because of MERGING
	internal_map SAFFRON_CLIMB_CLUB,            10,  5, SaffronClimbClubName ; new
	internal_map ROUTE_12_GATE_1F,              14,  7, Route12Name
	internal_map BILLS_HOUSE,                   12,  0, SeaCottageName
	internal_map VERMILION_DOCK,                10,  9, VermilionCityName
	internal_map SS_ANNE_B1F_ROOMS,             10, 10, SSAnneName ; edited, x=9->10
	internal_map OCHRE_RESEARCH_CENTER_1,       11, 11, OchreCityName ; new
	internal_map VICTORY_ROAD_1F,                0,  4, VictoryRoadName
	internal_map SECLUDED_ATOLL_SW,             15, 15, SecludedAtollName ; new, not really an internal map but oh well, testing
	internal_map LANCES_ROOM,                    0,  2, PokemonLeagueName
	internal_map OBSIDIAN_MINES,                 7,  9, ObsidianIslandName ; new, testing
	internal_map HALL_OF_FAME,                   0,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_NORTH_SOUTH,  10,  5, UndergroundPathName
	internal_map CHAMPIONS_ROOM,                 0,  2, PokemonLeagueName
	internal_map UNDERGROUND_PATH_WEST_EAST,    10,  5, UndergroundPathName
	internal_map CELADON_MANSION_2F,             7,  5, CeladonCityName ; edited
	internal_map ROUTE_19_DIVE,                  7, 15, Route19DiveName ; new
	internal_map CELADON_HOTEL,                  7,  5, CeladonCityName
	internal_map LAVENDER_POKECENTER,           14,  5, LavenderTownName
	internal_map POKEMON_TOWER_7F,              15,  4, PokemonTowerName
	internal_map LAVENDER_HOUSES,               14,  5, LavenderTownName ; edited
	internal_map OCHRE_RESEARCH_CENTER_2,       11, 11, OchreCityName ; new
	internal_map WARDENS_HOUSE,                  8, 13, FuchsiaCityName
	internal_map SAFARI_ZONE_GATE,               8, 12, SafariZoneName
	internal_map FUCHSIA_MEETING_ROOM,           8, 13, FuchsiaCityName
	internal_map SEAFOAM_ISLANDS_B4F,            5, 15, SeafoamIslandsName
	internal_map FUCHSIA_GOOD_ROD_HOUSE,         8, 13, FuchsiaCityName
	internal_map POKEMON_MANSION_1F,             2, 15, PokemonMansionName
	internal_map CINNABAR_LAB,                   2, 15, CinnabarIslandName ; edited
	internal_map ROUTE_20_DIVE,                  4, 15, Route20DiveName ; new
	internal_map ROUTE_19_DIVE_CAVERN,           7, 15, Route19DiveName ; new
	internal_map ROUTE_21_DIVE_CAVERN,           2, 13, Route21DiveName ; new
	internal_map CINNABAR_POKECENTER,            2, 15, CinnabarIslandName ; edited also because of MERGING
	internal_map OBSIDIAN_HOUSES,                7,  9, ObsidianIslandName ; new
	internal_map INDIGO_PLATEAU_LOBBY,           0,  2, IndigoPlateauName
	internal_map SAFARI_ZONE_EXTRA,              8, 12, SafariZoneName ; new
	internal_map CELADON_HOTEL_HALL,             7,  5, CeladonCityName ; new
	internal_map MR_PSYCHICS_HOUSE,             10,  5, SaffronCityName
	internal_map ROUTE_15_GATE_1F,               9, 13, Route15Name ; edited due to MERGING
	internal_map FORLORN_VALLEY,                12,  7, ForlornValleyName ; new
	internal_map ROUTE_16_FLY_HOUSE,             4,  5, Route16Name
	internal_map ROUTE_12_SUPER_ROD_HOUSE,      14, 10, Route12Name
	internal_map ROUTE_18_GATE_1F,               7, 13, Route18Name ; edited due to MERGING
	internal_map SEAFOAM_ISLANDS_1F,             5, 15, SeafoamIslandsName
	internal_map ROUTE_22_GATE,                  0,  7, Route22Name
	internal_map VICTORY_ROAD_2F,                0,  4, VictoryRoadName
	internal_map CELADON_HOTEL_ROOMS,            7,  5, CeladonCityName ; new
	internal_map DIGLETTS_CAVE,                  3,  4, DiglettsCaveName
	internal_map VICTORY_ROAD_3F,                0,  4, VictoryRoadName
	internal_map ROCKET_HIDEOUT_ELEVATOR,        7,  5, RocketHQName
	internal_map OCHRE_POKECENTER,              11, 11, OchreCityName		; new
	internal_map OBSIDIAN_POKECENTER,           11, 11, ObsidianIslandName	; new
	internal_map SILPH_CO_8F,                   10,  5, SilphCoName
	internal_map POKEMON_MANSION_B1F,            2, 15, PokemonMansionName
	internal_map SAFARI_ZONE_SECRET_HOUSE,       8, 12, SafariZoneName ; edited
	internal_map HAUNTED_HOUSE_1,                0,  0, HauntedHouseName ; new, testing
	internal_map CERULEAN_CAVE_1F,               9,  1, CeruleanCaveName
	internal_map NAME_RATERS_HOUSE,             14,  5, LavenderTownName
	internal_map CERULEAN_BADGE_HOUSE,          10,  2, CeruleanCityName
	internal_map CELADON_UNIVERSITY_2,           7,  5, CeladonCityName ; new
	internal_map ROCK_TUNNEL_B1F,               14,  3, RockTunnelName
	internal_map SILPH_CO_ELEVATOR,             10,  5, SilphCoName
	internal_map CINNABAR_VOLCANO_BF,            2, 15, CinnabarIslandName ; new, testing
	internal_map CERULEAN_CAVE_EXTRA_FINAL,      9,  1, CeruleanCaveName	; new
	internal_map AGATHAS_ROOM,                   0,  2, PokemonLeagueName
	internal_map SUMMER_BEACH_HOUSE,             6, 15, Route19Name
	db -1 ; end
