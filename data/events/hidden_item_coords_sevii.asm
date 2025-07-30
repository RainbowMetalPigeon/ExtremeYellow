;MACRO hidden_item
;	db \1, \3, \2
;ENDM

HiddenItemCoords_Sevii:
	; map id, x, y
; cities
	hidden_item SEVII_ONE_ISLAND_CITY,         15, 15
	hidden_item SEVII_TWO_ISLAND_CITY,         12,  3
	hidden_item SEVII_THREE_ISLAND_CITY,       12,  3
	hidden_item SEVII_FOUR_ISLAND_CITY,        12,  3
	hidden_item SEVII_FIVE_ISLAND_CITY,        12,  3
	hidden_item SEVII_SIX_ISLAND_CITY,         12,  3
	hidden_item SEVII_SEVEN_ISLAND_CITY,       12,  3
; routes
	hidden_item SEVII_ROUTE_31,                12,  3
	hidden_item SEVII_ROUTE_32,                16, 33
	hidden_item SEVII_ROUTE_32,                10, 34
	hidden_item SEVII_ROUTE_32,                14, 32
; indoors
	hidden_item SEVII_ONE_ISLAND_DOCK,         12,  3
	hidden_item SILPH_CO_5F,                   12,  3
	db -1 ; end
