Museum2F_Script:
	RPTextChooser Museum2F_TextPointers, Museum2F_TextPointers_Rocket
	call EnableAutoTextBoxDrawing
	ld hl, Museum2F_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

Museum2F_ScriptPointers: ; new for RP
	dw Museum2F_Script0
	dw Museum2F_Script1

Museum2F_TextPointers:
	dw Museum2FText1
	dw Museum2FText2
	dw Museum2FText3
	dw Museum2FText4
	dw Museum2FText5
	dw Museum2FText8 ; new
	; signs
	dw Museum2FText6
	dw Museum2FText7

Museum2F_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw Museum2FText8_RP
	; signs
	dw Museum2FText6
	dw Museum2FText7 ; 8

Museum2FText1:
	text_far _Museum2FText1
	text_end

Museum2FText2:
	text_far _Museum2FText2
	text_end

Museum2FText3:
	text_far _Museum2FText3
	text_end

Museum2FText4:
	text_far _Museum2FText4
	text_end

Museum2FText5:
	text_asm
	ld a, [wd472]
	bit 7, a
	jr nz, .asm_5c1f6
	ld hl, Museum2FText_5c20e
	call PrintText
	jr .asm_5c20b

.asm_5c1f6
	ld a, [wPikachuHappiness]
	cp 101
	jr c, .asm_5c205
	ld hl, Museum2FText_5c218
	call PrintText
	jr .asm_5c20b

.asm_5c205
	ld hl, Museum2FText_5c213
	call PrintText
.asm_5c20b
	jp TextScriptEnd

Museum2FText_5c20e:
	text_far _Museum2FText5
	text_end

Museum2FText_5c213:
	text_far _Museum2FPikachuText1
	text_end

Museum2FText_5c218:
	text_far _Museum2FPikachuText2
	text_end

Museum2FText6:
	text_far _Museum2FText6
	text_end

Museum2FText7:
	text_far _Museum2FText7
	text_end

Museum2FText8:
	text_asm
	ld hl, Museum2FText8_2
	CheckEvent EVENT_LAST_DIALOGUE_CINNABAR_ARCHEOLOGIST
	jr nz, .printAndEnd
; yet to fully talk with the archeologist
	ld hl, Museum2FText8_1
.printAndEnd
	call PrintText
	jp TextScriptEnd

Museum2FText8_1:
	text_far _Museum2FText8_1
	text_end

Museum2FText8_2:
	text_far _Museum2FText8_2
	text_end

; new for RP ========================

Museum2FText8_RP:
	text_asm
	CheckEvent EVENT_RP_BEAT_ARCHEOLOGIST_GRANKID_MUSEUM
	ld hl, Museum2FText8_RP_AfterBattle
	jr nz, .printAndEnd
	CheckEvent EVENT_GIVEN_CINNABAR_ARCHEOLOGIST_ARTIFACT
	ld hl, Museum2FText8_RP_BeforeTheft
	jr z, .printAndEnd
; set up battle
	ld hl, Museum2FText8_RP_Battle
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call Delay3
	ld a, OPP_HIKER
	ld [wCurOpponent], a
	ld a, 25
	ld [wTrainerNo], a
	ld a, 1
	ld [wIsTrainerBattle], a
	ld hl, Museum2FGrankidDefeatedText_RP
	ld de, Museum2FGrankidDefeatedText_RP
	call SaveEndBattleTextPointers
	SetEvent EVENT_RP_USE_VANILLA_BATTLE_MESSAGES
; load next script
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd
.printAndEnd
	call PrintText
	jp TextScriptEnd

Museum2FText8_RP_BeforeTheft:
	text_far _Museum2FText8_RP_BeforeTheft
	text_end

Museum2FText8_RP_Battle:
	text_far _Museum2FText8_RP_Battle
	text_end

Museum2FGrankidDefeatedText_RP:
	text_far _Museum2FGrankidDefeatedText_RP
	text_end

Museum2FText8_RP_AfterBattle:
	text_far _Museum2FText8_RP_AfterBattle
	text_end

Museum2F_Script0:
	ret

Museum2F_Script1:
	ld a, [wIsInBattle]
	cp $ff
	jp z, Museum2FResetScripts
; we won
	SetEvent EVENT_RP_BEAT_ARCHEOLOGIST_GRANKID_MUSEUM
	; fallthrough
Museum2FResetScripts:
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret
