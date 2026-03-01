SeviiAlteringCave3_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiAlteringCave3_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiAlteringCave3_TextPointers:
	dw RockSmashText ; 1
	dw BoulderText   ; 2
	dw BoulderText   ; 3
	dw BoulderText   ; 4
	dw BoulderText   ; 5
	dw RockSmashText ; 6
	; initially hidden
	dw BoulderText   ; 7
	dw BoulderText   ; 8
	dw BoulderText   ; 9

; scripts ===================================

SeviiAlteringCave3_ScriptPointers:
	dw SeviiAlteringCave3Script0

SeviiAlteringCave3Script0:
;	CheckEvent EVENT_SEVII_SOLVED_ALTERING_CAVE
;	ret nz
; check if all boulders are in the right slots one at the time
	call AlteringCave3_CheckSwitch1
	call AlteringCave3_CheckSwitch2
;	call AlteringCave3_CheckSwitch3
;	call AlteringCave3_CheckSwitch4
	ret

; ---------------

AlteringCave3_CheckSwitch1:
	CheckEvent EVENT_SEVII_ALTERING_CAVE_3_SWITCH_1
	ret nz
	ld hl, CoordsData_SeviiAlteringCave3_1
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z

	; is the pushing animation fully finished?
	CheckEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret z
	
	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_1_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_2_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	SetEvent EVENT_SEVII_ALTERING_CAVE_3_SWITCH_1
	ResetEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret

CoordsData_SeviiAlteringCave3_1:
	dbmapcoord 19, 26
	db -1 ; end

; ---------------

AlteringCave3_CheckSwitch2:
	CheckEvent EVENT_SEVII_ALTERING_CAVE_3_SWITCH_2
	ret nz
	ld hl, CoordsData_SeviiAlteringCave3_2
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z

	; is the pushing animation fully finished?
	CheckEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret z
	
	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_3_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_3
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ALTERING_CAVE_BOULDER_2_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_BOULDER_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_4_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii

	SetEvent EVENT_SEVII_ALTERING_CAVE_3_SWITCH_2
	ResetEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret

CoordsData_SeviiAlteringCave3_2:
	dbmapcoord 14, 19
	db -1 ; end
