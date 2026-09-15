SeviiOneIslandGym1_Script:
	RPTextChooser SeviiOneIslandGym1_TextPointers, SeviiOneIslandGym1_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SeviiOneIslandGym1_ScriptPointers
	ld a, [wCurMapScript] ; edited
	jp CallFunctionInTable

SeviiOneIslandGym1_ScriptPointers:
	dw SeviiOneIslandGym1Script0
	dw SeviiOneIslandGym1Script1

SeviiOneIslandGym1_TextPointers:
	dw SeviiOneIslandGym1Text1

SeviiOneIslandGym1_TextPointers_Rocket:
	dw SeviiOneIslandGym1Text1_RP

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

; new for RP ===============================

SeviiOneIslandGym1Script0:
	ld d,  4 ; x in front of the door
	ld e,  1 ; y in front of the door
	ld c,  1 ; "wait-for-movement" script
	jpfar PushAwayFromGymDoorIfRP

SeviiOneIslandGym1Script1:
	jpfar WaitForPlayerAutomovementSeviiGyms

SeviiOneIslandGym1Text1_RP:
	text_far _SeviiGymsGuideRefusedText_RP
	text_end
