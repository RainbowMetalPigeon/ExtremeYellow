VermilionHouses_Script:
	RPTextChooser VermilionHouses_TextPointers, VermilionHouses_TextPointers_Rocket
	jp EnableAutoTextBoxDrawing

VermilionHouses_TextPointers:
	; old rod
	dw VermilionHouse2Text1
	; "trade"
	dw VermilionHouse3Text1
	; pidgey
	dw VermilionHouse1Text1
	dw VermilionHouse1Text2
	dw VermilionHouse1Text3
	; new house 1
	dw VermilionHousesText6
	dw VermilionHousesText7
	; new house 2
	dw VermilionHousesText8 ; BIRD
	dw VermilionHousesText9 ; YOUNGSTER
	dw VermilionHousesText10 ; BEAUTY
	dw VermilionHousesText11 ; PAPER
	dw VermilionHousesText12 ; POKE_BALL
	dw VermilionHousesText13 ; FISHING_GURU

VermilionHouses_TextPointers_Rocket:
	; old rod
	dw GenericNPCText_RocketPath
	; "trade"
	dw GenericNPCText_RocketPath
	; pidgey
	dw GenericNPCText_RocketPath
	dw VermilionHouse1Text2_RP ; Mon
	dw VermilionHouse1Text3 ; Paper
	; new house 1
	dw VermilionHousesText6_RP
	dw VermilionHousesText7_RP
	; new house 2
	dw VermilionHousesText8_RP ; BIRD
	dw GenericNPCText_RocketPath ; YOUNGSTER
	dw GenericNPCText_RocketPath ; BEAUTY
	dw VermilionHousesText11 ; PAPER
	dw VermilionHousesText12_RP ; POKE_BALL
	dw VermilionHousesText13_RP ; FISHING_GURU

; old rod ----------------------------

VermilionHouse2Text1:
	text_asm
	ld a, [wd728]
	bit 3, a ; got old rod?
	jr nz, .got_item
	ld hl, VermilionHouse2Text_560b1
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .refused
	lb bc, OLD_ROD, 1
	call GiveItem
	jr nc, .bag_full
	ld hl, wd728
	set 3, [hl] ; got old rod
	ld hl, VermilionHouse2Text_560b6
	jr .done
.bag_full
	ld hl, VermilionHouse2Text_560ca
	jr .done
.refused
	ld hl, VermilionHouse2Text_560c0
	jr .done
.got_item
	ld hl, VermilionHouse2Text_560c5
.done
	call PrintText
	jp TextScriptEnd

VermilionHouse2Text_560b1:
	text_far _VermilionHouse2Text_560b1
	text_end

VermilionHouse2Text_560b6:
	text_far _VermilionHouse2Text_560b6
	sound_get_item_1
	text_far _VermilionHouse2Text_560bb
	text_end

VermilionHouse2Text_560c0:
	text_far _VermilionHouse2Text_560c0
	text_end

VermilionHouse2Text_560c5:
	text_far _VermilionHouse2Text_560c5
	text_end

VermilionHouse2Text_560ca:
	text_far _VermilionHouse2Text_560ca
	text_end

; "trade" ----------------------------

VermilionHouse3Text1:
	text_far TeachingHMsText
	text_end

; pidgey ----------------------------

VermilionHouse1Text1:
	text_far _VermilionHouse1Text1
	text_end

VermilionHouse1Text2:
	text_far _VermilionHouse1Text2
	text_asm
	ld a, PIDGEY
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

VermilionHouse1Text3:
	text_far _VermilionHouse1Text3
	text_end

; new houses --------------------------

VermilionHousesText6:
	text_far _VermilionHousesText6
	text_end

VermilionHousesText7:
	text_far _VermilionHousesText7
	text_end

VermilionHousesText8:
	text_asm
	ld hl, VermilionHousesText8_1
	call PrintText
	ld a, DODUO
	call PlayCry
	call WaitForSoundToFinish
	ld hl, VermilionHousesText8_2
	call PrintText
	jp TextScriptEnd

VermilionHousesText8_1:
	text_far _VermilionHousesText8_1
	text_end

VermilionHousesText8_2:
	text_far _VermilionHousesText8_2
	text_end

VermilionHousesText9:
	text_far _VermilionHousesText9
	text_end

VermilionHousesText10:
	text_far _VermilionHousesText10
	text_end

VermilionHousesText11:
	text_far _VermilionHousesText11
	text_end

VermilionHousesText12:
	text_far _VermilionHousesText12
	text_end

VermilionHousesText13:
	text_far _VermilionHousesText13
	text_end

; new for RP ===========================

VermilionHousesText6_RP:
	text_far _VermilionHousesText6_RP
	text_end

VermilionHousesText7_RP:
	text_far _VermilionHousesText7_RP
	text_end

VermilionHousesText13_RP:
	text_far _VermilionHousesText13_RP
	text_end

VermilionHouse1Text2_RP:
	text_far _VermilionHouse1Text2
	text_asm
	ld a, PIDGEY
	call PlayCry
	call WaitForSoundToFinish
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 18
	ld b, PIDGEY
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_VERMILION_HOUSES_MON_1
	ld [wMissableObjectIndex], a
	predef HideObjectExtra2
	jp TextScriptEnd

VermilionHousesText8_RP:
	text_asm
	ld hl, VermilionHousesText8_1
	call PrintText
	ld a, DODUO
	call PlayCry
	call WaitForSoundToFinish
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 21
	ld b, DODUO
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_VERMILION_HOUSES_MON_2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra2
	jp TextScriptEnd

VermilionHousesText12_RP:
	text_far _VermilionHousesText12_RP
	text_asm
	SetEvent EVENT_GIVING_GUARANTEED_SHINY_MON
	SetEvent EVENT_RP_STEALING_POKEMON
	ld c, 20
	ld b, VOLTORB
	call GivePokemon
	jp nc, TextScriptEnd
	ld a, HS_VERMILION_HOUSES_MON_3
	ld [wMissableObjectIndex], a
	predef HideObjectExtra2
	jp TextScriptEnd

VermilionHousesText12_RP_Core:
	text_far _VermilionHousesText12_RP
	text_end
