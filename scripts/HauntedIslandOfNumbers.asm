HauntedIslandOfNumbers_Script:
	call EnableAutoTextBoxDrawing
	ld hl, HauntedIslandOfNumbers_ScriptPointers
	ld a, [wHauntedIslandOfNumbersCurScript]
	call CallFunctionInTable
	ret

HauntedIslandOfNumbers_ScriptPointers:
	dw HauntedIslandOfNumbersScript0
	dw HauntedIslandOfNumbersScript_StartMissingNoTrainerBattle
	dw HauntedIslandOfNumbersScript_PostTrainerBattle
	dw HauntedIslandOfNumbersScript_PostPokemonBattle

HauntedIslandOfNumbersScript0:
	ret

HauntedIslandOfNumbersScript_StartMissingNoTrainerBattle:
	ld hl, wd72d ; nobody knows what it does lol
	set 6, [hl]
	set 7, [hl]
	ld hl, MissingNoTrainerText_Win  ; text if player wins
	ld de, MissingNoTrainerText_Lose ; text if player loses
	call SaveEndBattleTextPointers
	ld a, OPP_MISSINGNO_T
	ld [wCurOpponent], a
	ld a, 1
	ld [wTrainerNo], a
	ld a, 1                          ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	xor a
	ldh [hJoyHeld], a
	ld a, 2
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a
	ret

HauntedIslandOfNumbersScript_PostTrainerBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, HauntedIslandOfNumbersScript_ResetAfterDefeat ; TBE
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld a, $f0
	ld [wJoyIgnore], a
	ld a, 2 ; HauntedIslandOfNumbersText_PostTrainerBattle
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, $ff ; testing
	ld [wJoyIgnore], a
	ld a, MISSINGNO ; as Pokemon, not trainer
	ld [wCurOpponent], a
	ld a, 255
	ld [wCurEnemyLVL], a
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
	ld [wJoyIgnore], a ; testing
	ld a, HS_HAUNTED_ISLAND_OF_NUMBERS_MISSINGNO
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, 3
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a
	ret

HauntedIslandOfNumbersScript_PostPokemonBattle:
	ld a, [wIsInBattle]
	cp $ff
	jp z, HauntedIslandOfNumbersScript_ResetAfterDefeat ; TBE
	call UpdateSprites
;	call Delay3
	xor a                            ; new, to go beyond 200; unnecessary here?
	ld [wIsTrainerBattle], a         ; new, to go beyond 200; unnecessary here?
;	ld a, $f0 ; testing
;	ld [wJoyIgnore], a
	ld a, 3 ; HauntedIslandOfNumbersText_PostPokemonBattle
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
;	ld a, $ff ; testing
;	ld [wJoyIgnore], a

	; open path to exit, TBE

	call Delay3
	ld a, 0
;	ld [wJoyIgnore], a
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a
	ret

HauntedIslandOfNumbersScript_ResetAfterDefeat:
	xor a
	ld [wJoyIgnore], a
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a

	; print a dialogue?
	; set destination warp, TBE

	ret

; ============================

HauntedIslandOfNumbers_TextPointers:
	dw HauntedIslandOfNumbersText_MissingNo
	dw HauntedIslandOfNumbersText_PostTrainerBattle
	dw HauntedIslandOfNumbersText_PostPokemonBattle

HauntedIslandOfNumbersText_MissingNo:
	text_asm
; load the right dialogue
	CheckAndSetEvent EVENT_FACED_MISSINGNO_AT_LEAST_ONCE
	jr z, .firstTime
	ld hl, HauntedIslandOfNumbersText_MissingNo_NotFirstTime
	call PrintText
	jr .continue
.firstTime
	ld hl, HauntedIslandOfNumbersText_MissingNo_FirstTime
	call PrintText
.continue
; script handling
	ld a, 1
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a
	jp TextScriptEnd

; ============================

HauntedIslandOfNumbersText_MissingNo_NotFirstTime:
	text_far _HauntedIslandOfNumbersText_MissingNo_NotFirstTime
	text_end

HauntedIslandOfNumbersText_MissingNo_FirstTime:
	text_far _HauntedIslandOfNumbersText_MissingNo_FirstTime
	text_end

MissingNoTrainerText_Win:
	text_far _MissingNoTrainerText_Win
	text_end

MissingNoTrainerText_Lose:
	text_far _MissingNoTrainerText_Lose
	text_end

HauntedIslandOfNumbersText_PostTrainerBattle:
	text_far _HauntedIslandOfNumbersText_PostTrainerBattle
	text_end

HauntedIslandOfNumbersText_PostPokemonBattle:
	text_far _HauntedIslandOfNumbersText_PostPokemonBattle
	text_end

; ============================
