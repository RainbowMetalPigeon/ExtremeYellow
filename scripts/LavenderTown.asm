LavenderTown_Script:
	RPTextChooser LavenderTown_TextPointers, LavenderTown_TextPointers_Rocket
	callfar SpawnTraveler ; new, for traveler
	call EnableAutoTextBoxDrawing
	ld de, LavenderTown_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

LavenderTown_ScriptPointers: ; new, for traveler
	dw LavenderScript0
	dw LavenderScript_Traveler

LavenderScript0:
	ret

; ================================

LavenderScript_Traveler:
	ld a, [wIsInBattle]
	cp $ff
	jr nz, .notDefeated
	xor a
	ld [wCurMapScript], a
	ret
.notDefeated
	xor a                            ; new, to go beyond 200
	ld [wIsTrainerBattle], a         ; new, to go beyond 200
; this is to guarantee that the traveler is visible after the battle
    ld a, HS_LAVENDER_TOWN_TRAVELER ; city-specific
    ld [wMissableObjectIndex], a
    predef ShowObjectExtra ; city-specific
	ld a, $0b ; city-specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
; make the traveler run away to search Mega Mewtwo
	call GBFadeOutToBlack
    callfar LoopHideTraveler
    callfar LoopHideTravelerExtra
	call UpdateSprites
	call Delay3
	call GBFadeInFromBlack
	ret

; ================================

LavenderTown_TextPointers:
	dw LavenderTownText1
	dw LavenderTownText2
	dw LavenderTownText3
	dw TextPreBattle_LavenderTraveler ; new, for traveler
	; signs
	dw LavenderTownText4
	dw LavenderTownText5
	dw MartSignText
	dw PokeCenterSignText
	dw LavenderTownText8
	dw LavenderTownText9 ; $0a
	; scripts
	dw TextPostBattle_LavenderTraveler ; $0b, new, for traveler

LavenderTown_TextPointers_Rocket:
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw TextPreBattle_LavenderTraveler_RP
	; signs
	dw LavenderTownText4
	dw LavenderTownText5
	dw MartSignText
	dw PokeCenterSignText
	dw LavenderTownText8
	dw LavenderTownText9 ; $0a
	; scripts
	dw TextPostBattle_LavenderTraveler_RP ; $0b

; ================================

TextPreBattle_LavenderTraveler: ; new
	text_asm
	callfar TravelerCommonPreBattleText
	jp c, TextScriptEnd
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_LavenderTraveler:
	text_asm
	callfar TravelerCommonPostBattleText
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd

; ================================

LavenderTownText1:
	text_asm
	ld hl, LavenderTownText_4413c
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	ld hl, LavenderTownText_44146
	jr nz, .got_text
	ld hl, LavenderTownText_44141
.got_text
	call PrintText
	jp TextScriptEnd

LavenderTownText_4413c:
	text_far _LavenderTownText_4413c
	text_end

LavenderTownText_44141:
	text_far _LavenderTownText_44141
	text_end

LavenderTownText_44146:
	text_far _LavenderTownText_44146
	text_end

LavenderTownText2:
	text_far _LavenderTownText2
	text_end

LavenderTownText3:
	text_far _LavenderTownText3
	text_end

LavenderTownText4:
	text_far _LavenderTownText4
	text_end

LavenderTownText5:
	text_far _LavenderTownText5
	text_end

LavenderTownText8:
	text_far _LavenderTownText8
	text_end

LavenderTownText9:
	text_far _LavenderTownText9
	text_end

; new for RP ============================

TextPreBattle_LavenderTraveler_RP:
	text_asm
	callfar TravelerCommonPreBattleText_RP
; script handling
	ld a, 1 ; city-specific
	ld [wCurMapScript], a
	jp TextScriptEnd

TextPostBattle_LavenderTraveler_RP:
	text_asm
	callfar TravelerCommonPostBattleText_RP
; script handling
	xor a
	ld [wCurMapScript], a
	jp TextScriptEnd
