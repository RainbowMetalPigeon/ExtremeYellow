SeviiAlteringCave2_Script:
	call EnableAutoTextBoxDrawing
	ld de, SeviiAlteringCave2_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

SeviiAlteringCave2_TextPointers:
	dw BoulderText   ; 1
	dw BoulderText   ; 2
	dw BoulderText   ; 3
	dw RockSmashText ; 4
	; initially hidden
	dw BoulderText   ; 5
	dw BoulderText   ; 6
	dw BoulderText   ; 7

; scripts ===================================

SeviiAlteringCave2_ScriptPointers:
	dw SeviiAlteringCave2Script0

SeviiAlteringCave2Script0:
;	CheckEvent EVENT_SEVII_SOLVED_ALTERING_CAVE
;	ret nz
; check if all boulders are in the right slots one at the time
	call AlteringCave2_CheckSwitch1
	call AlteringCave2_CheckSwitch2
;	call AlteringCave2_CheckSwitch3
;	call AlteringCave2_CheckSwitch4
	ret

; ---------------

AlteringCave2_CheckSwitch1:
	CheckEvent EVENT_SEVII_ALTERING_CAVE_2_SWITCH_1
	ret nz
	ld hl, CoordsData_SeviiAlteringCave2_1
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z

	; is the pushing animation fully finished?
	CheckEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret z
	
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_1_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ALTERING_CAVE_BOULDER_1_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_BOULDER_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	SetEvent EVENT_SEVII_ALTERING_CAVE_2_SWITCH_1
	ResetEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret

CoordsData_SeviiAlteringCave2_1:
	dbmapcoord 12, 34
	db -1 ; end

; ---------------

AlteringCave2_CheckSwitch2:
	CheckEvent EVENT_SEVII_ALTERING_CAVE_2_SWITCH_2
	ret nz
	ld hl, CoordsData_SeviiAlteringCave2_2
	call CheckBoulderCoords
	ret nc
	ldh a, [hSpriteIndex]
	cp $f
	ret z

	; is the pushing animation fully finished?
	CheckEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret z
	
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_3_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_2_BOULDER_3
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_2_H
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, HS_SEVII_ALTERING_CAVE_3_BOULDER_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii

	SetEvent EVENT_SEVII_ALTERING_CAVE_2_SWITCH_2
	ResetEvent EVENT_FINISHED_PUSHING_BOULDER_FOR_ALTERING_CAVE
	ret

CoordsData_SeviiAlteringCave2_2:
	dbmapcoord  5, 23
	db -1 ; end
