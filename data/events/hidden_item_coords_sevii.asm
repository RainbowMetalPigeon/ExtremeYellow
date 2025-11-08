;MACRO hidden_item
;	db \1, \3, \2
;ENDM

HiddenItemCoords_Sevii:
	; map id, x, y
; cities
	hidden_item SEVII_ONE_ISLAND_CITY,               6,  6
	hidden_item SEVII_ONE_ISLAND_CITY,              19,  5
	hidden_item SEVII_ONE_ISLAND_CITY,               3, 32
	hidden_item SEVII_TWO_ISLAND_CITY,              31, 16
	hidden_item SEVII_TWO_ISLAND_CITY,              36,  8
	hidden_item SEVII_THREE_ISLAND_CITY,            12,  3 ; TBE
	hidden_item SEVII_FOUR_ISLAND_CITY,             12,  3 ; TBE
	hidden_item SEVII_FIVE_ISLAND_CITY,             12,  3 ; TBE
	hidden_item SEVII_SIX_ISLAND_CITY,              12,  3 ; TBE
	hidden_item SEVII_SEVEN_ISLAND_CITY,            12,  3 ; TBE
; routes
	hidden_item SEVII_ROUTE_31,                     12,  3 ; TBE
	hidden_item SEVII_ROUTE_32,                     16, 33 ; POKE_BALL
	hidden_item SEVII_ROUTE_32,                     10, 34 ; POTION
	hidden_item SEVII_ROUTE_32,                     14, 32 ; ESCAPE_ROPE
	hidden_item SEVII_ROUTE_32,                     18, 36 ; REVIVE
	hidden_item SEVII_ROUTE_32,                     13, 37 ; PROTEIN
	hidden_item SEVII_ROUTE_32,                      8, 38 ; NUGGET
	hidden_item SEVII_ROUTE_32,                     22, 39 ; FULL_RESTORE
	hidden_item SEVII_ROUTE_32,                     11, 44 ; ETHER
	hidden_item SEVII_ROUTE_32,                     18, 49 ; KINGS_ROCK
	hidden_item SEVII_ROUTE_33,                     80, 10 ; IRON
	hidden_item SEVII_ROUTE_33,                     69,  6 ; ETHER
	hidden_item SEVII_ROUTE_33,                     56,  5 ; RARE_CANDY
	hidden_item SEVII_ROUTE_33,                     95, 22 ; NUGGET
	hidden_item SEVII_ROUTE_36,                     18,  2 ; NUGGET
	hidden_item SEVII_ROUTE_36,                     15, 20 ; ULTRA_BALL
	hidden_item SEVII_ROUTE_36,                     17, 41 ; MAX_REVIVE
	hidden_item SEVII_ROUTE_36,                      3, 31 ; FULL_RESTORE
	hidden_item SEVII_ROUTE_36,                     16,  5 ; PP_UP
	hidden_item SEVII_ROUTE_36,                     12, 21 ; CALCIUM
	hidden_item SEVII_ROUTE_36,                     14, 27 ; PROTEIN
	hidden_item SEVII_ROUTE_37,                      7, 34 ; PP_UP
	hidden_item SEVII_ROUTE_38,                     26, 24 ; NUGGET
	hidden_item SEVII_ROUTE_38,                     11, 12 ; MAX_ELIXER
	hidden_item SEVII_ROUTE_39,                     19, 50 ; MAX_REVIVE
	hidden_item SEVII_ROUTE_39,                     18, 17 ; BIG_NUGGET
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_BF,     27, 18 ; NUGGET
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_BF,      7,  4 ; ETHER
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_1F,      0, 20 ; RARE_CANDY
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_1F,     30, 12 ; ELIXER
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_2F,     19, 12 ; MAX_ETHER
	hidden_item SEVII_FIVE_ISLAND_WAREHOUSE_2F,     28, 17 ; MAX_ELIXER
	hidden_item SEVII_PATTERN_BUSH,                 35,  6 ; MAX_ELIXER
	hidden_item SEVII_PATTERN_BUSH,                 19, 23 ; MAX_ETHER
	hidden_item SEVII_PATTERN_BUSH,                 14,  7 ; MAX_POTION
	hidden_item SEVII_PATTERN_BUSH,                 18, 22 ; MAX_REPEL
	hidden_item SEVII_ROUTE_41,                     30, 13 ; HELIX_FOSSIL
	hidden_item SEVII_ROUTE_41,                     17,  3 ; OLD_AMBER
	hidden_item SEVII_ROUTE_41,                      3, 12 ; DOME_FOSSIL
; indoors
	hidden_item SEVII_ONE_ISLAND_DOCK,              12,  3 ; TBE
	db -1 ; end
