CeladonUniversity2_Object:
	db $17 ; border block

	def_warp_events
	; magna auditorium
	warp_event 12, 33, CELADON_UNIVERSITY_1, 4 ; 1
	warp_event 13, 33, CELADON_UNIVERSITY_1, 4 ; 2
	; library & study room
	warp_event 40, 17, CELADON_UNIVERSITY_1, 5 ; 3
	warp_event 41, 17, CELADON_UNIVERSITY_1, 5 ; 4
	; computing center
	warp_event 38, 33, CELADON_UNIVERSITY_1, 6 ; 5
	warp_event 39, 33, CELADON_UNIVERSITY_1, 6 ; 6

	def_bg_events
;	bg_event xx, yy, nn ; CeladonUniversityxxx

	def_object_events
	; magna auditorium

	; library & study room

	; computing center

	def_warps_to CELADON_UNIVERSITY_2
