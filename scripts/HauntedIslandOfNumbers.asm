HauntedIslandOfNumbers_Script:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HauntedIslandOfNumbersReplaceBlock
	call EnableAutoTextBoxDrawing
	ld hl, HauntedIslandOfNumbers_ScriptPointers
	ld a, [wHauntedIslandOfNumbersCurScript]
	call CallFunctionInTable
	ret

HauntedIslandOfNumbersReplaceBlock:
	CheckEvent EVENT_DEFEATED_MISSINGNO
	jr nz, .pathOpen
	ld a, $78 ; only-white block ID
	jr .replaceBlock
.pathOpen
	ld a, $84 ; white-with-black-warp block ID
.replaceBlock
	ld [wNewTileBlockID], a
	lb bc, 14, 15 ; block coordinates in Y, X
	predef_jump ReplaceTileBlock

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
	ld hl, wPokedexSeen
	call CleanHumanPokedexEntries
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
	callfar RollForShiny ; new, for the shiny
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
	SetEvent EVENT_DEFEATED_MISSINGNO
	ld a, HS_HAUNTED_HOUSE_4_MOM_SW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_SE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_NE
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_HAUNTED_HOUSE_4_MOM_NW
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	xor a                            ; new, to go beyond 200; unnecessary here?
	ld [wIsTrainerBattle], a         ; new, to go beyond 200; unnecessary here?
	ld a, 3 ; HauntedIslandOfNumbersText_PostPokemonBattle
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	call HauntedIslandOfNumbersReplaceBlock ; open exit
	call Delay3
	ld a, 0
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a
	ret

CleanHumanPokedexEntries: ; oh-so horribly hard coded xD
	ld b, wPokedexOwnedEnd - wPokedexOwned - 1
.loop
	inc hl
	dec b
	jr nz, .loop
	ld [hl], %00000001
	ret

HauntedIslandOfNumbersScript_ResetAfterDefeat:
	xor a
	ld [wJoyIgnore], a
	ld [wHauntedIslandOfNumbersCurScript], a
	ld [wCurMapScript], a

	; print a dialogue?
	; set special destination warp?

	ret

; ============================

HauntedIslandOfNumbers_TextPointers:
	dw HauntedIslandOfNumbersText_MissingNo
	dw HauntedIslandOfNumbersText_PostTrainerBattle
	dw HauntedIslandOfNumbersText_PostPokemonBattle

HauntedIslandOfNumbersText_MissingNo:
	text_asm
; play a bunch of sounds

	ld a, SFX_SS_ANNE_HORN
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_GET_KEY_ITEM
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_POKEDEX_RATING
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_TRADE_MACHINE
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_TELEPORT_ENTER_1
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_SAVE
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

	ld a, SFX_LEDGE
	call PlaySound
;	ld c, 50
;	call DelayFrames
	call WaitForSoundToFinish

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
