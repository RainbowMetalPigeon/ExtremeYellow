HauntedRedsHouse_Script:
;	ld hl, wCurrentMapScriptFlags
;	bit 5, [hl]
;	res 5, [hl]
;	call nz, HauntedRedsHouseHandleRandomGlitchyBehaviours
	call EnableAutoTextBoxDrawing
	ld hl, HauntedRedsHouse_ScriptPointers
	ld a, [wHauntedRedsHouseCurScript]
	call CallFunctionInTable
	ret

; =================================

HauntedRedsHouse_ScriptPointers:
	dw HauntedRedsHouseScript0
	dw HauntedRedsHouseScript1

HauntedRedsHouseScript0:
; have we spoken with Haunted Mom 5 times already?
	CheckEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_5
	ret nz ; if yes, we're free
; are we trying to get out?
	ld hl, HauntedRedsHouseEntranceCoords
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	ret nc
.doorCoordinates
; if we're at the door, trigger the dialogue and push us up
	ld a, $1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ldh [hJoyHeld], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	ld a, D_UP | B_BUTTON ; to fix blocking Pikachu glitch
	ld [wSimulatedJoypadStatesEnd], a
	call StartSimulatingJoypadStates
	xor a
	ld [wSpritePlayerStateData1FacingDirection], a ; SPRITE_FACING_UP
	ld [wJoyIgnore], a
	ld a, $1
	ld [wHauntedRedsHouseCurScript], a
	ret

HauntedRedsHouseEntranceCoords:
	dbmapcoord 16,  7
	dbmapcoord 17,  7
	db -1 ; end

; ------------------------

HauntedRedsHouseScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	ld c, 10
	call DelayFrames
	xor a
	ld [wHauntedRedsHouseCurScript], a
;	ld [wCurMapScript], a
	ret

; =================================

HauntedRedsHouse_TextPointers:
	dw HauntedRedsHouseMomText
	dw HauntedRedsHouseTVText
	dw HauntedRedsHouseConsoleText
	dw HauntedRedsHousePCText
	dw HauntedRedsHouseBookshelvesText
	dw HauntedRedsHouseBookshelvesText
	dw HauntedRedsHousePictureText

; ------------------------

HauntedRedsHouseMomText:
	text_asm
	CheckAndSetEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_1
	jr z, .hauntedMomDialogue1
	CheckAndSetEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_2
	jr z, .hauntedMomDialogue2
	CheckAndSetEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_3
	jr z, .hauntedMomDialogue3
	CheckAndSetEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_4
	jr z, .hauntedMomDialogue4
; dialogue5
	SetEvent EVENT_SPOKEN_WITH_HAUNTED_MOM_5
	ld hl, HauntedRedsHouseMomText5
	jr .printAndEnd
.hauntedMomDialogue4
	ld hl, HauntedRedsHouseMomText4
	jr .printAndEnd
.hauntedMomDialogue3
	ld hl, HauntedRedsHouseMomText3
	jr .printAndEnd
.hauntedMomDialogue2
	ld hl, HauntedRedsHouseMomText2
	jr .printAndEnd
.hauntedMomDialogue1
	ld hl, HauntedRedsHouseMomText1
.printAndEnd
	call PrintText
	jp TextScriptEnd

HauntedRedsHouseMomText1:
	text_far _HauntedRedsHouseMomText1
	text_end

HauntedRedsHouseMomText2:
	text_far _HauntedRedsHouseMomText2
	text_end

HauntedRedsHouseMomText3:
	text_far _HauntedRedsHouseMomText3
	text_end

HauntedRedsHouseMomText4:
	text_far _HauntedRedsHouseMomText4
	text_end

HauntedRedsHouseMomText5:
	text_far _HauntedRedsHouseMomText5
	text_end

; ------------------------

HauntedRedsHouseTVText:
	text_asm
	ld hl, HauntedTVWrongSideText
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	jp nz, .got_text
	ld hl, HauntedTVRightSideText
.got_text
	call PrintText
	jp TextScriptEnd

HauntedTVRightSideText:
	text_far _HauntedTVRightSideText
	text_end

HauntedTVWrongSideText:
	text_far _HauntedTVWrongSideText
	text_end

HauntedRedsHouseConsoleText:
	text_far _HauntedRedsHouseConsoleText
	text_end

HauntedRedsHousePCText:
	text_far _HauntedRedsHousePCText
	text_end

HauntedRedsHouseBookshelvesText:
	text_far _HauntedRedsHouseBookshelvesText
	text_end

HauntedRedsHousePictureText:
	text_asm
	CheckAndSetEvent EVENT_INTERACTED_WITH_DAD_PICTURE
	jr nz, .alreadyInteracted
	ld hl, HauntedRedsHousePictureText1
	jr .printAndEnd
.alreadyInteracted
	ld hl, HauntedRedsHousePictureText2
.printAndEnd
	call PrintText
	jp TextScriptEnd

HauntedRedsHousePictureText1:
	text_far _HauntedRedsHousePictureText1
	text_end

HauntedRedsHousePictureText2:
	text_far _HauntedRedsHousePictureText2
	text_end
