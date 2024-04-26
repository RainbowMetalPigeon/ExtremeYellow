CeladonUniversity2_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeladonUniversity2_ScriptPointers
	ld a, [wCeladonUniversity2CurScript]
	call CallFunctionInTable
	ret

CeladonUniversity2_ScriptPointers:
	dw CeladonUniversity2Script0

CoordinatesForBooksTextsIDs:
; x, y
; 3rd row
    db 32,  2
    db 33,  2
    db 34,  2
    db 35,  2
    db 36,  2
    db 37,  2
    db 38,  2
    db 39,  2
    db 40,  2
    db 41,  2
    db 42,  2
    db 43,  2
    db 44,  2
    db 45,  2
    db 46,  2
    db 47,  2
    db 48,  2
    db 49,  2
; 2nd row
    db 32,  6
    db 33,  6
    db 34,  6
    db 35,  6
    db 36,  6
    db 37,  6
    db 38,  6
    db 39,  6
    db 42,  6
    db 43,  6
    db 44,  6
    db 45,  6
    db 46,  6
    db 47,  6
    db 48,  6
    db 49,  6
; 1st row
    db 32, 10
    db 33, 10
    db 34, 10
    db 35, 10
    db 36, 10
    db 37, 10
    db 38, 10
    db 39, 10
    db 42, 10
    db 43, 10
    db 44, 10
    db 45, 10
    db 46, 10
    db 47, 10
    db 48, 10
    db 49, 10
; library PC
    db 36, 17
; whiteboard
    db  9,  4
    db 10,  4
    db 11,  4
    db 12,  4
    db 13,  4
    db 14,  4
    db 15,  4
    db 16,  4
; magna PCs
    db  4,  5
    db 20,  5
	db $FF ; end

CheckIfCoordinateWithBook:
; scf if match is found
; output: textID OFFSET in register a
	ld a, [wXCoord]
	ld b, a ; b holds current X coordinate
	ld a, [wYCoord]
	ld c, a ; c holds current Y coordinate
	ld hl, CoordinatesForBooksTextsIDs
	ld d, $FF ; initial offset, loaded in a at the end
.loop
	inc d ; it's now 0 at the first iteration of the loop
	ld a, [hli] ; a = book X, hl points to book Y
	cp $FF ; terminator
	jr z, .noMatches
	cp b ; are we at a X with a book?
	jr nz, .next1
	ld a, [hli] ; a = book Y, hl points at the NEXT book X
	cp c ; are we (also) at a Y with a book?
	jr nz, .loop ; it was a .next2 but unnecessary now
	ld a, d ; now it's a that contains the book textIDs OFFSET
	scf
	ret
.next1
	inc hl
;.next2
	jr .loop
.noMatches
	xor a
	ret

CeladonUniversity2Script0:
; do not move sleeping student
	ld hl, CeladonUniversity2SleepingStudentCoords
	call ArePlayerCoordsInArray ; carry flag if yes
	jr nc, .checkForAButton
; we are nearby 
	ld hl, wd72d
	set 5, [hl]
	ret
.checkForAButton
; reset "no moving when spoken to" bit
	ld hl, wd72d
	res 5, [hl]
; check if A button is pressed
	ldh a, [hJoyHeld]
	bit BIT_A_BUTTON, a
	ret z
; check if facing up
	ld a, [wSpritePlayerStateData1FacingDirection]
	cp SPRITE_FACING_UP
	ret nz
	call CheckIfCoordinateWithBook ; carry flag set if match found, and a contains textID
	ret nc
	add 15 ; TBE, starting point of the IDs of the books texts IDs
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

CeladonUniversity2SleepingStudentCoords:
	dbmapcoord 33, 13
	dbmapcoord 32, 14
	dbmapcoord 34, 13
	dbmapcoord 33, 14
	dbmapcoord 32, 15
	db -1 ; end

; ================================

CeladonUniversity2_TextPointers:
	; people
	; magna auditorium
	dw CeladonUniversity2Text1 ; prof
	dw CeladonUniversity2Text2 ; student
	dw CeladonUniversity2Text3 ; lovebirds
	dw CeladonUniversity2Text4 ; lovebirds
	dw CeladonUniversity2Text5 ; student
	; library & study room
	dw CeladonUniversity2Text6 ; researcher
	dw CeladonUniversity2Text7 ; student
	dw CeladonUniversity2Text8 ; student, Lapras one
	dw CeladonUniversity2Text9 ; student
	dw CeladonUniversity2Text10 ; student
	dw CeladonUniversity2Text11 ; student
	; computing center
	dw CeladonUniversity2Text12 ; researcher
	dw CeladonUniversity2Text13 ; researcher
	dw CeladonUniversity2Text14 ; researcher
	; signs
	; other (mostly books)
	dw CeladonUniversity2SignBook01 ; 15, starting point of the books texts IDs <-> OFFSET = 0
	dw CeladonUniversity2SignBook02 ; 16
	dw CeladonUniversity2SignBook03 ; 17
	dw CeladonUniversity2SignBook04 ; 18
	dw CeladonUniversity2SignBook05 ; 19
	dw CeladonUniversity2SignBook06 ; 20
	dw CeladonUniversity2SignBook07 ; 21
	dw CeladonUniversity2SignBook08 ; 22
	dw CeladonUniversity2SignBook09 ; 23
	dw CeladonUniversity2SignBook10 ; 24
	dw CeladonUniversity2SignBook11 ; 25
	dw CeladonUniversity2SignBook12 ; 26
	dw CeladonUniversity2SignBook13 ; 27
	dw CeladonUniversity2SignBook14 ; 28
	dw CeladonUniversity2SignBook15 ; 29
	dw CeladonUniversity2SignBook16 ; 30
	dw CeladonUniversity2SignBook17 ; 31
	dw CeladonUniversity2SignBook18 ; 32
	dw CeladonUniversity2SignBook19 ; 33
	dw CeladonUniversity2SignBook20 ; 34
	dw CeladonUniversity2SignBook21 ; 35
	dw CeladonUniversity2SignBook22 ; 36
	dw CeladonUniversity2SignBook23 ; 37
	dw CeladonUniversity2SignBook24 ; 38
	dw CeladonUniversity2SignBook25 ; 39
	dw CeladonUniversity2SignBook26 ; 40
	dw CeladonUniversity2SignBook27 ; 41
	dw CeladonUniversity2SignBook28 ; 42
	dw CeladonUniversity2SignBook29 ; 43
	dw CeladonUniversity2SignBook30 ; 44
	dw CeladonUniversity2SignBook31 ; 45
	dw CeladonUniversity2SignBook32 ; 46
	dw CeladonUniversity2SignBook33 ; 47
	dw CeladonUniversity2SignBook34 ; 48
	dw CeladonUniversity2SignBook35 ; 49
	dw CeladonUniversity2SignBook36 ; 50
	dw CeladonUniversity2SignBook37 ; 51
	dw CeladonUniversity2SignBook38 ; 52
	dw CeladonUniversity2SignBook39 ; 53
	dw CeladonUniversity2SignBook40 ; 54
	dw CeladonUniversity2SignBook41 ; 55
	dw CeladonUniversity2SignBook42 ; 56
	dw CeladonUniversity2SignBook43 ; 57
	dw CeladonUniversity2SignBook44 ; 58
	dw CeladonUniversity2SignBook45 ; 59
	dw CeladonUniversity2SignBook46 ; 60
	dw CeladonUniversity2SignBook47 ; 61
	dw CeladonUniversity2SignBook48 ; 62
	dw CeladonUniversity2SignBook49 ; 63
	dw CeladonUniversity2SignBook50 ; 64
	dw CeladonUniversity2SignLibraryPC ; 65
	dw CeladonUniversity2SignWhiteboard ; 66
	dw CeladonUniversity2SignWhiteboard ; 67
	dw CeladonUniversity2SignWhiteboard ; 68
	dw CeladonUniversity2SignWhiteboard ; 69
	dw CeladonUniversity2SignWhiteboard ; 70
	dw CeladonUniversity2SignWhiteboard ; 71
	dw CeladonUniversity2SignWhiteboard ; 72
	dw CeladonUniversity2SignWhiteboard ; 73
	dw CeladonUniversity2SignMagnaPC ; 74
	dw CeladonUniversity2SignMagnaPC ; 75

; --- magna auditorium ---

CeladonUniversity2Text1:
	text_far _CeladonUniversity2Text1
	text_end

CeladonUniversity2Text2:
	text_far _CeladonUniversity2Text2
	text_end

CeladonUniversity2Text3:
	text_far _CeladonUniversity2Text3
	text_end

CeladonUniversity2Text4:
	text_far _CeladonUniversity2Text4
	text_end

CeladonUniversity2Text5:
	text_far _CeladonUniversity2Text5
	text_end

; --- library & study room ---

CeladonUniversity2Text6:
	text_far _CeladonUniversity2Text6
	text_end

CeladonUniversity2Text7:
	text_far _CeladonUniversity2Text7
	text_end

; ------------------------

CeladonUniversity2Text8:
	text_asm
	CheckEvent EVENT_ALREADY_SPOKEN_WITH_CELADON_PHD
	jr z, .firstTimeSpeaking
; already spoken with them
	ld hl, CeladonUniversity2Text8_AlreadyRewardedOrb
	CheckEvent EVENT_ALREADY_REWARDED_ORB_CELADON_PHD
	jp nz, .printAndEnd
; orb not given, check for money
	CheckEvent EVENT_ALREADY_REWARDED_MONEY_CELADON_PHD
	jr z, .notYetAnyReward
	ld hl, CeladonUniversity2Text8_AlreadyRewardedMoneySpaceForOrb
	call PrintText
	jr .tryToGiveIceOrb
.notYetAnyReward
	ld hl, CeladonUniversity2Text8_HiBackHaveYouDone
	call PrintText
	ld d, LAPRAS
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ld hl, CeladonUniversity2Text8_NotDoneYet
	jr nc, .printAndEnd
; not first interaction, but Lapras already caught
	ld hl, CeladonUniversity2Text8_ThanksHereIsReward
	call PrintText
	jr .giveMoney
.firstTimeSpeaking
	SetEvent EVENT_ALREADY_SPOKEN_WITH_CELADON_PHD
	ld d, LAPRAS
	callfar CheckIfOneGivenMonIsInParty ; carry flag if yes
	ld hl, CeladonUniversity2Text8_Intro_NoPrompt
	jr nc, .printAndEnd
	ld hl, CeladonUniversity2Text8_Intro_WithPrompt
	call PrintText
	ld hl, CeladonUniversity2Text8_WowAlreadyCaught
	call PrintText
.giveMoney
    xor a
    ld [hMoney + 1], a
    ld [hMoney + 2], a
    ld a, $01
    ld [hMoney], a
	ld hl, hMoney + 2
	ld de, wPlayerMoney + 2
	ld c, $3
	predef AddBCDPredef ; add HL to DE with length C
	SetEvent EVENT_ALREADY_REWARDED_MONEY_CELADON_PHD
	ld hl, CeladonUniversity2Text8_FoundThisYouCanHaveIt
	call PrintText
.tryToGiveIceOrb
	lb bc, ICE_ORB, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_ALREADY_REWARDED_ORB_CELADON_PHD
	ld hl, CeladonUniversity2Text8_ReceivedIceOrb
	jr .printAndEnd
.bagFull
	ld hl, CeladonUniversity2Text8_BagFull
.printAndEnd
	call PrintText
.justEnd
	jp TextScriptEnd

CeladonUniversity2Text8_Intro_NoPrompt:
	text_far _CeladonUniversity2Text8_Intro_NoPrompt
	text_end

CeladonUniversity2Text8_Intro_WithPrompt:
	text_far _CeladonUniversity2Text8_Intro_WithPrompt
	text_end

CeladonUniversity2Text8_WowAlreadyCaught:
	text_far _CeladonUniversity2Text8_WowAlreadyCaught
	text_end

CeladonUniversity2Text8_FoundThisYouCanHaveIt:
	text_far _CeladonUniversity2Text8_FoundThisYouCanHaveIt
	text_end

CeladonUniversity2Text8_BagFull:
	text_far _CeladonUniversity2Text8_BagFull
	text_end

CeladonUniversity2Text8_AlreadyRewardedOrb:
	text_far _CeladonUniversity2Text8_AlreadyRewardedOrb
	text_end

CeladonUniversity2Text8_HiBackHaveYouDone:
	text_far _CeladonUniversity2Text8_HiBackHaveYouDone
	text_end

CeladonUniversity2Text8_NotDoneYet:
	text_far _CeladonUniversity2Text8_NotDoneYet
	text_end

CeladonUniversity2Text8_AlreadyRewardedMoneySpaceForOrb:
	text_far _CeladonUniversity2Text8_AlreadyRewardedMoneySpaceForOrb
	text_end

CeladonUniversity2Text8_ThanksHereIsReward:
	text_far _CeladonUniversity2Text8_ThanksHereIsReward
	text_end

CeladonUniversity2Text8_ReceivedIceOrb:
	text_far _CeladonUniversity2Text8_ReceivedIceOrb
	sound_get_key_item
	text_end

; ------------------------

CeladonUniversity2Text9:
	text_far _CeladonUniversity2Text9
	text_end

CeladonUniversity2Text10:
	text_far _CeladonUniversity2Text10
	text_end

CeladonUniversity2Text11:
	text_far _CeladonUniversity2Text11
	text_end

; --- computing center ---

CeladonUniversity2Text12:
	text_far _CeladonUniversity2Text12
	text_end

CeladonUniversity2Text13:
	text_far _CeladonUniversity2Text13
	text_end

CeladonUniversity2Text14:
	text_far _CeladonUniversity2Text14
	text_end

; --- signs ---

; --- (books) ---

CeladonUniversity2SignBook01:
	text_far _CeladonUniversity2SignBook01
	text_end

CeladonUniversity2SignBook02:
	text_far _CeladonUniversity2SignBook02
	text_end

CeladonUniversity2SignBook03:
	text_far _CeladonUniversity2SignBook03
	text_end

CeladonUniversity2SignBook04:
	text_far _CeladonUniversity2SignBook04
	text_end

CeladonUniversity2SignBook05:
	text_far _CeladonUniversity2SignBook05
	text_end

CeladonUniversity2SignBook06:
	text_far _CeladonUniversity2SignBook06
	text_end

CeladonUniversity2SignBook07:
	text_far _CeladonUniversity2SignBook07
	text_end

CeladonUniversity2SignBook08:
	text_far _CeladonUniversity2SignBook08
	text_end

CeladonUniversity2SignBook09:
	text_far _CeladonUniversity2SignBook09
	text_end

CeladonUniversity2SignBook10:
	text_far _CeladonUniversity2SignBook10
	text_end

CeladonUniversity2SignBook11:
	text_far _CeladonUniversity2SignBook11
	text_end

CeladonUniversity2SignBook12:
	text_far _CeladonUniversity2SignBook12
	text_end

CeladonUniversity2SignBook13:
	text_far _CeladonUniversity2SignBook13
	text_end

CeladonUniversity2SignBook14:
	text_far _CeladonUniversity2SignBook14
	text_end

CeladonUniversity2SignBook15:
	text_far _CeladonUniversity2SignBook15
	text_end

CeladonUniversity2SignBook16:
	text_far _CeladonUniversity2SignBook16
	text_end

CeladonUniversity2SignBook17:
	text_far _CeladonUniversity2SignBook17
	text_end

CeladonUniversity2SignBook18:
	text_far _CeladonUniversity2SignBook18
	text_end

CeladonUniversity2SignBook19:
	text_far _CeladonUniversity2SignBook19
	text_end

CeladonUniversity2SignBook20:
	text_far _CeladonUniversity2SignBook20
	text_end

CeladonUniversity2SignBook21:
	text_far _CeladonUniversity2SignBook21
	text_end

CeladonUniversity2SignBook22:
	text_far _CeladonUniversity2SignBook22
	text_end

CeladonUniversity2SignBook23:
	text_far _CeladonUniversity2SignBook23
	text_end

CeladonUniversity2SignBook24:
	text_far _CeladonUniversity2SignBook24
	text_end

CeladonUniversity2SignBook25:
	text_far _CeladonUniversity2SignBook25
	text_end

CeladonUniversity2SignBook26:
	text_far _CeladonUniversity2SignBook26
	text_end

CeladonUniversity2SignBook27:
	text_far _CeladonUniversity2SignBook27
	text_end

CeladonUniversity2SignBook28:
	text_far _CeladonUniversity2SignBook28
	text_end

CeladonUniversity2SignBook29:
	text_far _CeladonUniversity2SignBook29
	text_end

CeladonUniversity2SignBook30:
	text_far _CeladonUniversity2SignBook30
	text_end

CeladonUniversity2SignBook31:
	text_far _CeladonUniversity2SignBook31
	text_end

CeladonUniversity2SignBook32:
	text_far _CeladonUniversity2SignBook32
	text_end

CeladonUniversity2SignBook33:
	text_far _CeladonUniversity2SignBook33
	text_end

CeladonUniversity2SignBook34:
	text_far _CeladonUniversity2SignBook34
	text_end

CeladonUniversity2SignBook35:
	text_far _CeladonUniversity2SignBook35
	text_end

CeladonUniversity2SignBook36:
	text_far _CeladonUniversity2SignBook36
	text_end

CeladonUniversity2SignBook37:
	text_far _CeladonUniversity2SignBook37
	text_end

CeladonUniversity2SignBook38:
	text_far _CeladonUniversity2SignBook38
	text_end

CeladonUniversity2SignBook39:
	text_far _CeladonUniversity2SignBook39
	text_end

CeladonUniversity2SignBook40:
	text_far _CeladonUniversity2SignBook40
	text_end

CeladonUniversity2SignBook41:
	text_far _CeladonUniversity2SignBook41
	text_end

CeladonUniversity2SignBook42:
	text_far _CeladonUniversity2SignBook42
	text_end

CeladonUniversity2SignBook43:
	text_far _CeladonUniversity2SignBook43
	text_end

CeladonUniversity2SignBook44:
	text_far _CeladonUniversity2SignBook44
	text_end

CeladonUniversity2SignBook45:
	text_far _CeladonUniversity2SignBook45
	text_end

CeladonUniversity2SignBook46:
	text_far _CeladonUniversity2SignBook46
	text_end

CeladonUniversity2SignBook47:
	text_far _CeladonUniversity2SignBook47
	text_end

CeladonUniversity2SignBook48:
	text_far _CeladonUniversity2SignBook48
	text_end

CeladonUniversity2SignBook49:
	text_far _CeladonUniversity2SignBook49
	text_end

CeladonUniversity2SignBook50:
	text_far _CeladonUniversity2SignBook50
	text_end

CeladonUniversity2SignLibraryPC:
	text_far _CeladonUniversity2SignLibraryPC
	text_end
	
CeladonUniversity2SignWhiteboard:
	text_far _CeladonUniversity2SignWhiteboard
	text_end
	
CeladonUniversity2SignMagnaPC:
	text_far _CeladonUniversity2SignMagnaPC
	text_end
	