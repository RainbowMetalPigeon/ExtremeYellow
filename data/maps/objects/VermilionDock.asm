VermilionDock_Object:
	db $f ; border block

	def_warp_events
	warp_event 14,  0, VERMILION_CITY, 6
	warp_event 14,  2, SS_ANNE_1F, 2

	def_bg_events
	bg_event 21,  0, 1 ; VermilionDockText1, new

	def_object_events

	def_warps_to VERMILION_DOCK
