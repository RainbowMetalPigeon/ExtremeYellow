MtMoonPokecenter_Script:
	RPTextChooser MtMoonPokecenter_TextPointers, MtMoonPokecenter_TextPointers_Rocket
	call Serial_TryEstablishingExternallyClockedConnection
	jp EnableAutoTextBoxDrawing

MtMoonPokecenter_TextPointers:
	dw MtMoonHealNurseText
	dw MtMoonPokecenterText2
	dw MtMoonPokecenterText3
	dw MagikarpSalesmanText
	dw MtMoonPokecenterText5
	dw MtMoonTradeNurseText
	dw MtMoonPokecenterText7
	dw MtMoonPokecenterText8 ; new

MtMoonPokecenter_TextPointers_Rocket:
	dw MtMoonHealNurseText
	dw GenericNPCText_RocketPath
	dw GenericNPCText_RocketPath
	dw MagikarpSalesmanText_RP
	dw MtMoonPokecenterText5
	dw MtMoonTradeNurseText
	dw GenericNPCText_RocketPath ; TBE?
	dw MtMoonPokecenterText8_RP ; Magikarp

MtMoonHealNurseText:
	script_pokecenter_nurse

MtMoonPokecenterText2:
	text_far _MtMoonPokecenterText1
	text_end

MtMoonPokecenterText3:
	text_far _MtMoonPokecenterText3
	text_end

MagikarpSalesmanText:
	text_asm
	callfar MagikarpSalesman
	jp TextScriptEnd

MtMoonPokecenterText5:
	text_far _MtMoonPokecenterText5
	text_end

MtMoonTradeNurseText:
	script_cable_club_receptionist

MtMoonPokecenterText7:
	text_asm
	callfar PokecenterChanseyText
	jp TextScriptEnd

MtMoonPokecenterText8: ; new
	text_asm
	ld hl, MtMoonPokecenterText8b
	call PrintText
	ld a, MAGIKARP
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

MtMoonPokecenterText8b: ; new
	text_far _MtMoonPokecenterText8b
	text_end

; new for RP ======================

MagikarpSalesmanText_RP:
	text_asm
	CheckEvent EVENT_BOUGHT_MAGIKARP ; tad abused
	ld hl, MagikarpSalesmanText_RP_After
	jr nz, .printAndEnd
	ld hl, MagikarpSalesmanText_RP_Before
.printAndEnd
	call PrintText
	jp TextScriptEnd

MagikarpSalesmanText_RP_Before:
	text_far _MagikarpSalesmanText_RP_Before
	text_end

MagikarpSalesmanText_RP_After:
	text_far _MagikarpSalesmanText_RP_After
	text_end

MtMoonPokecenterText8_RP:
	text_asm
	ld hl, MtMoonPokecenterText8b
	call PrintText
	ld a, MAGIKARP
	call PlayCry
	call WaitForSoundToFinish
	ld hl, MtMoonPokecenterText8_RP_TakeTheKarp
	call PrintText
; take the Karp
	ld a, MAGIKARP
	ld [wd11e], a
	ld [wcf91], a
	call GetMonName
	ld a, $1
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	lb bc, MAGIKARP, 5
	call GivePokemon
	jp nc, TextScriptEnd
; hide the Karp
	ld a, HS_MT_MOON_POKECENTER_MAGIKARP
	ld [wMissableObjectIndex], a
	predef HideObject
	SetEvent EVENT_BOUGHT_MAGIKARP
	jp TextScriptEnd

MtMoonPokecenterText8_RP_TakeTheKarp:
	text_far _MtMoonPokecenterText8_RP_TakeTheKarp
	text_end
