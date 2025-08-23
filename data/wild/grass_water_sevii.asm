WildDataPointers_Sevii:
	table_width 2, WildDataPointers_Sevii
; cities
	dw NothingWildMons               ; SEVII_ONE_ISLAND_CITY
	dw SeviiTwoIslandCityWildMons    ; SEVII_TWO_ISLAND_CITY
	dw SeviiThreeIslandCityWildMons  ; SEVII_THREE_ISLAND_CITY
	dw NothingWildMons               ; SEVII_FOUR_ISLAND_CITY
	dw SeviiFiveIslandCityWildMons   ; SEVII_FIVE_ISLAND_CITY
	dw NothingWildMons               ; SEVII_SIX_ISLAND_CITY
	dw NothingWildMons               ; SEVII_SEVEN_ISLAND_CITY
; routes
	dw NothingWildMons               ; SEVII_EIGHT_ISLAND_CITY
	dw SeviiRoute31WildMons          ; SEVII_ROUTE_31
	dw SeviiMtEmberWildMons          ; SEVII_MT_EMBER
	dw SeviiRoute32WildMons          ; SEVII_ROUTE_32
	dw SeviiRoute33WildMons          ; SEVII_ROUTE_33
	dw SeviiRoute34WildMons          ; SEVII_ROUTE_34
	dw SeviiRoute35WildMons          ; SEVII_ROUTE_35
	dw SeviiRoute36WildMons          ; SEVII_ROUTE_36
	dw SeviiRoute37WildMons          ; SEVII_ROUTE_37
	dw SeviiRoute38WildMons          ; SEVII_ROUTE_38
	dw SeviiRoute39WildMons          ; SEVII_ROUTE_39
	dw SeviiRoute40WildMons          ; SEVII_ROUTE_40
	dw SeviiRoute41WildMons          ; SEVII_ROUTE_41
	dw SeviiRoute42WildMons          ; SEVII_ROUTE_42
	dw SeviiRoute43WildMons          ; SEVII_ROUTE_43
	dw SeviiRoute44WildMons          ; SEVII_ROUTE_44
; indoors
; 1-island
	dw SeviiShipDockWildMons         ; SEVII_ONE_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_ONE_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_ONE_ISLAND_GYM
	dw NothingWildMons               ; SEVII_ONE_ISLAND_HOUSES
	dw NothingWildMons               ; SEVII_EMBER_SPA ; TBE?
	dw NothingWildMons               ; SEVII_ROUTE_32_DIVE ; TBE
; 2-island
	dw SeviiShipDockWildMons         ; SEVII_TWO_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_TWO_ISLAND_POKEMON_CENTER
	dw NothingWildMons               ; SEVII_TWO_ISLAND_GYM
	dw NothingWildMons               ; SEVII_TWO_ISLAND_HOUSES
; 3-island
	dw SeviiShipDockWildMons         ; SEVII_THREE_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_THREE_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_THREE_ISLAND_GYM
	dw NothingWildMons               ; SEVII_THREE_ISLAND_HOUSES
; 4-island
	dw SeviiShipDockWildMons         ; SEVII_FOUR_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_FOUR_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_FOUR_ISLAND_GYM
	dw NothingWildMons               ; SEVII_FOUR_ISLAND_HOUSES
	dw SeviiIcefallCave1FWildMons    ; SEVII_ICEFALL_CAVE_1F
; 5-island
	dw SeviiShipDockWildMons         ; SEVII_FIVE_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_FIVE_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_FIVE_ISLAND_GYM
	dw NothingWildMons               ; SEVII_FIVE_ISLAND_HOUSES
	dw NothingWildMons               ; SEVII_FIVE_ISLAND_WAREHOUSE
; 6-island
	dw SeviiShipDockWildMons         ; SEVII_SIX_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_SIX_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_SIX_ISLAND_GYM
; 7-island
	dw SeviiShipDockWildMons         ; SEVII_SEVEN_ISLAND_DOCK
	dw NothingWildMons               ; SEVII_SEVEN_ISLAND_POKEMON_CENTER_AND_MART
	dw NothingWildMons               ; SEVII_SEVEN_ISLAND_GYM
	dw NothingWildMons               ; SEVII_SEVEN_ISLAND_HOUSES
; 8-island
	dw SeviiShipDockWildMons         ; SEVII_ONE_ISLAND_DOCK
	assert_table_length NUM_MAPS_SEVII
	dw -1 ; end

; wild pokemon data is divided into two parts.
; first part:  pokemon found in grass
; second part: pokemon found while surfing
; each part goes as follows:
    ; if first byte == 0, then
        ; no wild pokemon on this map
    ; if first byte != 0, then
        ; first byte is encounter rate
        ; followed by 20 bytes:
        ; level, species (ten times)

;INCLUDE "data/wild/maps/nothing.asm"

INCLUDE "data/wild/maps/sevii/SeviiTwoIslandCity.asm"
INCLUDE "data/wild/maps/sevii/SeviiThreeIslandCity.asm"
INCLUDE "data/wild/maps/sevii/SeviiFiveIslandCity.asm"

INCLUDE "data/wild/maps/sevii/SeviiRoute31.asm"
INCLUDE "data/wild/maps/sevii/SeviiMtEmber.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute32.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute33.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute34.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute35.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute36.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute37.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute38.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute39.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute40.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute41.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute42.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute43.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute44.asm"

INCLUDE "data/wild/maps/sevii/SeviiShipDock.asm"
INCLUDE "data/wild/maps/sevii/SeviiIcefallCave1F.asm"
