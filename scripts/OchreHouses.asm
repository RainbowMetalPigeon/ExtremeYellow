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
	ld hl, OchreHousesTextMagikarpTutor_Intro
	call PrintText
	xor a ; NORMAL_PARTY_MENU
    ld [wPartyMenuTypeOrMessageID], a
    dec a
    ld [wUpdateSpritesEnabled], a
    call DisplayPartyMenu
    push af
    callfar InGameTrade_RestoreScreen
    pop af
    ld a, $1
    jp c, .tutoringFailed ; jump if the player didn't select a pokemon
    ld a, MAGIKARP
    ld b, a
    ld a, [wcf91]
    cp b
    ld a, $2
    jr nz, .tutoringFailed ; jump if the selected mon is not MAGIKARP
    ld a, [wWhichPokemon]
    ld hl, wPartyMon1Level
    ld bc, wPartyMon2 - wPartyMon1
    call AddNTimes
    ld a, [hl]
    cp 100 ; is the level 100?
    jr nz, .tutoringFailed ; jump if the MAGIKARP is not level 100

; block to teach ANCESTOR_PWR
;    push bc
    ; Save the selected move id.
;    ld a, [wcf91]
    ld a, ANCESTOR_PWR
    ld [wMoveNum], a
    ld [wd11e],a
    call GetMoveName
    call CopyToStringBuffer ; copy name to wcf4b
;    pop bc
;    ld a, b
;    ld [wWhichPokemon], a
    ld a, [wLetterPrintingDelayFlags]
    push af
    xor a
    ld [wLetterPrintingDelayFlags], a
    predef LearnMove
    pop af
    ld [wLetterPrintingDelayFlags], a
    ld a, b
    and a
    jr z, .tradeSucceeded

    call ClearScreen
    callfar InGameTrade_RestoreScreen
    callfar RedrawMapView
    and a
 ;  ld a, $3
    jr .tradeSucceeded
.tutoringFailed
    scf
.tradeSucceeded
;    ld [wInGameTradeTextPointerTableIndex], a
	jp TextScriptEnd

OchreHousesTextMagikarpTutor_Intro:
	text_far _OchreHousesTextMagikarpTutor_Intro
	text_end

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
