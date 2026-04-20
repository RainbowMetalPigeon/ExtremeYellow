SeviiTwoIslandPokemonCenter_Script:
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

SeviiTwoIslandPokemonCenter_TextPointers:
	dw SeviiTwoIslandPokemonCenter_HealNurseText
	dw SeviiTwoIslandPokemonCenter_ChanseyText
	dw SeviiTwoIslandPokemonCenter_Text1
	dw SeviiTwoIslandPokemonCenter_Text2

SeviiTwoIslandPokemonCenter_HealNurseText:
	script_pokecenter_nurse

SeviiTwoIslandPokemonCenter_ChanseyText:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

SeviiTwoIslandPokemonCenter_Text1:
	text_far _SeviiTwoIslandPokemonCenter_Text1
	text_end

SeviiTwoIslandPokemonCenter_Text2:
	text_asm
	ld hl, SeviiTwoIslandPokemonCenter_Text2_Intro
	call PrintText
	ld a, [wPersonalizationTCGMode]
	and a
	jr nz, .done
; not in TCG mode
	ld d, ROCK
	ld e, GHOST
	callfar CheckIfACertainDoubleTypeIsInParty
	jr nz, .done
; match found (should only be delta Venustoise)
	call WaitForTextScrollButtonPress ; wait for a button press after displaying all the text
	ld hl, SeviiTwoIslandPokemonCenter_Text2_Surprise
	call PrintText
.done
	jp TextScriptEnd

SeviiTwoIslandPokemonCenter_Text2_Surprise:
	text_far _SeviiTwoIslandPokemonCenter_Text2_Surprise
	text_end

SeviiTwoIslandPokemonCenter_Text2_Intro:
	text_far _SeviiTwoIslandPokemonCenter_Text2_Intro
	text_end
