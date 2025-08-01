HiddenObjectMaps_Sevii:
; cities
	dbw SEVII_ONE_ISLAND_CITY,        SeviiOneIslandCityHiddenObjects ; TBE
	dbw SEVII_TWO_ISLAND_CITY,        SeviiTwoIslandCityHiddenObjects ; TBE
	dbw SEVII_THREE_ISLAND_CITY,      SeviiThreeIslandCityHiddenObjects ; TBE
	dbw SEVII_FOUR_ISLAND_CITY,       SeviiFourIslandCityHiddenObjects ; TBE
	dbw SEVII_FIVE_ISLAND_CITY,       SeviiFiveIslandCityHiddenObjects ; TBE
	dbw SEVII_SIX_ISLAND_CITY,        SeviiSixeIslandCityHiddenObjects ; TBE
	dbw SEVII_SEVEN_ISLAND_CITY,      SeviiSevenIslandCityHiddenObjects ; TBE
; routes
	dbw SEVII_ROUTE_31,               SeviiRoute31HiddenObjects ; TBE
	dbw SEVII_ROUTE_32,               SeviiRoute32HiddenObjects ; TBE
	dbw SEVII_ROUTE_33,               SeviiRoute33HiddenObjects
; indoors
	dbw SEVII_ONE_ISLAND_DOCK,        SeviiOneIslandDockHiddenObjects ; TBE
	
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
	hidden_object 99, 23, NUGGET, HiddenItems
	db -1 ; end

; TBE --------------------------------------------------------------------

SeviiOneIslandCityHiddenObjects:
	hidden_object 15, 15, ELIXER, HiddenItems
	hidden_object  4,  0, SPRITE_FACING_UP, DisplayOakLabLeftPoster
	hidden_object  5,  0, SPRITE_FACING_UP, DisplayOakLabRightPoster
	hidden_object  0,  1, SPRITE_FACING_UP, DisplayOakLabEmailText
	hidden_object  1,  1, SPRITE_FACING_UP, DisplayOakLabEmailText
	db -1 ; end

SeviiTwoIslandCityHiddenObjects:
	hidden_object  0,  1, SPRITE_FACING_UP, PrintBookcaseText
	hidden_object  1,  1, SPRITE_FACING_UP, PrintBookcaseText
	hidden_object  7,  1, SPRITE_FACING_UP, PrintBookcaseText
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
