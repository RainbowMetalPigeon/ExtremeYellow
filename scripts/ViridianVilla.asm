ViridianVilla_Script:
	RPTextChooser ViridianVilla_TextPointers, ViridianVilla_TextPointers_Rocket
	call ViridianVillaCheckTurning
	jp EnableAutoTextBoxDrawing

ViridianVillaCheckTurning:
;	CheckEvent EVENT_ROCKET_PATH ; TBE?
;	ret nz
; prevent turning
	ld hl, wd72d
	set 5, [hl]
	ret

ViridianVilla_TextPointers:
	dw RockSmashText
	dw BoulderText
	dw ViridianVilla_Text1
	dw ViridianVilla_SignText1
	dw ViridianVilla_SignText2
	dw ViridianVilla_SignText3
	dw ViridianVilla_SignText4

ViridianVilla_TextPointers_Rocket:
	dw RockSmashText
	dw BoulderText
	dw ViridianVilla_Text1_RP
	dw ViridianVilla_SignText1
	dw ViridianVilla_SignText2
	dw ViridianVilla_SignText3
	dw ViridianVilla_SignText4

ViridianVilla_Text1:
ViridianVilla_Text1_RP: ; TBE?
	text_asm
	CheckEvent EVENT_GOT_MONJI
	jr z, .beforeMonji
; after MONJI
	ld hl, ViridianVilla_Text1_AfterMonji
	jr .printAndEnd
.beforeMonji
	ld hl, ViridianVilla_Text1_BeforeMonji
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .doNotTakeMonji ; if player chose No
; take Monji
	ld hl, ViridianVilla_Text1_GotMonji
	call PrintText
	SetEvent EVENT_GIVING_GUARANTEED_SHINY_MON
	SetEvent EVENT_SPECIAL_MONJI_RENAMING
	ld c, 50
	ld b, TANGELA
	call GivePokemon
	jp nc, TextScriptEnd
	SetEvent EVENT_GOT_MONJI
	jp TextScriptEnd
.doNotTakeMonji
	ld hl, ViridianVilla_Text1_NoMonji
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianVilla_Text1_AfterMonji:
	text_far _ViridianVilla_Text1_AfterMonji
	text_end

ViridianVilla_Text1_BeforeMonji:
	text_far _ViridianVilla_Text1_BeforeMonji
	text_end

ViridianVilla_Text1_GotMonji:
	text_far _ViridianVilla_Text1_GotMonji
	text_end

ViridianVilla_Text1_NoMonji:
	text_far _ViridianVilla_Text1_NoMonji
	text_end

ViridianVilla_SignText1:
	text_far _ViridianVilla_SignText1
	text_end

ViridianVilla_SignText2:
	text_asm
	ld hl, ViridianVilla_SignText2_Intro
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .done ; if player chose No
; page 1
	ld hl, ViridianVilla_SignText2_Page1
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .done ; if player chose No
; page 2
	ld hl, ViridianVilla_SignText2_Page2
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jp nz, .done ; if player chose No
; page 3
	ld hl, ViridianVilla_SignText2_Page3
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page 4
	ld hl, ViridianVilla_SignText2_Page4
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page 5
	ld hl, ViridianVilla_SignText2_Page5
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page 6
	ld hl, ViridianVilla_SignText2_Page6
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page 7
	ld hl, ViridianVilla_SignText2_Page7
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page 8
	ld hl, ViridianVilla_SignText2_Page8
	call PrintText
	ld hl, ViridianVilla_SignText2_ReadNextPage
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .done ; if player chose No
; page last
	ld hl, ViridianVilla_SignText2_PageLast
	jr .printAndEnd
.done
	ld hl, ViridianVilla_SignText2_StopHere
.printAndEnd
	call PrintText
	jp TextScriptEnd

ViridianVilla_SignText2_Intro:
	text_far _ViridianVilla_SignText2_Intro
	text_end

ViridianVilla_SignText2_ReadNextPage:
	text_far _ViridianVilla_SignText2_ReadNextPage
	text_end

ViridianVilla_SignText2_Page1:
	text_far _ViridianVilla_SignText2_Page1
	text_end

ViridianVilla_SignText2_Page2:
	text_far _ViridianVilla_SignText2_Page2
	text_end

ViridianVilla_SignText2_Page3:
	text_far _ViridianVilla_SignText2_Page3
	text_end

ViridianVilla_SignText2_Page4:
	text_far _ViridianVilla_SignText2_Page4
	text_end

ViridianVilla_SignText2_Page5:
	text_far _ViridianVilla_SignText2_Page5
	text_end

ViridianVilla_SignText2_Page6:
	text_far _ViridianVilla_SignText2_Page6
	text_end

ViridianVilla_SignText2_Page7:
	text_far _ViridianVilla_SignText2_Page7
	text_end

ViridianVilla_SignText2_Page8:
	text_far _ViridianVilla_SignText2_Page8
	text_end

ViridianVilla_SignText2_PageLast:
	text_far _ViridianVilla_SignText2_PageLast
	text_end

ViridianVilla_SignText2_StopHere:
	text_far _ViridianVilla_SignText2_StopHere
	text_end

ViridianVilla_SignText3:
	text_far _ViridianVilla_SignText3
	text_end

ViridianVilla_SignText4:
	text_far _ViridianVilla_SignText4
	text_end
