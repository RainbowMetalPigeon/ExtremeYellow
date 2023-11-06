LavenderTown_Script:
	call SpawnTraveler ; new
	call EnableAutoTextBoxDrawing
	ld de, LavenderTown_ScriptPointers
	ld a, [wLavenderTownCurScript]
	call ExecuteCurMapScriptInTable
	ld [wLavenderTownCurScript], a
	ret

LavenderTown_ScriptPointers: ; new, testing
	dw LavenderScript0
	dw LavenderScript1

LavenderScript0:
	ret

LavenderScript1:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wLavenderTownCurScript], a
	ld [wCurMapScript], a
	ret
.notDefeated
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
	ld a, $0b
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; make the traveler run away to search Mega Mewtwo
	call GBFadeOutToBlack
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	ld a, HS_CERULEAN_CAVE_B1F_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ret

; --------------------------------

SpawnTraveler:: ; new
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
;	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
;	ret z
;	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
;	ret nz
	call Random
	cp 200 ; TBE
	jr c, .makeAppear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef HideObjectExtra
	ret
.makeAppear
    ld a, HS_LAVENDER_TOWN_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
    ret

; ================================

LavenderTown_TextPointers:
	dw LavenderTownText1
	dw LavenderTownText2
	dw LavenderTownText3
	dw LavenderTownTextTravelerPreBattle ; new, can't be bothered to rename and reorder other text pointers
	dw LavenderTownText4
	dw LavenderTownText5
	dw MartSignText
	dw PokeCenterSignText
	dw LavenderTownText8
	dw LavenderTownText9 ; $0a
	dw LavenderTownTextTravelerPostBattle ; $0b

; --------------------------------

LavenderTownTextTravelerPreBattle: ; new, proxy for now
	text_asm 
	ld hl, LavenderTownTextTraveler_Intro
	call PrintText
	call CheckIfMegaMewtwoInParty
	jr c, .MMewtwoIsInParty
	ld hl, LavenderTownTextTraveler_NoMMewtwo
	call PrintText
	jp TextScriptEnd
.MMewtwoIsInParty
	ld c, BANK(Music_MeetMaleTrainer)
	ld a, MUSIC_MEET_MALE_TRAINER
	call PlayMusic

	ld hl, LavenderTownTextTraveler_YesMMewtwo
	call PrintText

	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, wOptions
	res 7, [hl]	; Turn on battle animations to make the battle feel more epic

	call Delay3
	ld a, OPP_TRAVELER
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a

	ld hl, TravelerDefeatPostBattleText
	ld de, TravelerVictoryPostBattleText
	call SaveEndBattleTextPointers

	; script handling
	ld a, 1
	ld [wLavenderTownCurScript], a
	ld [wCurMapScript], a

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

TravelerDefeatPostBattleText:
	text_far _TravelerDefeatPostBattleText
	text_end

TravelerVictoryPostBattleText:
	text_far _TravelerVictoryPostBattleText
	text_end

LavenderTownTextTravelerPostBattle:
	text_asm
	SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, LavenderTownTextTraveler_Compliments
	call PrintText
	call GBFadeOutToBlack
    ld a, SFX_PUSH_BOULDER
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	call GBFadeOutToBlack
	call GBFadeInFromBlack
	call GBFadeOutToBlack
    ld a, SFX_GO_INSIDE
    call PlaySound
	ld c, 50
	call DelayFrames
	call GBFadeInFromBlack
	ld hl, LavenderTownTextTraveler_WhatWasThat
	call PrintText
	; script handling
	xor a
	ld [wLavenderTownCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

LavenderTownTextTraveler_Compliments:
	text_far _LavenderTownTextTraveler_Compliments
	text_end

LavenderTownTextTraveler_WhatWasThat:
	text_far _LavenderTownTextTraveler_WhatWasThat
	text_end

; --------------------------------

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

; ================================

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

; ================================
