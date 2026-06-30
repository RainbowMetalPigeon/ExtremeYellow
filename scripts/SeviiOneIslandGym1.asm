SeviiOneIslandGym1_Script:
	RPTextChooser SeviiOneIslandGym1_TextPointers, SeviiOneIslandGym1_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

SeviiOneIslandGym1_TextPointers:
	dw SeviiOneIslandGym1Text1

SeviiOneIslandGym1_TextPointers_Rocket:
	dw SeviiOneIslandGym1Text1 ; TBE

SeviiOneIslandGym1Text1:
	text_asm
	CheckEvent EVENT_BEAT_LEAGUE_AT_LEAST_ONCE
	ld hl, SeviiOneIslandGym1Text1_PreLeague
	jr z, .printAndEnd
	ld hl, SeviiOneIslandGym1Text1_PostLeague
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandGym1Text1_PreLeague:
	text_far _SeviiOneIslandGym1Text1_PreLeague
	text_end

SeviiOneIslandGym1Text1_PostLeague:
	text_far _SeviiOneIslandGym1Text1_PostLeague
	text_end
