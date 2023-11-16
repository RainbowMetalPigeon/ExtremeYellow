OchreResearchCenter_Object:
	db $17 ; border block

	def_warp_events
	warp_event  2, 15, OCHRE_CITY, 7
	warp_event  3, 15, OCHRE_CITY, 7
	warp_event 10,  8, OCHRE_RESEARCH_CENTER, 4
	warp_event 10,  0, OCHRE_RESEARCH_CENTER, 3

	def_bg_events

	def_object_events

	def_warps_to OCHRE_RESEARCH_CENTER
