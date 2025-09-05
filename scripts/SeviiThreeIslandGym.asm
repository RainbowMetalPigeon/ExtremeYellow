SeviiThreeIslandGym_Script:
	jp EnableAutoTextBoxDrawing

SeviiThreeIslandGym_TextPointers:
	dw SeviiThreeIslandGymText1
	dw SeviiThreeIslandGymText2
	text_end

SeviiThreeIslandGymText1:
	text_asm
	ld hl, SeviiThreeIslandGymText1_Intro
	call PrintText
	call WaitForTextScrollButtonPress
	callfar CheckIfAllMonsShareAType ; d and/or e contain the shared type, otherwise, $FF
	ld hl, SeviiThreeIslandGymText1_Temp
	ld a, d
	ld [wMultipurposeBuffer], a
	ld a, e
	ld [wMultipurposeBuffer+1], a
	push de
	call PrintText
	call WaitForTextScrollButtonPress
	pop de

; find if and which type is shared, and if both are, choose at random
	ld a, d
	cp $FF
	jr nz, .type1NotNull
; type 1 null, check type 2
	ld a, e
	cp $FF
	ld hl, SeviiThreeIslandGymText1_NoSharedTypes
	jr z, .printAndEnd
; type 1 null, type 2 valid
.oneMatchFound ; the (possibly chosen out of the 2 different valid ones) type is in a
	ld [wMultipurposeBuffer], a
	ld hl, SeviiThreeIslandGymText1_SharedTypes
	jr .printAndEnd
.type1NotNull
	cp e
	jr z, .oneMatchFound ; type1=type2
	ld a, e
	cp $FF
	ld a, d ; load correct value in a in case e=$FF so we're ready for the .oneMatchFound
	jr z, .oneMatchFound
; if here: $FF!=type1!=type2!=$FF, pick one at random
	call Random
	cp 50 percent
	ld a, d
	jr c, .oneMatchFound
	ld a, e
	jr .oneMatchFound

.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiThreeIslandGymText1_Temp:
	text_far _SeviiThreeIslandGymText1_Temp
	text_end

SeviiThreeIslandGymText1_Intro:
	text_far _SeviiThreeIslandGymText1_Intro
	text_end

SeviiThreeIslandGymText1_SharedTypes:
	text_far _SeviiThreeIslandGymText1_SharedTypes
	text_end

SeviiThreeIslandGymText1_NoSharedTypes:
	text_far _SeviiThreeIslandGymText1_NoSharedTypes
	text_end

SeviiThreeIslandGymText2:
	text_far _SeviiThreeIslandGymText2
	text_end
