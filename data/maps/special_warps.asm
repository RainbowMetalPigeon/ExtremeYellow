; Format: (size 2 bytes)
; 00: target map ID
; 01: which dungeon warp in the source map was used
DungeonWarpList:
	db SEAFOAM_ISLANDS_B1F, 1
	db SEAFOAM_ISLANDS_B1F, 2
	db SEAFOAM_ISLANDS_B2F, 1
	db SEAFOAM_ISLANDS_B2F, 2
	db SEAFOAM_ISLANDS_B3F, 1
	db SEAFOAM_ISLANDS_B3F, 2
	db SEAFOAM_ISLANDS_B4F, 1
	db SEAFOAM_ISLANDS_B4F, 2
	db VICTORY_ROAD_2F,     2
	db POKEMON_MANSION_1F,  1
	db POKEMON_MANSION_1F,  2
	db POKEMON_MANSION_2F,  3
	db CERULEAN_CAVE_EXTRA_BOTTOM,  1 ; new
	db CERULEAN_CAVE_EXTRA_BOTTOM,  2 ; new
	db CERULEAN_CAVE_EXTRA_MIDDLE,  1 ; new
	db CERULEAN_CAVE_EXTRA_MIDDLE,  2 ; new
	db CERULEAN_CAVE_EXTRA_MIDDLE,  3 ; new
	db CERULEAN_CAVE_EXTRA_MIDDLE,  4 ; new
	db -1 ; end

MACRO fly_warp
	event_displacement \1_WIDTH, \2, \3
	db ((\3) & $01) ;sub-block Y
	db ((\2) & $01) ;sub-block X
ENDM

DungeonWarpData:
	fly_warp SEAFOAM_ISLANDS_B1F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B1F, 23,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 22,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B4F,  4, 14
	fly_warp SEAFOAM_ISLANDS_B4F,  5, 14
	fly_warp VICTORY_ROAD_2F,     22, 16
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_2F,  18, 14
	fly_warp CERULEAN_CAVE_EXTRA_BOTTOM,  7,  7 ; new
	fly_warp CERULEAN_CAVE_EXTRA_BOTTOM, 39, 39 ; new
	fly_warp CERULEAN_CAVE_EXTRA_MIDDLE, 21, 20 ; new
	fly_warp CERULEAN_CAVE_EXTRA_MIDDLE, 20, 36 ; new
	fly_warp CERULEAN_CAVE_EXTRA_MIDDLE,  7, 40 ; new
	fly_warp CERULEAN_CAVE_EXTRA_MIDDLE,  2, 39 ; new


MACRO special_warp_spec
	db \1
	fly_warp \1, \2, \3
	db \4
ENDM

FirstMapSpec:
	special_warp_spec REDS_HOUSE_2F, 3, 6, REDS_HOUSE_2
TradeCenterSpec1:
	special_warp_spec TRADE_CENTER,  3, 4, CLUB
TradeCenterSpec2:
	special_warp_spec TRADE_CENTER,  6, 4, CLUB
ColosseumSpec1:
	special_warp_spec COLOSSEUM,     3, 4, CLUB
ColosseumSpec2:
	special_warp_spec COLOSSEUM,     6, 4, CLUB
; new for sevii
SeviiSpec1:
	special_warp_spec SEVII_ONE_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec2:
	special_warp_spec SEVII_TWO_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec3:
	special_warp_spec SEVII_THREE_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec4:
	special_warp_spec SEVII_FOUR_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec5:
	special_warp_spec SEVII_FIVE_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec6:
	special_warp_spec SEVII_SIX_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec7:
	special_warp_spec SEVII_SEVEN_ISLAND_DOCK, 10, 4, SHIP_PORT
SeviiSpec8:
	special_warp_spec SEVII_EIGHT_ISLAND_DOCK, 10, 4, SHIP_PORT
KantoSpec:
	special_warp_spec VERMILION_DOCK, 14, 2, SHIP_PORT


MACRO fly_warp_spec
	db \1, 0
	dw \2
ENDM

FlyWarpDataPtr:
	fly_warp_spec PALLET_TOWN,     .PalletTown
	fly_warp_spec VIRIDIAN_CITY,   .ViridianCity
	fly_warp_spec PEWTER_CITY,     .PewterCity
	fly_warp_spec CERULEAN_CITY,   .CeruleanCity
	fly_warp_spec LAVENDER_TOWN,   .LavenderTown
	fly_warp_spec VERMILION_CITY,  .VermilionCity
	fly_warp_spec CELADON_CITY,    .CeladonCity
	fly_warp_spec OCHRE_CITY,      .OchreCity			; new
	fly_warp_spec FUCHSIA_CITY,    .FuchsiaCity
	fly_warp_spec OBSIDIAN_ISLAND, .ObsidianIsland		; new
	fly_warp_spec CINNABAR_ISLAND, .CinnabarIsland
	fly_warp_spec INDIGO_PLATEAU,  .IndigoPlateau
	fly_warp_spec SAFFRON_CITY,    .SaffronCity
	fly_warp_spec ROUTE_4,         .Route4
	fly_warp_spec ROUTE_10,        .Route10
	fly_warp_spec FORLORN_VALLEY,  .ForlornValley ; new

.PalletTown:     fly_warp PALLET_TOWN,      5,  6
.ViridianCity:   fly_warp VIRIDIAN_CITY,   23, 26
.PewterCity:     fly_warp PEWTER_CITY,     13, 26
.CeruleanCity:   fly_warp CERULEAN_CITY,   19, 18
.LavenderTown:   fly_warp LAVENDER_TOWN,    3,  6
.VermilionCity:  fly_warp VERMILION_CITY,  11,  4
.CeladonCity:    fly_warp CELADON_CITY,    41, 24		; edited
.OchreCity:      fly_warp OCHRE_CITY,      35, 12		; new
.FuchsiaCity:    fly_warp FUCHSIA_CITY,    19, 28
.ObsidianIsland: fly_warp OBSIDIAN_ISLAND, 35,  6		; new
.CinnabarIsland: fly_warp CINNABAR_ISLAND, 41, 12		; edited
.IndigoPlateau:  fly_warp INDIGO_PLATEAU,   9,  6
.SaffronCity:    fly_warp SAFFRON_CITY,     9, 30
.Route4:         fly_warp ROUTE_4,         11, 26       ; edited
.Route10:        fly_warp ROUTE_10,        11, 20
.ForlornValley:  fly_warp FORLORN_VALLEY,  28, 28		; new

; --------------------------- new for sevii ----------------------------

DungeonWarpList_Sevii:
	db -1 ; end

DungeonWarpData_Sevii:
	db -1 ; end
	
FlyWarpDataPtr_Sevii:
	fly_warp_spec SEVII_ONE_ISLAND_CITY,     .SeviiOneIslandCity
	fly_warp_spec SEVII_TWO_ISLAND_CITY,     .SeviiTwoIslandCity
	fly_warp_spec SEVII_THREE_ISLAND_CITY,   .SeviiThreeIslandCity
	fly_warp_spec SEVII_FOUR_ISLAND_CITY,    .SeviiFourIslandCity
	fly_warp_spec SEVII_FIVE_ISLAND_CITY,    .SeviiFiveIslandCity
	fly_warp_spec SEVII_SIX_ISLAND_CITY,     .SeviiSixIslandCity
	fly_warp_spec SEVII_SEVEN_ISLAND_CITY,   .SeviiSevenIslandCity
	fly_warp_spec SEVII_DESOLATED_ROCK,      .SeviiDesolatedRock

.SeviiOneIslandCity:    fly_warp SEVII_ONE_ISLAND_CITY,    21, 22
.SeviiTwoIslandCity:    fly_warp SEVII_TWO_ISLAND_CITY,    15, 30
.SeviiThreeIslandCity:  fly_warp SEVII_THREE_ISLAND_CITY,  15, 24
.SeviiFourIslandCity:   fly_warp SEVII_FOUR_ISLAND_CITY,   13, 18
.SeviiFiveIslandCity:   fly_warp SEVII_FIVE_ISLAND_CITY,   13, 14
.SeviiSixIslandCity:    fly_warp SEVII_SIX_ISLAND_CITY,     5,  6
.SeviiSevenIslandCity:  fly_warp SEVII_SEVEN_ISLAND_CITY,  13,  4
.SeviiDesolatedRock:    fly_warp SEVII_DESOLATED_ROCK,     16, 13
