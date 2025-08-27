;MACRO hidden_item
;	db \1, \3, \2
;ENDM

HiddenItemCoords_Sevii:
	; map id, x, y
; cities
	hidden_item SEVII_ONE_ISLAND_CITY,         6,  6,
	hidden_item SEVII_ONE_ISLAND_CITY,        19,  5,
	hidden_item SEVII_ONE_ISLAND_CITY,         3, 32,
	hidden_item SEVII_TWO_ISLAND_CITY,         12,  3 ; TBE
	hidden_item SEVII_THREE_ISLAND_CITY,       12,  3 ; TBE
	hidden_item SEVII_FOUR_ISLAND_CITY,        12,  3 ; TBE
	hidden_item SEVII_FIVE_ISLAND_CITY,        12,  3 ; TBE
	hidden_item SEVII_SIX_ISLAND_CITY,         12,  3 ; TBE
	hidden_item SEVII_SEVEN_ISLAND_CITY,       12,  3 ; TBE
; routes
	hidden_item SEVII_ROUTE_31,                12,  3 ; TBE
	hidden_item SEVII_ROUTE_32,                16, 33 ; TBE
	hidden_item SEVII_ROUTE_32,                10, 34 ; TBE
	hidden_item SEVII_ROUTE_32,                14, 32 ; TBE
	hidden_item SEVII_ROUTE_33,                80, 10 ; IRON
	hidden_item SEVII_ROUTE_33,                69,  6 ; ETHER
	hidden_item SEVII_ROUTE_33,                56,  5 ; RARE_CANDY
	hidden_item SEVII_ROUTE_33,                99, 23 ; NUGGET
; indoors
	hidden_item SEVII_ONE_ISLAND_DOCK,         12,  3 ; TBE
	db -1 ; end
