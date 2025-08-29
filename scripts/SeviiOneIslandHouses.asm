SeviiOneIslandHouses_Script:
	jp EnableAutoTextBoxDrawing

SeviiOneIslandHouses_TextPointers:
	dw SeviiOneIslandHousesText1 ; weather move tutor
	dw SeviiOneIslandHousesText2 ; Celio
	dw SeviiOneIslandHousesText3 ; Mayoi
	; signs
	dw SeviiOneIslandHousesSignText1
	dw SeviiOneIslandHousesSignText2
	dw SeviiOneIslandHousesSignText3
	dw SeviiOneIslandHousesSignText4
	text_end

SeviiOneIslandHousesText1:
	text_asm
	call SaveScreenTilesToBuffer2 ; this must always be here before calling Tutor, and should always be at a point when text is not on the screen
	CheckEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR
	jr nz, .alreadyGaveDrink
; still haven't given drink
	ld hl, SeviiOneIslandHousesText1_RequestDrink
	call PrintText
; check if we have the drink
	call RemoveWeatherTutorDrink
	ldh a, [hItemToRemoveID]
	and a
	jr z, .done ; we have no drink
; we have the drink and we gave one
	SetEvent EVENT_GAVE_DRINK_TO_WEATHER_TUTOR
	call WaitForTextScrollButtonPress
	ld hl, SeviiOneIslandHousesText1_ThanksForTheDrink
	call PrintText
	call WaitForTextScrollButtonPress
.alreadyGaveDrink
	ld hl, SeviiOneIslandHousesText1_Question
	call PrintText
;	call YesNoChoice
;	ld a, [wCurrentMenuItem]
;	and a
;	jr z, .learnMove
	call MoveTutorWeatherChoice
	ld a, [wCurrentMenuItem]
	and a
	jr z, .sunnyDay
	dec a
	jr z, .rainDance
	dec a
	jr z, .sandstorm
	dec a
	jr z, .hail
; decline
	ld hl, SeviiOneIslandHousesText1_Refused
	call PrintText
	jr .done
.sunnyDay
	ld a, SUNNY_DAY
	jr .learnMove
.rainDance
	ld a, RAIN_DANCE
	jr .learnMove
.sandstorm
	ld a, SANDSTORM
	jr .learnMove
.hail
	ld a, HAIL
.learnMove
	ld [wMoveNum], a
	farcall Tutor
	ld hl, SeviiOneIslandHousesText1_Done
	call PrintText
.done
	jp TextScriptEnd

SeviiOneIslandHousesText1_RequestDrink:
	text_far _SeviiOneIslandHousesText1_RequestDrink
	text_end

SeviiOneIslandHousesText1_ThanksForTheDrink:
	text_far _SeviiOneIslandHousesText1_ThanksForTheDrink
	text_end

SeviiOneIslandHousesText1_Question:
	text_far _SeviiOneIslandHousesText1_Question
	text_end

SeviiOneIslandHousesText1_Refused:
	text_far _SeviiOneIslandHousesText1_Refused
	text_end

SeviiOneIslandHousesText1_Done:
	text_far _SeviiOneIslandHousesText1_Done
	text_end

; displays weather choice
MoveTutorWeatherChoice:
	call SaveScreenTilesToBuffer1
	ld a, MOVE_TUTOR_WEATHER_MENU
	ld [wTextBoxID], a
	call DisplayTextBoxID
	ld hl, wTopMenuItemY
	ld a, 5
	ld [hli], a ; top menu item Y
	ld a, 8
	ld [hli], a ; top menu item X
	xor a
	ld [hli], a ; current menu item ID
	inc hl
	ld a, 3 ; number of options - 1?
	ld [hli], a ; wMaxMenuItem
	ld a, B_BUTTON | A_BUTTON
	ld [hli], a ; wMenuWatchedKeys
	xor a
	ld [hl], a ; wLastMenuItem
	call HandleMenuInput
	bit BIT_B_BUTTON, a
	jr nz, .decline ; if B was pressed
; A was pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	jp LoadScreenTilesFromBuffer1
.decline
	ld a, 4
	ld [wCurrentMenuItem], a
	jp LoadScreenTilesFromBuffer1

RemoveWeatherTutorDrink::
	ld hl, WeatherTutorDrinkList
.drinkLoop
	ld a, [hli]
	ldh [hItemToRemoveID], a
	and a
	ret z
	push hl
	ld b, a
	call IsItemInBag
	pop hl
	jr z, .drinkLoop
	farjp RemoveItemByID

WeatherTutorDrinkList:
	db COFFEE
	db BEER
	db 0 ; end

; Celio and Mayoi ------------------------------------

SeviiOneIslandHousesText2:
	text_asm
	ld hl, SeviiOneIslandHousesText2_BeforeRescue
	CheckEvent EVENT_SEVII_RESCUED_MAYOI
	jr z, .printAndEnd
; after rescue: check if already received the Flute, and if not, give it
	CheckEvent EVENT_GOT_POKE_FLUTE
	jr nz, .gotFlute
	ld hl, SeviiOneIslandHousesText2_AfterRescueBeforeFlute
	call PrintText
	lb bc, POKE_FLUTE, 1
	call GiveItem
	jr nc, .bagFull
	SetEvent EVENT_GOT_POKE_FLUTE
	ld hl, SeviiOneIslandHousesText2_ReceivedFlute
	jr .printAndEnd
.bagFull
	ld hl, SeviiOneIslandHousesText2_NoRoom
	jr .printAndEnd
.gotFlute
	ld hl, SeviiOneIslandHousesText2_AfterFlute
.printAndEnd
	call PrintText
	jp TextScriptEnd

SeviiOneIslandHousesText2_BeforeRescue:
	text_far _SeviiOneIslandHousesText2_BeforeRescue
	text_end

SeviiOneIslandHousesText2_AfterRescueBeforeFlute:
	text_far _SeviiOneIslandHousesText2_AfterRescueBeforeFlute
	text_end

SeviiOneIslandHousesText2_NoRoom:
	text_far _SeviiOneIslandHousesText2_NoRoom
	text_end

SeviiOneIslandHousesText2_ReceivedFlute:
	text_far _ReceivedFluteText
	sound_get_key_item
	text_far _FluteExplanationText
	text_end

SeviiOneIslandHousesText2_AfterFlute:
	text_far _SeviiOneIslandHousesText2_AfterFlute
	text_end

SeviiOneIslandHousesText3:
	text_far _SeviiOneIslandHousesText3
	text_end

; signs ----------------------------------------------

SeviiOneIslandHousesSignText1:
	text_far _SeviiOneIslandHousesSignText1
	text_end

SeviiOneIslandHousesSignText2:
	text_far _SeviiOneIslandHousesSignText2
	text_end

SeviiOneIslandHousesSignText3:
	text_far _SeviiOneIslandHousesSignText3
	text_end

SeviiOneIslandHousesSignText4:
	text_far _SeviiOneIslandHousesSignText4
	text_end
