SeviiTanobyChambers_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTanobyChambers_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SeviiTanobyChambers_ScriptPointers:
	dw SeviiTanobyChambers_Base ; 0
	dw SeviiTanobyChambers_PrintSuccessOneChamber ; 1
	
SeviiTanobyChambers_Base:
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	jr nz, .goToChamber2
; are we tracking time for Chamber1?
	CheckEvent EVENT_SEVII_TANOBY_TRACK_TIME
	jr z, .goToChamber2
; we are tracking time: if we move, reset the event (also if we use Dig/Escape Rope)
	ld hl, SeviiTanobyChambers_Chamber1_Coordinates
	call ArePlayerCoordsInArray ; sets carry if the coordinates are in the array, clears carry if not
	jr nc, .dontTrackTime
; we are still in the right spot: check if enough time passed
	CheckEvent EVENT_SEVII_TANOBY_TIME_PASSED
	ret z
; enough time passed
	SetEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	ResetEvent EVENT_SEVII_TANOBY_TRACK_TIME
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	jp DisplayTextID
.dontTrackTime
	ResetEvent EVENT_SEVII_TANOBY_TRACK_TIME
	; fallthrough

.goToChamber2
	ret

SeviiTanobyChambers_Chamber1_Coordinates:
	dbmapcoord  2,  9
	db -1 ; end

SeviiTanobyChambers_PrintSuccessOneChamber:
	ld a, SFX_PUSH_BOULDER
	call PlaySound
	ld a, 7
	ldh [hSpriteIndexOrTextID], a
	xor a
	ld [wCurMapScript], a
	jp DisplayTextID

; texts =========================================

SeviiTanobyChambers_TextPointers:
	dw SeviiTanobyChambersSignText1
	dw SeviiTanobyChambersSignText2
	dw SeviiTanobyChambersSignText3
	dw SeviiTanobyChambersSignText4
	dw SeviiTanobyChambersSignText5
	dw SeviiTanobyChambersSignText6
	; scripts
	dw SeviiTanobyChambersScriptText1 ;  7 : Solved Chamber

SeviiTanobyChambersSignText1:
	text_asm
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_1
	jr nz, .skipSetup
	xor a
	ld [wUniQuizAnswer], a
	SetEvent EVENT_SEVII_TANOBY_TRACK_TIME
.skipSetup
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText1_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText1_Inner:
	text_far _SeviiTanobyChambersSignText1
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText2:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText2_Inner
	call PrintText
	CheckEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_2
	jr nz, .done
; we haven't solved this room yet, check party
	call CheckIfStartersPlusMewtwoInParty
	jr nc, .done
; we have a proper team
	SetEvent EVENT_SEVII_TANOBY_SOLVED_CHAMBER_2
	ld a, 1
	ld [wCurMapScript], a
.done
	jp TextScriptEnd

SeviiTanobyChambersSignText2_Inner:
	text_far _SeviiTanobyChambersSignText2
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText3:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText3_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText3_Inner:
	text_far _SeviiTanobyChambersSignText3
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText4:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText4_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText4_Inner:
	text_far _SeviiTanobyChambersSignText4
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText5:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText5_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText5_Inner:
	text_far _SeviiTanobyChambersSignText5
	text_end

; --------------------------------------------

SeviiTanobyChambersSignText6:
	text_asm
	callfar LoadFontTilePatternsBraille
	ld hl, SeviiTanobyChambersSignText6_Inner
	call PrintText
	jp TextScriptEnd

SeviiTanobyChambersSignText6_Inner:
	text_far _SeviiTanobyChambersSignText6
	text_end

; =========================================

; c flag if proper team
CheckIfStartersPlusMewtwoInParty:
; Bulba
	ld d, BULBASAUR
	callfar CheckIfOneGivenMonIsInParty ; d contains the Pokemon you want to check ; sets carry flag if found
	jr c, .checkChar
	ld d, IVYSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, VENUSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, MVENUSAUR
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkChar
	ld d, VENUSTOISE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Char
.checkChar
	ld d, CHARMANDER
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, CHARMELEON
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, CHARIZARD
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, MCHARZARDX
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkSqui
	ld d, MCHARZARDY
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Squi
.checkSqui
	ld d, SQUIRTLE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, WARTORTLE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, BLASTOISE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, MBLASTOISE
	callfar CheckIfOneGivenMonIsInParty
	jr c, .checkPika
	ld d, VENUSTOISE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Pikachu
.checkPika
	ld d, PIKACHU
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Eevee
	ld d, EEVEE
	callfar CheckIfOneGivenMonIsInParty
	ret nc
; Mewtwo
	ld d, MEWTWO
	callfar CheckIfOneGivenMonIsInParty
	ret c
	ld d, MMEWTWOX
	callfar CheckIfOneGivenMonIsInParty
	ret c
	ld d, MMEWTWOY
	callfar CheckIfOneGivenMonIsInParty
	ret

; --------------------------------------------

SeviiTanobyChambersScriptText1:
	text_far _SeviiTanobyChambersScriptText1
	text_end
