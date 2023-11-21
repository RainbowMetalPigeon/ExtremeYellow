ObsidianHouses_Script:
	call EnableAutoTextBoxDrawing
	ret

ObsidianHouses_TextPointers:
	dw ObsidianHousesTextFlowerEnthusiast
	dw ObsidianHousesTextFishingSuperGuru
	dw ObsidianHousesTextFamily1
	dw ObsidianHousesTextFamily2
	dw ObsidianHousesTextFamily3
	dw ObsidianHousesTextFamily4
	; signs
	dw ObsidianHousesTextFlowerNotes
	dw ObsidianHousesTextFishingBoard
	dw ObsidianHousesTextFishingBoard

; ========================

ObsidianHousesTextFlowerEnthusiast:
	text_far _ObsidianHousesTextFlowerEnthusiast
	text_end

; ------------------------

ObsidianHousesTextFishingSuperGuru:
	text_asm
	ld hl, ObsidianHousesTextFishingSuperGuru_HowFishingGo
	CheckEvent EVENT_ENHANCED_RODS
	jr nz, .done
    ld hl, ObsidianHousesTextFishingSuperGuru_Intro
    call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; YES=0, NO=1
	and a ; equivalent to cp 0
	ld hl, ObsidianHousesTextFishingSuperGuru_Refused
	jr nz, .done
	ld hl, ObsidianHousesTextFishingSuperGuru_Accepted
	call PrintText
	SetEvent EVENT_ENHANCED_RODS
	call GBFadeOutToBlack
	ld a, SFX_LEVEL_UP ; TBC
	call PlaySound
	ld c, 75
	call DelayFrames
	call GBFadeInFromBlack
	ld hl, ObsidianHousesTextFishingSuperGuru_Done
.done
	call PrintText
	jp TextScriptEnd

ObsidianHousesTextFishingSuperGuru_HowFishingGo:
	text_far _ObsidianHousesTextFishingSuperGuru_HowFishingGo
	text_end

ObsidianHousesTextFishingSuperGuru_Intro:
	text_far _ObsidianHousesTextFishingSuperGuru_Intro
	text_end

ObsidianHousesTextFishingSuperGuru_Refused:
	text_far _ObsidianHousesTextFishingSuperGuru_Refused
	text_end

ObsidianHousesTextFishingSuperGuru_Accepted:
	text_far _ObsidianHousesTextFishingSuperGuru_Accepted
	text_end

ObsidianHousesTextFishingSuperGuru_Done:
	text_far _ObsidianHousesTextFishingSuperGuru_Done
	text_end

; ------------------------

ObsidianHousesTextFamily1:
	text_far _ObsidianHousesTextFamily1
	text_end

ObsidianHousesTextFamily2:
	text_far _ObsidianHousesTextFamily2
	text_end

ObsidianHousesTextFamily3:
	text_far _ObsidianHousesTextFamily3
	text_end

ObsidianHousesTextFamily4:
	text_far _ObsidianHousesTextFamily4
	text_end

ObsidianHousesTextFlowerNotes:
	text_far _ObsidianHousesTextFlowerNotes
	text_end

ObsidianHousesTextFishingBoard:
	text_far _ObsidianHousesTextFishingBoard
	text_end
