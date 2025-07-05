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
	map_const SEVII_TWO_ISLAND_CITY,         10,  9 ; $01
	map_const SEVII_THREE_ISLAND_CITY,       10,  9 ; $02
	map_const SEVII_FOUR_ISLAND_CITY,        10,  9 ; $03
	map_const SEVII_FIVE_ISLAND_CITY,        10,  9 ; $04
	map_const SEVII_SIX_ISLAND_CITY,         10,  9 ; $05
	map_const SEVII_SEVEN_ISLAND_CITY,       10,  9 ; $06
DEF NUM_CITY_MAPS_SEVII EQU const_value
DEF FIRST_ROUTE_MAP_SEVII EQU const_value
	map_const SEVII_ROUTE_31,                15, 55 ; $07
DEF FIRST_INDOOR_MAP_SEVII EQU const_value
	map_const SEVII_ONE_ISLAND_DOCK,          4,  3 ; $08
DEF NUM_MAPS_SEVII EQU const_value

; Indoor maps, such as houses, use this as the Map ID in their exit warps
; This map ID takes the player back to the last outdoor map they were on, stored in wLastMap
DEF LAST_MAP_SEVII EQU -1
