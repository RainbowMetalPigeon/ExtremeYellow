ViridianPokecenter_Script:
	RPTextChooser ViridianPokecenter_TextPointers, ViridianPokecenter_TextPointers_Rocket
	call ViridianPokecenterCheckTurning ; new
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

ViridianPokecenterCheckTurning: ; new
	CheckEvent EVENT_ROCKET_PATH
	ret nz
; right coordinates?
	ld a, [wXCoord]
	cp 17
	ret c
; prevent turning
	ld hl, wd72d
	set 5, [hl]
	ret

ViridianPokecenter_TextPointers:
	dw ViridianHealNurseText
	dw ViridianPokeCenterText2
	dw ViridianPokeCenterText3
	dw ViridianTradeNurseText
	dw ViridianPokeCenterText5
	dw ViridianPokeCenterText6 ; new
	dw ViridianPokeCenterText7 ; new
	; new, villa
	dw RockSmashText
	dw BoulderText
	dw ViridianPokeCenter_VillaText1
	dw ViridianPokeCenter_VillaSignText1
	dw ViridianPokeCenter_VillaSignText2
	dw ViridianPokeCenter_VillaSignText3
	dw ViridianPokeCenter_VillaSignText4

ViridianPokecenter_TextPointers_Rocket:
	dw ViridianHealNurseText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw ViridianTradeNurseText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	; new, villa
	dw RockSmashText
	dw BoulderText
	dw ViridianPokeCenter_VillaText1_RP
	dw ViridianPokeCenter_VillaSignText1
	dw ViridianPokeCenter_VillaSignText2
	dw ViridianPokeCenter_VillaSignText3
	dw ViridianPokeCenter_VillaSignText4

ViridianHealNurseText:
	script_pokecenter_nurse

ViridianPokeCenterText2:
	text_far _ViridianPokeCenterText2
	text_end

ViridianPokeCenterText3:
	text_far _ViridianPokeCenterText3
	text_end

ViridianTradeNurseText:
	script_cable_club_receptionist

ViridianPokeCenterText5:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

ViridianPokeCenterText6: ; new
	text_far _ViridianPokeCenterText6
	text_end

ViridianPokeCenterText7: ; new
	text_far _ViridianPokeCenterText7
	text_end

; new for villa =============================

ViridianPokeCenter_VillaText1:
	text_far _ViridianPokeCenter_VillaText1
	text_end

ViridianPokeCenter_VillaText1_RP:
	text_far _ViridianPokeCenter_VillaText1_RP
	text_end

ViridianPokeCenter_VillaSignText1:
	text_far _ViridianPokeCenter_VillaSignText1
	text_end

ViridianPokeCenter_VillaSignText2:
	text_far _ViridianPokeCenter_VillaSignText2
	text_end

ViridianPokeCenter_VillaSignText3:
	text_far _ViridianPokeCenter_VillaSignText3
	text_end

ViridianPokeCenter_VillaSignText4:
	text_far _ViridianPokeCenter_VillaSignText4
	text_end
