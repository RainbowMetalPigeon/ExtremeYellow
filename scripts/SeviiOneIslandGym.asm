SeviiOneIslandGym_Script:
	jp EnableAutoTextBoxDrawing

SeviiOneIslandGym_TextPointers:
	dw SeviiOneIslandGymText1
	dw SeviiOneIslandGymText2
	text_end

SeviiOneIslandGymText1:
	text_asm
	ld hl, SeviiOneIslandGymText1_Intro
	call PrintText
;	call WaitForTextScrollButtonPress
	callfar CheckIfAllMonsShareAType ; c flag if they all share one type: d and/or e contain the shared type, otherwise, $FF
	ld hl, SeviiOneIslandGymText1_SharedTypes
	ld a, d
	ld [wUniQuizAnswer], a
	ld a, e
	ld [wMultipurposeTemporaryStorage], a
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandGymText1_Intro:
	text_far _SeviiOneIslandGymText1_Intro
	text_end

SeviiOneIslandGymText1_SharedTypes:
	text_far _SeviiOneIslandGymText1_SharedTypes
	text_end

SeviiOneIslandGymText1_NoSharedTypes:
	text_far _SeviiOneIslandGymText1_NoSharedTypes
	text_end

SeviiOneIslandGymText2:
	text_far _SeviiOneIslandGymText2
	text_end
