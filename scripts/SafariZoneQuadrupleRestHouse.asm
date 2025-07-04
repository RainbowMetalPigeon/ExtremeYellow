SafariZoneQuadrupleRestHouse_Script:
	call EnableAutoTextBoxDrawing
	ld de, SafariZoneRestHouse_ScriptPointers
	ld a, [wCurMapScript] ; edited
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a ; edited
	ret

SafariZoneRestHouse_ScriptPointers: ; new
	dw SafariZoneRestHouseScript0
	dw SafariZoneRestHouseScript_MoveSara
	dw SafariZoneRestHouseScript_HideAndShowErikAndSara

SafariZoneRestHouseScript0: ; new
	ret

; =====================================

SafariZoneQuadrupleRestHouse_TextPointers:
	dw SafariZoneRestHouse1Text1
	dw SafariZoneRestHouse1Text2
	dw SafariZoneRestHouseTextSaraHappy ; new
	dw SafariZoneRestHouseTextErikHappy ; new
	; west
	dw SafariZoneRestHouse2Text1
	dw SafariZoneRestHouse2Text2
	dw SafariZoneRestHouse2Text3
	; east
	dw SafariZoneRestHouse3Text1
	dw SafariZoneRestHouse3Text2
	dw SafariZoneRestHouse3Text3
	; north
	dw SafariZoneRestHouse4Text1
	dw SafariZoneRestHouse4Text2
	dw SafariZoneRestHouse4Text3
	; extra
	dw SafariZoneRestHouseText_SaraSurprised ; new

SafariZoneRestHouse1Text1:
	text_asm
	ld hl, SafariZoneRestHouseText_SaraWaiting
	call PrintText
	CheckEvent EVENT_SPOKEN_WITH_ERIK
	jr z, .notSpokenWithErik
	ld a, 1
	ld [wCurMapScript], a
	jr .conclude
.notSpokenWithErik
	SetEvent EVENT_SPOKEN_WITH_SARA
.conclude
	jp TextScriptEnd

SafariZoneRestHouseScript_MoveSara:
	ld a, 1 ; Sara waiting
	ld [wEmotionBubbleSpriteIndex], a
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef EmotionBubble
	ld c, 20
	call DelayFrames
	ld a, 14
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ld a, [wYCoord]
	cp 3 ; is player standing down of Sara?
	jr z, .downOfSara
	ld de, SafariZoneRestHouseSaraMovements_PlayerEqual
	jr .continue
.downOfSara
	ld de, SafariZoneRestHouseSaraMovements_PlayerDown
.continue
	ld a, 1 ; index of Sara
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 2
	ld [wCurMapScript], a
	ret

SafariZoneRestHouseScript_HideAndShowErikAndSara:
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	ld a, HS_SAFARI_REST_HOUSE_SARA_WAITING
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_FUCHSIA_CITY_ERIK_WAITING
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ld a, HS_FUCHSIA_CITY_ERIK_HAPPY
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
	ld a, HS_FUCHSIA_CITY_SARA_HAPPY
	ld [wMissableObjectIndex], a
	predef ShowObjectExtra
; script handling and return control to players
	xor a
	ld [wJoyIgnore], a
	ld [wCurMapScript], a
	ret

SafariZoneRestHouseSaraMovements_PlayerEqual: ; new
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db -1

SafariZoneRestHouseSaraMovements_PlayerDown: ; new
	db NPC_MOVEMENT_LEFT
;	db NPC_MOVEMENT_LEFT
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
	db NPC_MOVEMENT_DOWN
;	db NPC_MOVEMENT_RIGHT
	db NPC_MOVEMENT_DOWN
	db -1

SafariZoneRestHouse1Text2:
	text_far _SafariZoneRestHouse1Text2
	text_end

SafariZoneRestHouseTextSaraHappy:
	text_far _SafariZoneRestHouseTextSaraHappy
	text_end

SafariZoneRestHouseTextErikHappy:
	text_far _SafariZoneRestHouseTextErikHappy
	text_end

SafariZoneRestHouseText_SaraWaiting: ; new
	text_far _SafariZoneRestHouseText_SaraWaiting
	text_end

SafariZoneRestHouseText_SaraSurprised: ; new
	text_far _SafariZoneRestHouseText_SaraSurprised
	text_end

; west ------------------------

SafariZoneRestHouse2Text1:
	text_far _SafariZoneRestHouse2Text1
	text_end

SafariZoneRestHouse2Text2:
	text_far _SafariZoneRestHouse2Text2
	text_end

SafariZoneRestHouse2Text3:
	text_far _SafariZoneRestHouse2Text3
	text_end

; east ------------------------

SafariZoneRestHouse3Text1:
	text_far _SafariZoneRestHouse3Text1
	text_end

SafariZoneRestHouse3Text2:
	text_far _SafariZoneRestHouse3Text2
	text_end

SafariZoneRestHouse3Text3:
	text_far _SafariZoneRestHouse3Text3
	text_end

; north ------------------------

SafariZoneRestHouse4Text1:
	text_far _SafariZoneRestHouse4Text1
	text_end

SafariZoneRestHouse4Text2:
	text_far _SafariZoneRestHouse4Text2
	text_end

SafariZoneRestHouse4Text3:
	text_far _SafariZoneRestHouse4Text3
	text_end
