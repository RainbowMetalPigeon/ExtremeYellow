SeviiFiveIslandHouses_Script:
	RPTextChooser SeviiFiveIslandHouses_TextPointers, SeviiFiveIslandHouses_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, SeviiFiveIslandHouses_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

SeviiFiveIslandHouses_ScriptPointers:
	; new for RP
	dw SeviiFiveIslandHouses_Null_RP ; 0
	dw SeviiFiveIslandHouses_PostBattleTutor_RP ; 1
	dw SeviiFiveIslandHouses_PreBattleBiker_RP ; 2
	dw SeviiFiveIslandHouses_PostBattleBiker_RP ; 3

SeviiFiveIslandHouses_Null_RP:
	ret

; texts ================================

SeviiFiveIslandHouses_TextPointers:
	dw SeviiFiveIslandHousesText1 ; Trick Room tutor
	dw SeviiFiveIslandHousesText2
	dw SeviiFiveIslandHousesText3
	dw SeviiFiveIslandHousesText4
	dw SeviiFiveIslandHousesText5
	dw SeviiFiveIslandHousesText6
	dw SeviiFiveIslandHousesText7
	; signs
	dw SeviiFiveIslandHousesSignText1
	dw SeviiFiveIslandHousesSignText2
	dw SeviiFiveIslandHousesSignText3
	dw SeviiFiveIslandHousesSignText4

SeviiFiveIslandHouses_TextPointers_Rocket:
	dw SeviiFiveIslandHousesText1_RP ; Trick Room tutor
	dw SeviiFiveIslandHousesText2_RP ; Biker
	dw SeviiFiveIslandHousesText3_RP ; Mon SANDSHREW
	dw SeviiFiveIslandHousesText4_RP ; Mon ODDISH
	dw SeviiFiveIslandHousesText5_RP ; Mon JIGGLYPUFF
	dw SeviiFiveIslandHousesText6_RP ; Mon CLEFAIRY
	dw SeviiFiveIslandHousesText7 ; Paper
	; signs
	dw SeviiFiveIslandHousesSignText1
	dw SeviiFiveIslandHousesSignText2
	dw SeviiFiveIslandHousesSignText3
	dw SeviiFiveIslandHousesSignText4
	; scripts for RP
	dw SeviiFiveIslandHousesScriptsText1 ; 12
	dw SeviiFiveIslandHousesScriptsText2 ; 13
	dw SeviiFiveIslandHousesScriptsText3 ; 14

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

SeviiFiveIslandHousesText2:
	text_far _SeviiFiveIslandHousesText2
	text_end

SeviiFiveIslandHousesText3: ; SANDSHREW
	text_far _SeviiFiveIslandHousesText3
	text_asm
	ld a, SANDSHREW
	call PlayCry
	call WaitForSoundToFinish
	ld hl, SeviiFiveIslandHousesTextMonsCommon
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandHousesText4: ; ODDISH
	text_far _SeviiFiveIslandHousesText4
	text_asm
	ld a, ODDISH
	call PlayCry
	call WaitForSoundToFinish
	ld hl, SeviiFiveIslandHousesTextMonsCommon
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandHousesText5: ; JIGGLYPUFF
	text_far _SeviiFiveIslandHousesText5
	text_asm
	ld a, JIGGLYPUFF
	call PlayCry
	call WaitForSoundToFinish
	ld hl, SeviiFiveIslandHousesTextMonsCommon
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandHousesText6: ; CLEFAIRY
	text_far _SeviiFiveIslandHousesText6
	text_asm
	ld a, CLEFAIRY
	call PlayCry
	call WaitForSoundToFinish
	ld hl, SeviiFiveIslandHousesTextMonsCommon
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandHousesTextMonsCommon:
	text_far _SeviiFiveIslandHousesTextMonsCommon
	text_end

SeviiFiveIslandHousesText7: ; PAPER
	text_far _SeviiFiveIslandHousesText7
	text_end

; functions =======================

BackupTextSpeed::
	ld a, [wOptions]
	ld [wUniQuizAnswer+5], a
	ret

RestoreTextSpeed::
	ld a, [wUniQuizAnswer+5]
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

; new for RP ================================

SeviiFiveIslandHousesText1_RP:
	text_asm
	call BackupTextSpeed
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_SEVII_SHOWED_MONS_TO_TRICK_ROOM_TUTOR ; abused
	jr nz, .alreadyBeated
; still haven't beaten
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_SCIENTIST
	ld [wCurOpponent], a
	ld a, 20
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	; no need for the SaveEndBattleTextPointers, as it's RP
	ld a, 1
	ld [wCurMapScript], a
	call MakeTextTemporarilyMid
	ld hl, SeviiFiveIslandHousesText1_Intro_RP
	jr .printAndEnd
.alreadyBeated
	call MakeTextTemporarilyInstant
	ld hl, SeviiFiveIslandHousesText1_Question_RP
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .learnMove
.declineMove
	call MakeTextTemporarilyMid
	ld hl, SeviiFiveIslandHousesText1_Refused_RP
	jr .printAndEnd
.learnMove
	ld a, TRICK_ROOM
	ld [wMoveNum], a
	farcall Tutor
	call MakeTextTemporarilyMid
	ld hl, SeviiFiveIslandHousesText1_Done_RP
.printAndEnd
	call PrintText
	call RestoreTextSpeed
	jp TextScriptEnd

SeviiFiveIslandHouses_PostBattleTutor_RP:
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiFourIslandHousesResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_SEVII_SHOWED_MONS_TO_TRICK_ROOM_TUTOR ; abused
	ld a, 12
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	xor a
	ld [wJoyIgnore], a
	ld a, 1
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	; fallthrough
SeviiFiveIslandHousesResetScripts:
	ld a, 0
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SeviiFiveIslandHousesText1_Intro_RP:
	text_far _SeviiFiveIslandHousesText1_Intro_RP
	text_end

SeviiFiveIslandHousesText1_Question_RP:
	text_far _SeviiFiveIslandHousesText1_Question_RP
	text_end

SeviiFiveIslandHousesText1_Refused_RP:
	text_far _SeviiFiveIslandHousesText1_Refused_RP
	text_end

SeviiFiveIslandHousesText1_Done_RP:
	text_far _SeviiFiveIslandHousesText1_Done_RP
	text_end

SeviiFiveIslandHousesScriptsText1:
	text_far _SeviiFiveIslandHousesScriptsText1
	text_end

; ----------------

SeviiFiveIslandHousesText3_RP: ; SANDSHREW
	text_far _SeviiFiveIslandHousesText3
	text_asm
	ld a, SANDSHREW
	call PlayCry
	call WaitForSoundToFinish
; beat caring Biker already?
	CheckEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	jr nz, .stealMon
; trigger battle
	ld hl, SeviiFiveIslandHousesTextMonsCommon_RP
	call PrintText
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd
; steal mon
.stealMon
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 42
	ld b, SANDSHREW
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_SEVII_FIVE_ISLAND_HOUSES_MON_1
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd

SeviiFiveIslandHousesText4_RP: ; ODDISH
	text_far _SeviiFiveIslandHousesText4
	text_asm
	ld a, ODDISH
	call PlayCry
	call WaitForSoundToFinish
; beat caring Biker already?
	CheckEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	jr nz, .stealMon
; trigger battle
	ld hl, SeviiFiveIslandHousesTextMonsCommon_RP
	call PrintText
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd
; steal mon
.stealMon
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 42
	ld b, ODDISH
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_SEVII_FIVE_ISLAND_HOUSES_MON_2
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd

SeviiFiveIslandHousesText5_RP: ; JIGGLYPUFF
	text_far _SeviiFiveIslandHousesText5
	text_asm
	ld a, JIGGLYPUFF
	call PlayCry
	call WaitForSoundToFinish
; beat caring Biker already?
	CheckEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	jr nz, .stealMon
; trigger battle
	ld hl, SeviiFiveIslandHousesTextMonsCommon_RP
	call PrintText
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd
; steal mon
.stealMon
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 42
	ld b, JIGGLYPUFF
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_SEVII_FIVE_ISLAND_HOUSES_MON_3
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd

SeviiFiveIslandHousesText6_RP: ; CLEFAIRY
	text_far _SeviiFiveIslandHousesText6
	text_asm
	ld a, CLEFAIRY
	call PlayCry
	call WaitForSoundToFinish
; beat caring Biker already?
	CheckEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	jr nz, .stealMon
; trigger battle
	ld hl, SeviiFiveIslandHousesTextMonsCommon_RP
	call PrintText
	ld a, 2
	ld [wCurMapScript], a
	jp TextScriptEnd
; steal mon
.stealMon
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 42
	ld b, CLEFAIRY
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_SEVII_FIVE_ISLAND_HOUSES_MON_4
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
	jp TextScriptEnd

SeviiFiveIslandHousesTextMonsCommon_RP:
	text_far _SeviiFiveIslandHousesTextMonsCommon_RP
	text_end

SeviiFiveIslandHouses_PreBattleBiker_RP:
; exclamation bubble
	ld a, 2
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
; dialogue
	ld a, 13
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; set up battle
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_BIKER
	ld [wCurOpponent], a
	ld a, 18
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
	ld hl, SeviiFiveIslandHouses_PreBattleBiker_RP_EndOfBattleText
	ld de, SeviiFiveIslandHouses_PreBattleBiker_RP_EndOfBattleText
	call SaveEndBattleTextPointers
; load next script
	ld a, 3
	ld [wCurMapScript], a
	ret

SeviiFiveIslandHouses_PostBattleBiker_RP:
; did we win?
	ld a, [wIsInBattle]
	cp $ff
	jp z, SeviiFourIslandHousesResetScripts
; we won
	ld a, $f0
	ld [wJoyIgnore], a
	SetEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; load next script
	jp SeviiFiveIslandHousesResetScripts

SeviiFiveIslandHousesScriptsText2: ; 13
	text_far _SeviiFiveIslandHousesScriptsText2
	text_end

SeviiFiveIslandHouses_PreBattleBiker_RP_EndOfBattleText:
	text_far _SeviiFiveIslandHouses_PreBattleBiker_RP_EndOfBattleText
	text_end

SeviiFiveIslandHousesScriptsText3: ; 14
	text_far _SeviiFiveIslandHousesScriptsText3
	text_end

SeviiFiveIslandHousesText2_RP:
	text_asm
; stole any mon?
	CheckHideShowSevii HS_SEVII_FIVE_ISLAND_HOUSES_MON_1 ; z flag if is SHOW, nz if is HIDE
	jr nz, .stolenAtLeastAMon
	CheckHideShowSevii HS_SEVII_FIVE_ISLAND_HOUSES_MON_2
	jr nz, .stolenAtLeastAMon
	CheckHideShowSevii HS_SEVII_FIVE_ISLAND_HOUSES_MON_3
	jr nz, .stolenAtLeastAMon
	CheckHideShowSevii HS_SEVII_FIVE_ISLAND_HOUSES_MON_4
	jr z, .stolenNoMonsYet
.stolenAtLeastAMon
	ld hl, SeviiFiveIslandHousesText2_RP_PostStealing
	jr .printAndEnd
.stolenNoMonsYet
	CheckEvent EVENT_RP_SEVII_BEAT_CARING_BIKER
	ld hl, SeviiFiveIslandHousesText2_RP_PostBeating
	jr nz, .printAndEnd
; before engaging
	ld hl, SeviiFiveIslandHousesText2_RP_BeforeBeating
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiFiveIslandHousesText2_RP_PostStealing:
	text_far _SeviiFiveIslandHousesText2_RP_PostStealing
	text_end

SeviiFiveIslandHousesText2_RP_PostBeating:
	text_far _SeviiFiveIslandHousesText2_RP_PostBeating
	text_end

SeviiFiveIslandHousesText2_RP_BeforeBeating:
	text_far _SeviiFiveIslandHousesText2_RP_BeforeBeating
	text_end
