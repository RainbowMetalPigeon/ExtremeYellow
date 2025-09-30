HiddenObjectMaps_Sevii:
; cities
	dbw SEVII_ONE_ISLAND_CITY,                           SeviiOneIslandCityHiddenObjects
	dbw SEVII_TWO_ISLAND_CITY,                           SeviiTwoIslandCityHiddenObjects
	dbw SEVII_THREE_ISLAND_CITY,                         SeviiThreeIslandCityHiddenObjects ; TBE
	dbw SEVII_FOUR_ISLAND_CITY,                          SeviiFourIslandCityHiddenObjects ; TBE
	dbw SEVII_FIVE_ISLAND_CITY,                          SeviiFiveIslandCityHiddenObjects ; TBE
	dbw SEVII_SIX_ISLAND_CITY,                           SeviiSixeIslandCityHiddenObjects ; TBE
	dbw SEVII_SEVEN_ISLAND_CITY,                         SeviiSevenIslandCityHiddenObjects ; TBE
; routes
	dbw SEVII_ROUTE_31,                                  SeviiRoute31HiddenObjects ; TBE
	dbw SEVII_ROUTE_32,                                  SeviiRoute32HiddenObjects ; TBE
	dbw SEVII_ROUTE_33,                                  SeviiRoute33HiddenObjects
; indoors
; 1-island
	dbw SEVII_ONE_ISLAND_DOCK,                           SeviiOneIslandDockHiddenObjects ; TBE
	dbw SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART,        SeviiOneIslandPokemonCenterAndMartHiddenObjects
	dbw SEVII_ONE_ISLAND_GYM_1,                          SeviiOneIslandGym1HiddenObjects
; 2-island
	dbw SEVII_TWO_ISLAND_POKEMON_CENTER,                 SeviiTwoIslandPokemonCenterAndMartHiddenObjects
	dbw SEVII_TWO_ISLAND_GYM,                            SeviiTwoIslandGymHiddenObjects
; 3-island
	dbw SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART,      SeviiThreeIslandPokemonCenterAndMartHiddenObjects
; 4-island
	dbw SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART,       SeviiFourIslandPokemonCenterAndMartHiddenObjects
; 5-island
	dbw SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART,       SeviiFiveIslandPokemonCenterAndMartHiddenObjects
; 6-island
	dbw SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART,        SeviiSixIslandPokemonCenterAndMartHiddenObjects
	dbw SEVII_SIX_ISLAND_GYM_1,                          SeviiSixIslandGym1HiddenObjects
; 7-island
	dbw SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART,      SeviiSevenIslandPokemonCenterAndMartHiddenObjects
	dbw SEVII_SEVEN_ISLAND_GYM_1,                        SeviiSevenIslandGym1HiddenObjects
	
	db -1 ; end

;MACRO hidden_object
;	db \2 ; y coord
;	db \1 ; x coord
;	db \3 ; item id
;	dba \4 ; object routine
;ENDM

;MACRO hidden_text_predef
;	db \2 ; y coord
;	db \1 ; x coord
;	db_tx_pre \3 ; text id
;	dba \4 ; object routine
;ENDM

; Some hidden objects use SPRITE_FACING_* values,
; but these do not actually prevent the player
; from interacting with them in any direction.
;DEF ANY_FACING EQU $d0

SeviiRoute33HiddenObjects:
	hidden_object 80, 10, IRON, HiddenItems
	hidden_object 69,  6, ETHER, HiddenItems
	hidden_object 56,  5, RARE_CANDY, HiddenItems
	hidden_object 95, 22, NUGGET, HiddenItems
	db -1 ; end

SeviiOneIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiTwoIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiThreeIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiFourIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiFiveIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiSixIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiSevenIslandPokemonCenterAndMartHiddenObjects:
	hidden_object  7,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiOneIslandGym1HiddenObjects:
	hidden_object  0,  1, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiTwoIslandGymHiddenObjects:
	hidden_object  0, 13, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiSixIslandGym1HiddenObjects:
	hidden_object  0,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

SeviiSevenIslandGym1HiddenObjects:
	hidden_object  0,  1, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1

; TBE --------------------------------------------------------------------

SeviiOneIslandCityHiddenObjects:
	hidden_object  6,  6, MAX_ELIXER, HiddenItems
	hidden_object 19,  5, FULL_RESTORE, HiddenItems
	hidden_object  3, 32, IRON, HiddenItems
	db -1 ; end

SeviiTwoIslandCityHiddenObjects:
	hidden_object 31, 16, MAX_ETHER, HiddenItems
	hidden_object 36,  8, PP_UP, HiddenItems
	db -1 ; end

SeviiThreeIslandCityHiddenObjects:
	hidden_object  0,  1, SPRITE_FACING_UP, OpenRedsPC
	hidden_object  3,  5, ANY_FACING, PrintRedSNESText
	db -1 ; end

SeviiFourIslandCityHiddenObjects:
	hidden_object  1,  4, SPRITE_FACING_UP, BillsHousePC
	db -1 ; end

SeviiFiveIslandCityHiddenObjects:
	hidden_object  0,  4, SPRITE_FACING_LEFT, PrintBenchGuyText
	hidden_object 13,  3, SPRITE_FACING_UP, OpenPokemonCenterPC
	db -1 ; end

SeviiSixeIslandCityHiddenObjects:
	hidden_object 13,  5, SPRITE_FACING_DOWN, PrintTrashText
	hidden_object 13,  7, SPRITE_FACING_DOWN, PrintTrashText
	hidden_object 13,  9, GREAT_BALL, HiddenItems
	db -1 ; end

SeviiSevenIslandCityHiddenObjects:
	hidden_object 12,  3, ELIXER, HiddenItems
	db -1 ; end

SeviiRoute31HiddenObjects:
	hidden_object 12,  3, ELIXER, HiddenItems
	db -1 ; end

SeviiRoute32HiddenObjects:
	hidden_object 16, 33, POKE_BALL, HiddenItems
	hidden_object 10, 34, POTION, HiddenItems
	hidden_object 14, 32, FIRE_STONE, HiddenItems
	db -1 ; end

SeviiOneIslandDockHiddenObjects:
	hidden_object 15, 15, ELIXER, HiddenItems
	db -1 ; end
