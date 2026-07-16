SeviiTwoIslandHouses_Script:
	RPTextChooser SeviiTwoIslandHouses_TextPointers, SeviiTwoIslandHouses_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTwoIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiTwoIslandHouses_ScriptPointers:
	; new for RP
	dw SeviiOneIslandHouses_Null_RP ; 0
	dw SeviiOneIslandHouses_PostBattleTutorBall_RP ; 1
	dw SeviiOneIslandHouses_PostBattleTutorPulse_RP ; 2

; texts ================================

SeviiTwoIslandHouses_TextPointers:
	dw SeviiTwoIslandHousesText1
	dw SeviiTwoIslandHousesText2 ; Tutor Ball
	dw SeviiTwoIslandHousesText3 ; Tutor Pulse
	dw SeviiTwoIslandHousesText4
	dw SeviiTwoIslandHousesText5
	dw SeviiTwoIslandHousesText6
	dw SeviiTwoIslandHousesText7
	dw SeviiTwoIslandHousesText8
	dw SeviiTwoIslandHousesText9
	dw SeviiTwoIslandHousesText10
	dw SeviiTwoIslandHousesText11 ; Clipboard
	; signs
	dw SeviiTwoIslandHousesSignText1
	dw SeviiTwoIslandHousesSignText2
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3

SeviiTwoIslandHouses_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw SeviiTwoIslandHousesText2_RP ; Tutor Ball
	dw SeviiTwoIslandHousesText3_RP ; Tutor Pulse
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw SeviiTwoIslandHousesText11 ; Clipboard
	; signs
	dw SeviiTwoIslandHousesSignText1
	dw SeviiTwoIslandHousesSignText2
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	dw SeviiTwoIslandHousesSignText3
	; scripts
	dw SeviiTwoIslandHousesScriptText1_RP ; 18
	dw SeviiTwoIslandHousesScriptText2_RP ; 19

SeviiTwoIslandHousesText1:
	text_far _SeviiTwoIslandHousesText1
	text_end

SeviiTwoIslandHousesText2: ; Tutor Weather Ball
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiTwoIslandHousesText2_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText2_Refused
	call PrintText
	jr .done
.learnMove
	ld a, WEATHER_BALL
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText2_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiTwoIslandHousesText2_Question:
	text_far _SeviiTwoIslandHousesText2_Question
	text_end

SeviiTwoIslandHousesText2_Refused:
	text_far _SeviiTwoIslandHousesText2_Refused
	text_end

SeviiTwoIslandHousesText2_Done:
	text_far _SeviiTwoIslandHousesText2_Done
	text_end

SeviiTwoIslandHousesText3: ; Tutor Terrain Pulse
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	ld hl, SeviiTwoIslandHousesText3_Question
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText3_Refused
	call PrintText
	jr .done
.learnMove
	ld a, TERRAIN_PULSE
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText3_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiTwoIslandHousesText3_Question:
	text_far _SeviiTwoIslandHousesText3_Question
	text_end

SeviiTwoIslandHousesText3_Refused:
	text_far _SeviiTwoIslandHousesText3_Refused
	text_end

SeviiTwoIslandHousesText3_Done:
	text_far _SeviiTwoIslandHousesText3_Done
	text_end

SeviiTwoIslandHousesText4:
	text_far _SeviiTwoIslandHousesText4
	text_end

SeviiTwoIslandHousesText5:
	text_far _SeviiTwoIslandHousesText5
	text_end

SeviiTwoIslandHousesText6:
	text_far _SeviiTwoIslandHousesText6
	text_end

SeviiTwoIslandHousesText7:
	text_far _SeviiTwoIslandHousesText7
	text_end

SeviiTwoIslandHousesText8:
	text_far _SeviiTwoIslandHousesText8
	text_end

SeviiTwoIslandHousesText9:
	text_far _SeviiTwoIslandHousesText9
	text_end

SeviiTwoIslandHousesText10:
	text_far _SeviiTwoIslandHousesText10
	text_end

SeviiTwoIslandHousesText11:
	text_far _SeviiTwoIslandHousesText11
	text_end

SeviiTwoIslandHousesSignText1:
	text_far _SeviiTwoIslandHousesSignText1
	text_end

SeviiTwoIslandHousesSignText2:
	text_far _SeviiTwoIslandHousesSignText2
	text_end

SeviiTwoIslandHousesSignText3:
	text_far _SeviiTwoIslandHousesSignText3
	text_end

; new for RP =====================================

SeviiTwoIslandHousesText2_RP: ; BALL
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_RP_BEAT_WEATHER_BALL_TUTOR
	jr nz, .alreadyBeated
; still haven't beaten
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_LASS
	ld [wCurOpponent], a
	ld a, 21
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	; no need for the SaveEndBattleTextPointers, as it's RP
	ld a, 1
	ld [wCurMapScript], a
	ld hl, SeviiTwoIslandHousesText2_Intro_RP
	jr .printAndEnd
.alreadyBeated
	ld hl, SeviiTwoIslandHousesText2_Question_RP
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText2_Refused_RP
	jr .printAndEnd
.learnMove
	ld a, WEATHER_BALL
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText2_Done_RP
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiTwoIslandHousesText2_Intro_RP:
	text_far _SeviiTwoIslandHousesText2_Intro_RP
	text_end

SeviiTwoIslandHousesText2_Question_RP:
	text_far _SeviiTwoIslandHousesText2_Question_RP
	text_end

SeviiTwoIslandHousesText2_Refused_RP:
	text_far _SeviiTwoIslandHousesText2_Refused_RP
	text_end

SeviiTwoIslandHousesText2_Done_RP:
	text_far _SeviiTwoIslandHousesText2_Done_RP
	text_end

SeviiTwoIslandHousesScriptText1_RP:
	text_far _SeviiTwoIslandHousesScriptText1_RP
	text_end

SeviiTwoIslandHousesText3_RP: ; PULSE
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_RP_BEAT_TERRAIN_PULSE_TUTOR
	jr nz, .alreadyBeated
; still haven't beaten
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_COOLTRAINER
	ld [wCurOpponent], a
	ld a, 105
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	; no need for the SaveEndBattleTextPointers, as it's RP
	ld a, 2
	ld [wCurMapScript], a
	ld hl, SeviiTwoIslandHousesText3_Intro_RP
	jr .printAndEnd
.alreadyBeated
	ld hl, SeviiTwoIslandHousesText3_Question_RP
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	ld hl, SeviiTwoIslandHousesText3_Refused_RP
	jr .printAndEnd
.learnMove
	ld a, WEATHER_BALL
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiTwoIslandHousesText3_Done_RP
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiTwoIslandHousesText3_Intro_RP:
	text_far _SeviiTwoIslandHousesText3_Intro_RP
	text_end

SeviiTwoIslandHousesText3_Question_RP:
	text_far _SeviiTwoIslandHousesText3_Question_RP
	text_end

SeviiTwoIslandHousesText3_Refused_RP:
	text_far _SeviiTwoIslandHousesText3_Refused_RP
	text_end

SeviiTwoIslandHousesText3_Done_RP:
	text_far _SeviiTwoIslandHousesText3_Done_RP
	text_end

SeviiTwoIslandHousesScriptText2_RP:
	text_far _SeviiTwoIslandHousesScriptText2_RP
	text_end

SeviiOneIslandHouses_Null_RP:
	ret

SeviiOneIslandHouses_PostBattleTutorBall_RP:
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTwoIslandHousesResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_RP_BEAT_WEATHER_BALL_TUTOR
	ld a, 18
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ld a, 2
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	jp SeviiTwoIslandHousesResetScripts

SeviiOneIslandHouses_PostBattleTutorPulse_RP:
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiTwoIslandHousesResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_RP_BEAT_TERRAIN_PULSE_TUTOR
	ld a, 19
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ld a, 3
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	; fallthrough

SeviiTwoIslandHousesResetScripts:
	ld a, 0
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret
