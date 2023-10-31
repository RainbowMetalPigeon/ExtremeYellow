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
;	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
;	ret z
	call Random
	cp 200 ; TBE
	jr c, .makeAppear
;.makeDisappear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	ret
.makeAppear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
    ret

LavenderTownTextTraveler: ; new, proxy for now
	text_asm 
	ld hl, LavenderTownTextTraveler_Intro
	call PrintText
	call CheckIfMegaMewtwoInParty
	ld hl, LavenderTownTextTraveler_YesMMewtwo
	jr c, .MMewtwoIsInParty
	ld hl, LavenderTownTextTraveler_NoMMewtwo
.MMewtwoIsInParty
	call PrintText
	jp TextScriptEnd

LavenderTownTextTraveler_Intro:
	text_far _LavenderTownTextTraveler_Intro
	text_end

LavenderTownTextTraveler_YesMMewtwo:
	text_far _LavenderTownTextTraveler_YesMMewtwo
	text_end

LavenderTownTextTraveler_NoMMewtwo:
	text_far _LavenderTownTextTraveler_NoMMewtwo
	text_end

CheckIfMegaMewtwoInParty:: ; new, testing
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the numnber of Mons in the party
.loop
	ld a, [hli]
	cp MMEWTWOX
	jp z, .MMewtwoInParty
	cp MMEWTWOY
	jp z, .MMewtwoInParty
	dec b
	jr nz, .loop
	cp 0 ; a is always >=1, so when we do cp 0 the carry flag is never set (a-0)
		 ; this is the opposite of what happens if a Mega Mewtwo IS in the party
	ret
.MMewtwoInParty
	scf ; set carry flag
	ret

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

