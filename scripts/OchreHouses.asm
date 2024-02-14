OchreHouses_Script:
	call EnableAutoTextBoxDrawing
	ret

OchreHouses_TextPointers:
	dw MoveDeleterText1 ; OchreHousesTextDeleter
	dw MoveRelearnerText1 ; OchreHousesTextRelearner
	dw OchreHousesTextReactivater
	dw OchreHousesTextMagikarpTutor
	dw OchreHousesTextBirbFan1
	dw OchreHousesTextBirbFan2
	dw OchreHousesTextBirbFan3
	dw OchreHousesTextBirb1 ; FEAROW
	dw OchreHousesTextBirb2 ; FARFETCHD
	dw OchreHousesTextBirb3 ; PIDGEOT
	dw OchreHousesTextBirb4 ; DODRIO
	dw OchreHousesTextMapPiece
	; signs
	dw OchreHousesTextNotebook

; ------------------------

OchreHousesTextReactivater:
	text_asm
	ld hl, OchreHousesTextReactivater_EnjoyRebattles
	CheckEvent EVENT_REACTIVATE_ALL_TRAINERS
	jr nz, .done
    ld hl, OchreHousesTextReactivater_Intro
    call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem] ; YES=0, NO=1
	and a ; equivalent to cp 0
	ld hl, OchreHousesTextReactivater_Refused
	jr nz, .done
	ld hl, OchreHousesTextReactivater_Accepted
	call PrintText
	SetEvent EVENT_REACTIVATE_ALL_TRAINERS
	call GBFadeOutToBlack
	ld a, SFX_LEVEL_UP ; TBC
	call PlaySound
	ld c, 75
	call DelayFrames
	call GBFadeInFromBlack
	ld hl, OchreHousesTextReactivater_Done
.done
	call PrintText
	jp TextScriptEnd

OchreHousesTextReactivater_EnjoyRebattles:
	text_far _OchreHousesTextReactivater_EnjoyRebattles
	text_end

OchreHousesTextReactivater_Intro:
	text_far _OchreHousesTextReactivater_Intro
	text_end

OchreHousesTextReactivater_Refused:
	text_far _OchreHousesTextReactivater_Refused
	text_end

OchreHousesTextReactivater_Accepted:
	text_far _OchreHousesTextReactivater_Accepted
	text_end

OchreHousesTextReactivater_Done:
	text_far _OchreHousesTextReactivater_Done
	text_end

; ------------------------

OchreHousesTextMagikarpTutor:
	text_asm
	call SaveScreenTilesToBuffer2
	ld hl, OchreHousesTextMagikarpTutor_Intro
	call PrintText
	xor a ; NORMAL_PARTY_MENU
    ld [wPartyMenuTypeOrMessageID], a
    dec a
    ld [wUpdateSpritesEnabled], a
    call DisplayPartyMenu
    push af
    call MoveTutor_RestoreScreen
    pop af
    ld a, $1
    jp c, .tutoringFailedCancel ; jump if the player didn't select a pokemon
    ld a, MAGIKARP
    ld b, a
    ld a, [wcf91]
    cp b
    ld a, $2
    jr nz, .tutoringFailedWrongMon ; jump if the selected mon is not MAGIKARP
    ld a, [wWhichPokemon]
    ld hl, wPartyMon1Level
    ld bc, wPartyMon2 - wPartyMon1
    call AddNTimes
    ld a, [hl]
    cp 100 ; is the level 100?
    jr nz, .tutoringFailedWrongLevel ; jump if the MAGIKARP is not level 100
; let's teach ANCESTOR_PWR
    ld a, ANCESTOR_PWR
    ld [wMoveNum], a
    ld [wd11e],a
    call GetMoveName
    call CopyToStringBuffer ; copy name to wcf4b
	call CheckIfMoveIsKnown2 ; testing
	jr c, .alreadyKnows
    predef LearnMove
; text stuff
	ld hl, OchreHousesTextMagikarpTutor_OhYeah
	call PrintText
	jr .teachingSucceeded
.tutoringFailedCancel
	ld hl, OchreHousesTextMagikarpTutor_Cancel
	call PrintText
    scf
	jr .teachingSucceeded
.tutoringFailedWrongMon
	ld hl, OchreHousesTextMagikarpTutor_WrongMon
	call PrintText
    scf
	jr .teachingSucceeded
.tutoringFailedWrongLevel
	ld hl, OchreHousesTextMagikarpTutor_WrongLevel
	call PrintText
    scf
	jr .teachingSucceeded
.alreadyKnows
	ld hl, OchreHousesTextMagikarpTutor_AlreadyKnows
	call PrintText
.teachingSucceeded
	jp TextScriptEnd

OchreHousesTextMagikarpTutor_Intro:
	text_far _OchreHousesTextMagikarpTutor_Intro
	text_end

OchreHousesTextMagikarpTutor_Cancel:
	text_far _OchreHousesTextMagikarpTutor_Cancel
	text_end

OchreHousesTextMagikarpTutor_WrongMon:
	text_far _OchreHousesTextMagikarpTutor_WrongMon
	text_end

OchreHousesTextMagikarpTutor_WrongLevel:
	text_far _OchreHousesTextMagikarpTutor_WrongLevel
	text_end

OchreHousesTextMagikarpTutor_AlreadyKnows:
	text_far _OchreHousesTextMagikarpTutor_AlreadyKnows
	text_end

OchreHousesTextMagikarpTutor_OhYeah:
	text_far _OchreHousesTextMagikarpTutor_OhYeah
	text_end

MoveTutor_RestoreScreen:
	call GBPalWhiteOutWithDelay3
	call RestoreScreenTilesAndReloadTilePatterns
	call ReloadTilesetTilePatterns
	call LoadScreenTilesFromBuffer2
	call Delay3
	call LoadGBPal
	ld c, 10
	call DelayFrames
	farjp LoadWildData

; this is a stupid copy but can't make it work otherwise
; checks if the mon in [wWhichPokemon] already knows the move in [wMoveNum]
CheckIfMoveIsKnown2:
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1Moves
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld a, [wMoveNum]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .alreadyKnown ; found a match
	dec c
	jr nz, .loop
	and a
	ret
.alreadyKnown
	scf
	ret

; ------------------------

OchreHousesTextBirbFan1:
	text_asm
	ld de, OchreHousesTextBirbFan1_Specific
	call CheckMemberOrPresidentAndSetDialogue
	call PrintText
	jp TextScriptEnd

OchreHousesTextBirbFan2:
	text_asm
	ld de, OchreHousesTextBirbFan2_Specific
	call CheckMemberOrPresidentAndSetDialogue
	call PrintText
	jp TextScriptEnd

OchreHousesTextBirbFan3:
	text_asm
	ld de, OchreHousesTextBirbFan3_Specific
	call CheckMemberOrPresidentAndSetDialogue
	call PrintText
	jp TextScriptEnd

OchreHousesTextBirbFan1_Specific:
	text_far _OchreHousesTextBirbFan1_Specific
	text_end

OchreHousesTextBirbFan2_Specific:
	text_far _OchreHousesTextBirbFan2_Specific
	text_end

OchreHousesTextBirbFan3_Specific:
	text_far _OchreHousesTextBirbFan3_Specific
	text_end

OchreHousesTextBirbFan_BecomePresident:
	text_far _OchreHousesTextBirbFan_BecomePresident
	text_end

OchreHousesTextBirbFan_BecomeMember:
	text_far _OchreHousesTextBirbFan_BecomeMember
	text_end
	
OchreHousesTextBirb1:
	text_far _OchreHousesTextBirb1
	text_asm
	ld a, FEAROW
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb2:
	text_far _OchreHousesTextBirb2
	text_asm
	ld a, FARFETCHD
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb3:
	text_far _OchreHousesTextBirb3
	text_asm
	ld a, PIDGEOT
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextBirb4:
	text_far _OchreHousesTextBirb4
	text_asm
	ld a, DODRIO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

OchreHousesTextMapPiece:
	text_asm
	ld hl, OchreHousesTextMapPiece_NotPresident
	CheckEvent EVENT_OCHRE_BIRD_FAN_CLUB_PRESIDENT
	jr z, .printAndEnd
	ld a, HS_OCHRE_HOUSES_MAP_PIECE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	; TODO: set the event corresponding to this fourth of the map,
	; and give the MYSTERY_MAP if not already given
	ld hl, OchreHousesTextMapPiece_President
.printAndEnd
	call PrintText
	jp TextScriptEnd

OchreHousesTextMapPiece_NotPresident:
	text_far _OchreHousesTextMapPiece_NotPresident
	text_end

OchreHousesTextMapPiece_President:
	text_far _OchreHousesTextMapPiece_President
	text_end

; ------------------------

OchreHousesTextNotebook:
	text_far _OchreHousesTextNotebook
	text_end

; ========================

CheckIfABirdInParty::
	ld hl, wPartyCount
	ld a, [hli]
	ld b, a ; b has the number of Mons in the party
.loop
	ld a, [hli]
	cp PIDGEY
	jp z, .aBirdInParty
	cp PIDGEOTTO
	jp z, .aBirdInParty
	cp PIDGEOT
	jp z, .aBirdInParty
	cp MPIDGEOT
	jp z, .aBirdInParty
	cp SPEAROW
	jp z, .aBirdInParty
	cp FEAROW
	jp z, .aBirdInParty
	cp DODUO
	jp z, .aBirdInParty
	cp DODRIO
	jp z, .aBirdInParty
	cp FARFETCHD
	jp z, .aBirdInParty
	cp ARTICUNO
	jp z, .aBirdInParty
	cp ZAPDOS
	jp z, .aBirdInParty
	cp MOLTRES
	jp z, .aBirdInParty
	dec b
	jr nz, .loop
	cp 0 ; a is always >=1, so when we do cp 0 the carry flag is never set (a-0)
		 ; if we have a bird, instead, we set the carry flag
	ret
.aBirdInParty
	scf ; set carry flag
	ret
	
CheckIfAllLegendaryBirdsAreInParty:
	ld d, ARTICUNO
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ret nc
	ld d, ZAPDOS
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ret nc
	ld d, MOLTRES
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ret

; assumes that default text has been loaded in de
CheckMemberOrPresidentAndSetDialogue:
	CheckEvent EVENT_OCHRE_BIRD_FAN_CLUB_PRESIDENT
	jr nz, .defaultText
	push de
	call CheckIfAllLegendaryBirdsAreInParty ; c flag if yes; push-pop necessary because of the callfars inside this function
	pop de
	jr nc, .checkForMember
	SetEvent EVENT_OCHRE_BIRD_FAN_CLUB_PRESIDENT
	ld hl, OchreHousesTextBirbFan_BecomePresident
;	jr .printAndEnd
	ret
.checkForMember
	CheckEvent EVENT_OCHRE_BIRD_FAN_CLUB_MEMBER
	jr nz, .defaultText
	call CheckIfABirdInParty ; c flag if yes
	jr nc, .defaultText
	SetEvent EVENT_OCHRE_BIRD_FAN_CLUB_MEMBER
	ld hl, OchreHousesTextBirbFan_BecomeMember
;	jr .printAndEnd
	ret
.defaultText
	ld h, d
	ld l, e
	ret
