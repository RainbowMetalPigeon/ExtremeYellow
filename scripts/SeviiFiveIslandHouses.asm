SeviiFiveIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiFiveIslandHouses_TextPointers:
	dw SeviiFiveIslandHousesText1 ; Trick Room tutor
	; signs
	dw SeviiFiveIslandHousesSignText1
	dw SeviiFiveIslandHousesSignText2
	dw SeviiFiveIslandHousesSignText3
	dw SeviiFiveIslandHousesSignText4
	; scripts

SeviiFiveIslandHousesText1:
	text_asm
	call BackupTextSpeed
	CheckEvent EVENT_SEVII_SHOWED_MONS_TO_TRICK_ROOM_TUTOR
	jr z, .notYet
.tutorUnlocked
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	call MakeTextTemporarilyMid
	ld hl, SeviiFiveIslandHousesText1_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	call MakeTextTemporarilyInstant
	ld hl, SeviiFiveIslandHousesText1_Refused
	jp .printAndEnd
.learnMove
	ld a, TRICK_ROOM
	ld [wMoveNum], a
	farcall Tutor
	call MakeTextTemporarilyInstant
	ld hl, SeviiFiveIslandHousesText1_Done
	jr .printAndEnd
.notYet
	call MakeTextTemporarilyMid
	ld hl, SeviiFiveIslandHousesText1_CanShowMe
	call PrintText
; check past
	ld d, KABUTO
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	jr c, .checkFuture
	ld d, KABUTOPS
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkFuture
	ld d, OMANYTE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkFuture
	ld d, OMASTAR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkFuture
	ld d, AERODACTYL
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkFuture
	ld d, MARODACTYL
	callfar CheckIfOneGivenMonIsInParty
	jr nc, .missingSomething
.checkFuture
	ld d, PORYGON
	callfar CheckIfOneGivenMonIsInParty
	jr c, .gotEverything
	ld d, PORYGON2
	callfar CheckIfOneGivenMonIsInParty
	jr c, .gotEverything
	ld d, PORYGONZ
	callfar CheckIfOneGivenMonIsInParty
	jr nc, .missingSomething
.gotEverything
	SetEvent EVENT_SEVII_SHOWED_MONS_TO_TRICK_ROOM_TUTOR
;	call WaitForTextScrollButtonPress
	call MakeTextTemporarilyInstant
	ld hl, SeviiFiveIslandHousesText1_Thanks
	call PrintText
;	call WaitForTextScrollButtonPress
	jp .tutorUnlocked
.missingSomething
	call MakeTextTemporarilyInstant
	ld hl, SeviiFiveIslandHousesText1_MissingSomething
.printAndEnd
	call PrintText
	call RestoreTextSpeed
	jp TextScriptEnd

SeviiFiveIslandHousesText1_CanShowMe:
	text_far _SeviiFiveIslandHousesText1_CanShowMe
	text_end

SeviiFiveIslandHousesText1_Thanks:
	text_far _SeviiFiveIslandHousesText1_Thanks
	text_end

SeviiFiveIslandHousesText1_MissingSomething:
	text_far _SeviiFiveIslandHousesText1_MissingSomething
	text_end

SeviiFiveIslandHousesText1_Question:
	text_far _SeviiFiveIslandHousesText1_Question
	text_end

SeviiFiveIslandHousesText1_Refused:
	text_far _SeviiFiveIslandHousesText1_Refused
	text_end

SeviiFiveIslandHousesText1_Done:
	text_far _SeviiFiveIslandHousesText1_Done
	text_end

SeviiFiveIslandHousesSignText1:
	text_far _SeviiFiveIslandHousesSignText1
	text_end

SeviiFiveIslandHousesSignText2:
	text_far _SeviiFiveIslandHousesSignText2
	text_end

SeviiFiveIslandHousesSignText3:
	text_far _SeviiFiveIslandHousesSignText3
	text_end

SeviiFiveIslandHousesSignText4:
	text_far _SeviiFiveIslandHousesSignText4
	text_end

; functions =======================

BackupTextSpeed::
	ld a, [wOptions]
	ld [wUniQuizAnswer], a
	ret

RestoreTextSpeed::
	ld a, [wUniQuizAnswer]
	ld [wOptions], a
	ret

MakeTextTemporarilyInstant::
	ld b, 2
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a
	ret

MakeTextTemporarilyMid:
	ld b, 0
	ld a, [wOptions]
	and $f0
	or b
	ld [wOptions], a
	ret
