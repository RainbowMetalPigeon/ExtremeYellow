; see also MapHeaderBanks_Sevii
MapHeaderPointers_Sevii::
	table_width 2, MapHeaderPointers_Sevii
; cities
	dw SeviiOneIslandCity_h
	dw SeviiTwoIslandCity_h
	dw SeviiThreeIslandCity_h
	dw SeviiFourIslandCity_h
	dw SeviiFiveIslandCity_h
	dw SeviiSixIslandCity_h
	dw SeviiSevenIslandCity_h
; routes
	dw SeviiRoute31_h
	dw SeviiMtEmber_h
	dw SeviiRoute32_h
; indoors
	dw SeviiOneIslandDock_h
	assert_table_length NUM_MAPS_SEVII
