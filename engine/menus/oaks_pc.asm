OpenOaksPC: ; edited
	call SaveScreenTilesToBuffer2
; new for RP
	CheckEvent EVENT_RP_BEAT_HOF_OAK
	ld hl, OaksPCEvenMoreUselessText
	jr nz, .printAndEnd
	CheckEvent EVENT_ROCKET_PATH
	ld hl, OaksPCWasteOfTimeText
	jr nz, .printAndEnd
; BTV
	ld hl, AccessedOaksPCText
	call PrintText
	ld hl, GetDexRatedText
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .closePC
	predef DisplayDexRating
.closePC
	ld hl, ClosedOaksPCText
.printAndEnd ; new label
	call PrintText
	jp LoadScreenTilesFromBuffer2

GetDexRatedText:
	text_far _GetDexRatedText
	text_end

ClosedOaksPCText:
	text_far _ClosedOaksPCText
	text_waitbutton
	text_end

AccessedOaksPCText:
	text_far _AccessedOaksPCText
	text_end

; new for RP ========================

OaksPCEvenMoreUselessText:
	text_far _OaksPCEvenMoreUselessText
	text_end

OaksPCWasteOfTimeText:
	text_far _OaksPCWasteOfTimeText
	text_end
