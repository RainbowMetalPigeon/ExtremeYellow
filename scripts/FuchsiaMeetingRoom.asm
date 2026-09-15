FuchsiaMeetingRoom_Script:
	RPTextChooser FuchsiaMeetingRoom_TextPointers, FuchsiaMeetingRoom_TextPointers_Rocket
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

FuchsiaMeetingRoom_TextPointers_Rocket:
	; after defeating Giovanni in Obsidian
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; before defeating Giovanni in Obsidian
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw FuchsiaMeetingRoomText7_RP ; Koga

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
	call RandomizeHowManyTrainersBeforeKoga
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp TextScriptEnd

FuchsiaMeetingRoomTextKoga:
	text_far _FuchsiaMeetingRoomTextKoga
	text_end

RandomizeHowManyTrainersBeforeKoga:
	call Random
	and %00000111 ; a is in [0,7]
	cp 7
	jr z, RandomizeHowManyTrainersBeforeKoga ; we can't start directly with Koga, at least the COOLTRAINER
	ld a, 5 ; for debugging
	ld [wHowManyTrainersBeforeKoga], a
	ret

; new for RP =======================

FuchsiaMeetingRoomText7_RP:
	text_asm
	ld hl, FuchsiaMeetingRoomTextKoga_RP
	call PrintText
	call GBFadeOutToBlack
	SetEvent EVENT_SPOKEN_WITH_KOGA_IN_MEETING_ROOM
	ld a, HS_FUCHSIA_MEETING_ROOM_BEFORE_KOGA
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_FUCHSIA_GYM_KOGA
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	call RandomizeHowManyTrainersBeforeKoga
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	jp TextScriptEnd

FuchsiaMeetingRoomTextKoga_RP:
	text_far _FuchsiaMeetingRoomTextKoga_RP
	text_end
