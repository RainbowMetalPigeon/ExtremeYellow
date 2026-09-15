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

VermilionHouses_TextPointers_Rocket:
	; old rod
	dw GenericNPCText_RocketPath
	; "trade"
	dw GenericNPCText_RocketPath
	; pidgey
	dw GenericNPCText_RocketPath
	dw VermilionHouse1Text2 ; Mon
	dw VermilionHouse1Text3 ; Paper

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
