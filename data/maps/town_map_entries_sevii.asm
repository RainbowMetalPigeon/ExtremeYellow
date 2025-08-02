;MACRO external_map
;	dn \2, \1
;	dw \3
;ENDM

; the appearance of towns and routes in the town map
ExternalMapEntries_Sevii:
	table_width 3, ExternalMapEntries_Sevii
	; x, y, name
	external_map  0,  4, OneIslandName
	external_map  7,  5, TwoIslandName
	external_map 14,  3, ThreeIslandName
	external_map  2,  8, FourIslandName
	external_map  8,  9, FiveIslandName
	external_map 14, 11, SixIslandName
	external_map  4, 12, SevenIslandName
	external_map 11, 15, EightIslandName
	external_map  1,  3, Route31Name
	external_map  1,  1, MtEmberName
	external_map  0,  5, Route32Name
	external_map 13,  3, Route33Name
	external_map  7,  8, Route34Name
	external_map  9,  7, Route35Name
	external_map 10, 11, Route36Name
	assert_table_length FIRST_INDOOR_MAP_SEVII


;MACRO internal_map
;	db \1 + 1
;	dn \3, \2
;	dw \4
;ENDM

; the appearance of buildings and dungeons in the town map
InternalMapEntries_Sevii:
	; maximum map id subject to this rule, x, y, name
	internal_map SEVII_ONE_ISLAND_DOCK,          0,  4, OneIslandName
	db -1 ; end
