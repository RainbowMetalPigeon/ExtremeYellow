CeladonUniversity2_Script:
	call EnableAutoTextBoxDrawing
	ld hl, CeladonUniversity2_ScriptPointers
	ld a, [wCeladonUniversity2CurScript]
	call CallFunctionInTable
	ret

CeladonUniversity2_ScriptPointers:
	dw CeladonUniversity2Script0

CoordinatesForBooksTextsIDs:
; x, y, textID
    db 32,  2
    db 41,  2
    db 42, 10
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
	; other
	dw CeladonUniversity2SignTest1 ; 15, starting point of the books texts IDs
	dw CeladonUniversity2SignTest2 ; 16
	dw CeladonUniversity2SignTest3 ; 17
	
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
; not first interaction, but all Voltorbs defeated
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

CeladonUniversity2SignTest1:
	text_far _CeladonUniversity2SignTest1
	text_end
	
CeladonUniversity2SignTest2:
	text_far _CeladonUniversity2SignTest2
	text_end
	
CeladonUniversity2SignTest3:
	text_far _CeladonUniversity2SignTest3
	text_end
