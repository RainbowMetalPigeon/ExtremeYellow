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

; block to teach ANCESTOR_PWR
.teachDeMove ; temp
;    push bc
;    ld a, [wcf91]
    ld a, ANCESTOR_PWR
    ld [wMoveNum], a
    ld [wd11e],a
    call GetMoveName
    call CopyToStringBuffer ; copy name to wcf4b
;    pop bc
;    ld a, b
;    ld [wWhichPokemon], a
;    ld a, [wLetterPrintingDelayFlags]
;    push af
;    xor a
;    ld [wLetterPrintingDelayFlags], a
	call CheckIfMoveIsKnown2 ; testing
	jr c, .alreadyKnows
    predef LearnMove
;    pop af
;    ld [wLetterPrintingDelayFlags], a
;	ld a, b
;	and a
;	jr z, .tradeSucceeded

;	call ClearScreen
;	call MoveTutor_RestoreScreen
;	callfar RedrawMapView
;	and a
;	ld a, $3
	ld hl, OchreHousesTextMagikarpTutor_OhYeah
	call PrintText
	jr .tradeSucceeded
.tutoringFailedCancel
	ld hl, OchreHousesTextMagikarpTutor_Cancel
	call PrintText
    scf
	jr .tradeSucceeded
.tutoringFailedWrongMon
	ld hl, OchreHousesTextMagikarpTutor_WrongMon
	call PrintText
    scf
	jr .tradeSucceeded
.tutoringFailedWrongLevel
	ld hl, OchreHousesTextMagikarpTutor_WrongLevel
	call PrintText
    scf
	jr .tradeSucceeded
.alreadyKnows
	ld hl, OchreHousesTextMagikarpTutor_AlreadyKnows
	call PrintText
.tradeSucceeded
;    ld [wInGameTradeTextPointerTableIndex], a
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
	text_far _OchreHousesTextBirbFan1
	text_end

OchreHousesTextBirbFan2:
	text_far _OchreHousesTextBirbFan2
	text_end

OchreHousesTextBirbFan3:
	text_far _OchreHousesTextBirbFan3
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

OchreHousesTextNotebook:
	text_far _OchreHousesTextNotebook
	text_end
