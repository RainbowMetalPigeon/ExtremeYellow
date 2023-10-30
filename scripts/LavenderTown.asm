LavenderTown_Script:
	call SpawnTraveler ; new
	jp EnableAutoTextBoxDrawing

LavenderTown_TextPointers:
	dw LavenderTownText1
	dw LavenderTownText2
	dw LavenderTownText3
	dw LavenderTownTextTraveler ; new, can't be bothered to rename and reorder other text pointers
	dw LavenderTownText4
	dw LavenderTownText5
	dw MartSignText
	dw PokeCenterSignText
	dw LavenderTownText8
	dw LavenderTownText9

; --------------------------------

SpawnTraveler: ; new
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ret z
	call Random
	cp 200 ; TBE
	jr nc, .makeAppear
;.makeDisappear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	ret
.makeDisappear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
    ret

LavenderTownTextTraveler: ; new, proxy for now
	text_far _LavenderTownTextTraveler
	text_end

; --------------------------------

LavenderTownText1:
	text_asm
	ld hl, LavenderTownText_4413c
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, LavenderTownText_44146
	jr nz, .got_text
	ld hl, LavenderTownText_44141
.got_text
	call PrintText
	jp TextScriptEnd

LavenderTownText_4413c:
	text_far _LavenderTownText_4413c
	text_end

LavenderTownText_44141:
	text_far _LavenderTownText_44141
	text_end

LavenderTownText_44146:
	text_far _LavenderTownText_44146
	text_end

LavenderTownText2:
	text_far _LavenderTownText2
	text_end

LavenderTownText3:
	text_far _LavenderTownText3
	text_end

LavenderTownText4:
	text_far _LavenderTownText4
	text_end

LavenderTownText5:
	text_far _LavenderTownText5
	text_end

LavenderTownText8:
	text_far _LavenderTownText8
	text_end

LavenderTownText9:
	text_far _LavenderTownText9
	text_end

; --------------------------------

