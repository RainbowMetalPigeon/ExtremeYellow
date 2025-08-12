SeviiOneIslandCity_Script:
	jp EnableAutoTextBoxDrawing

SeviiOneIslandCity_TextPointers:
	dw SeviiOneIslandCityText1
;	dw PickUpItemText
;	dw PickUpItemText
;	dw PickUpItemText
;	dw SeviiOneIslandCityText3
	text_end

SeviiOneIslandCityText1:
	text_asm
	call SaveScreenTilesToBuffer2 ;this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiOneIslandCityText1_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
	ld hl, SeviiOneIslandCityText1_Refused
	call PrintText
	jr .done
.learnMove
	ld a, SUNNY_DAY
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiOneIslandCityText1_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiOneIslandCityText1_Question:
	text_far _SeviiOneIslandCityText1_Question
	text_end

SeviiOneIslandCityText1_Refused:
	text_far _SeviiOneIslandCityText1_Refused
	text_end

SeviiOneIslandCityText1_Done:
	text_far _SeviiOneIslandCityText1_Done
	text_end
