SSAnneCaptainsRoom_Object:
	db $c ; border block

	def_warp_events
	warp_event  0,  7, SS_ANNE_2F, 9

	def_bg_events
	bg_event  4,  1, 3 ; SSAnne7Text2
	bg_event  1,  2, 4 ; SSAnne7Text3

	def_object_events
	object_event  4,  2, SPRITE_CAPTAIN, STAY, UP, 1 ; person
	object_event  4,  2, SPRITE_OFFICER_JENNY, STAY, DOWN, 2 ; down

	def_warps_to SS_ANNE_CAPTAINS_ROOM
