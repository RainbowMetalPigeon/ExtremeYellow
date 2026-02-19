RedsHouse2F_Object:
	db $a ; border block

	def_warp_events
	warp_event  7,  1, REDS_HOUSE_1F, 3

	def_bg_events
	bg_event  3,  0, 1 ; RedsHouse2FPersonalizationOptions ; new
	bg_event  4,  0, 2 ; RedsHouse2FRandomizationOptions ; new
	bg_event  5,  0, 3 ; RedsHouse2FLuckOptions ; new
	bg_event  6,  0, 4 ; RedsHouse2FLayoutOptions ; new

	def_object_events

	def_warps_to REDS_HOUSE_2F
