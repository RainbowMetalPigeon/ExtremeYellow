FuchsiaMeetingRoom_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaMeetingRoom_TextPointers: ; edited
	; after defeating Giovanni in Obsidian
	dw FuchsiaMeetingRoomText1
	dw FuchsiaMeetingRoomText2
	dw FuchsiaMeetingRoomText3
	; before defeating Giovanni in Obsidian
	dw FuchsiaMeetingRoomText4
	dw FuchsiaMeetingRoomText5
	dw FuchsiaMeetingRoomText6
	dw FuchsiaMeetingRoomText7 ; Koga

FuchsiaMeetingRoomText1:
	text_far _FuchsiaMeetingRoomText1
	text_end

FuchsiaMeetingRoomText2:
	text_far _FuchsiaMeetingRoomText2
	text_end

FuchsiaMeetingRoomText3:
	text_far _FuchsiaMeetingRoomText3
	text_end

; new, before defeating Giovanni in Obsidian

FuchsiaMeetingRoomText4:
	text_far _FuchsiaMeetingRoomText4
	text_end

FuchsiaMeetingRoomText5:
	text_far _FuchsiaMeetingRoomText5
	text_end

FuchsiaMeetingRoomText6:
	text_far _FuchsiaMeetingRoomText6
	text_end

FuchsiaMeetingRoomText7: ; Koga
	text_asm
	ld hl, FuchsiaMeetingRoomTextKoga
	call PrintText
	call GBFadeOutToBlack
	SetEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld a, HS_FUCHSIA_MEETING_ROOM_BEFORE_KOGA
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_FUCHSIA_GYM_KOGA
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp TextScriptEnd

FuchsiaMeetingRoomTextKoga:
	text_far _FuchsiaMeetingRoomTextKoga
	text_end
