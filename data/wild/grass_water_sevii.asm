WildDataPointers_Sevii:
	table_width 2, WildDataPointers_Sevii
; cities
	dw NothingWildMons               ; SEVII_ONE_ISLAND_CITY
	dw NothingWildMons               ; SEVII_TWO_ISLAND_CITY
	dw SeviiThreeIslandCityWildMons  ; SEVII_THREE_ISLAND_CITY
	dw NothingWildMons               ; SEVII_FOUR_ISLAND_CITY
	dw NothingWildMons               ; SEVII_FIVE_ISLAND_CITY
	dw NothingWildMons               ; SEVII_SIX_ISLAND_CITY
	dw NothingWildMons               ; SEVII_SEVEN_ISLAND_CITY
; routes
	dw NothingWildMons               ; SEVII_EIGHT_ISLAND_CITY
	dw SeviiRoute31WildMons          ; SEVII_ROUTE_31
	dw SeviiMtEmberWildMons          ; SEVII_MT_EMBER
	dw SeviiRoute32WildMons          ; SEVII_ROUTE_32
; indoors
	dw NothingWildMons               ; SEVII_ONE_ISLAND_DOCK
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
INCLUDE "data/wild/maps/sevii/SeviiRoute31.asm"
INCLUDE "data/wild/maps/sevii/SeviiMtEmber.asm"
INCLUDE "data/wild/maps/sevii/SeviiRoute32.asm"
INCLUDE "data/wild/maps/sevii/SeviiThreeIslandCity.asm"
