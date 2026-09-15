
SpawnTraveler::
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ret z
	CheckEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ret nz
	call Random
	cp 130 ; 13 normally, 130 for debug
	jr c, .makeAppear
    call LoopHideTraveler
    call LoopHideTravelerExtra
	ret
.makeAppear
    call LoopShowTraveler
    call LoopShowTravelerExtra
    ret

LoopShowTraveler::
	ld hl, TravelerToHideShow
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObject
	pop hl
	jr .loop

LoopHideTraveler::
	ld hl, TravelerToHideShow
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObject
	pop hl
	jr .loop

LoopShowTravelerExtra::
	ld hl, TravelerToHideShowExtra
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	pop hl
	jr .loop

LoopHideTravelerExtra::
	ld hl, TravelerToHideShowExtra
.loop
	ld a, [hli]
	cp $ff
	ret z
	push hl
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	pop hl
	jr .loop

TravelerToHideShow::
	db HS_VIRIDIAN_CITY_TRAVELER
	db HS_CERULEAN_CITY_TRAVELER
	db HS_VERMILION_CITY_TRAVELER
	db HS_CELADON_CITY_TRAVELER
	db HS_SAFFRON_CITY_TRAVELER
	db $ff

TravelerToHideShowExtra::
	db HS_LAVENDER_TOWN_TRAVELER
	db HS_OCHRE_CITY_TRAVELER
	db HS_FUCHSIA_CITY_TRAVELER
	db HS_OBSIDIAN_ISLAND_TRAVELER
	db HS_CINNABAR_ISLAND_TRAVELER
	db HS_PEWTER_CITY_TRAVELER
	db $ff

; --------------------------------

CheckIfMegaMewtwoInParty::
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

; common script-texts ======================================

TravelerCommonPreBattleText::
    ld hl, Text_Intro_OmniTraveler
    call PrintText
    call CheckIfMegaMewtwoInParty
    jr c, .MMewtwoIsInParty
    ld hl, Text_NoMMewtwo_OmniTraveler
    call PrintText
    scf
    ret
.MMewtwoIsInParty
    ld c, BANK(Music_MeetMaleTrainer)
    ld a, MUSIC_MEET_MALE_TRAINER
    call PlayMusic
    ld hl, Text_YesMMewtwo_OmniTraveler
    call PrintText
    ld hl, wd72d
    set 6, [hl]
    set 7, [hl]
    ld hl, wOptions
    res 7, [hl]	; Turn on battle animations to make the battle feel more epic
    set 6, [hl] ; battle style set
    call Delay3
    ld a, OPP_TRAVELER
    ld [wCurOpponent], a
    ld a, 1
    ld [wTrainerNo], a
    ld a, 1                          ; new, to go beyond 200
    ld [wIsTrainerBattle], a         ; new, to go beyond 200
    ld hl, TextDefeatPostBattle_OmniTraveler
    ld de, TextVictoryPostBattle_OmniTraveler
    call SaveEndBattleTextPointers
    xor a ; to reset the carry flag
    ret

TravelerCommonPostBattleText::
    SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld a, HS_CERULEAN_CAVE_B1F_TRAVELER
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra
    ld hl, Text_Compliments_OmniTraveler
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
    ld hl, Text_WhatWasThat_OmniTraveler
    jp PrintText

; --------------------------------

Text_Intro_OmniTraveler:
	text_far _TextTraveler_Intro
	text_end

Text_YesMMewtwo_OmniTraveler:
	text_far _TextTraveler_YesMMewtwo
	text_end

Text_NoMMewtwo_OmniTraveler:
	text_far _TextTraveler_NoMMewtwo
	text_end

TextDefeatPostBattle_OmniTraveler:
	text_far _TextTraveler_DefeatPostBattle
	text_end

TextVictoryPostBattle_OmniTraveler:
	text_far _TextTraveler_VictoryPostBattle
	text_end

Text_Compliments_OmniTraveler:
	text_far _TextTraveler_Compliments
	text_end

Text_WhatWasThat_OmniTraveler:
	text_far _TextTraveler_WhatWasThat
	text_end

; RP stuff ===============================

TravelerCommonPreBattleText_RP::
    ld hl, Text_Intro_OmniTraveler_RP
    call PrintText
    ld c, BANK(Music_MeetMaleTrainer)
    ld a, MUSIC_MEET_MALE_TRAINER
    call PlayMusic
    ld hl, Text_ForceToFight_OmniTraveler_RP
    call PrintText
    ld hl, wd72d
    set 6, [hl]
    set 7, [hl]
    ld hl, wOptions
    res 7, [hl]	; Turn on battle animations to make the battle feel more epic
    set 6, [hl] ; battle style set
    call Delay3
    ld a, OPP_TRAVELER
    ld [wCurOpponent], a
    ld a, 1
    ld [wTrainerNo], a
    ld a, 1
    ld [wIsTrainerBattle], a
    ld hl, TextDefeatPostBattle_OmniTraveler_RP
    ld de, TextVictoryPostBattle_OmniTraveler_RP
    call SaveEndBattleTextPointers
    SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
    ret

TravelerCommonPostBattleText_RP::
    SetEvent EVENT_BEAT_INTERDIMENSIONAL_TRAVELER
	ld hl, Text_Dammit_OmniTraveler_RP
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
	ld hl, Text_WhatWasThat_OmniTraveler_RP
	jp PrintText

; --------------------------------

Text_Intro_OmniTraveler_RP:
	text_far _TextTraveler_Intro_RP
	text_end

Text_ForceToFight_OmniTraveler_RP:
	text_far _TextTraveler_ForceToFight_RP
	text_end

TextDefeatPostBattle_OmniTraveler_RP:
	text_far _TextTraveler_DefeatPostBattle_RP
	text_end

TextVictoryPostBattle_OmniTraveler_RP:
	text_far _TextTraveler_VictoryPostBattle_RP
	text_end

Text_Dammit_OmniTraveler_RP:
	text_far _TextTraveler_Dammit_RP
	text_end

Text_WhatWasThat_OmniTraveler_RP:
	text_far _TextTraveler_WhatWasThat_RP
	text_end
