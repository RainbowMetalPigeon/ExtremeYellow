; see also MapHeaderPointers_Sevii
MapHeaderBanks_Sevii::
	table_width 1, MapHeaderBanks_Sevii
; cities
	db BANK(SeviiOneIslandCity_h)
	db BANK(SeviiTwoIslandCity_h)
	db BANK(SeviiThreeIslandCity_h)
	db BANK(SeviiFourIslandCity_h)
	db BANK(SeviiFiveIslandCity_h)
	db BANK(SeviiSixIslandCity_h)
	db BANK(SeviiSevenIslandCity_h)
; routes
	db BANK(SeviiRoute31_h)
	db BANK(SeviiMtEmber_h)
	db BANK(SeviiRoute32_h)
; indoors
	db BANK(SeviiOneIslandDock_h)
	assert_table_length NUM_MAPS_SEVII
