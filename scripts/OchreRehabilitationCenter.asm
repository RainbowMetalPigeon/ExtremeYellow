OchreRehabilitationCenter_Script:
	call EnableAutoTextBoxDrawing
	ld de, OchreRehabilitationCenter_ScriptPointers
	ld a, [wOchreRehabilitationCenterCurScript]
	call ExecuteCurMapScriptInTable
	ld [wOchreRehabilitationCenterCurScript], a
	ret

OchreRehabilitationCenter_ScriptPointers:
	dw OchreRehabilitationCenterScript0
	dw OchreRehabilitationCenterScript1
	dw OchreRehabilitationCenterScript2

OchreRehabilitationCenterScript0:
	ret

OchreRehabilitationCenterScript1:
	call PlayDefaultMusic
	ld a, 5
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	CheckEvent EVENT_OCHRE_REHABILITATION_SCOLDED_AGAIN
	jr z, .noMegaFine
	ld hl, wPlayerMoney
	ld a, $0
	ld [hli], a
	ld [hli], a
	ld [hl], a
.noMegaFine
	ld de, OchreRehabilitationCenterMovements
	ld a, 5
	ldh [hSpriteIndex], a
	call MoveSprite
	ld a, 2
	ld [wOchreRehabilitationCenterCurScript], a
	ld [wCurMapScript], a
	ret

OchreRehabilitationCenterScript2: ; new
	ld a, [wd730] ; bit 0: NPC being moved by script
	bit 0, a
	ret nz
	ld a, HS_OCHRE_REHABILITATION_GURU_2
	ld [wMissableObjectIndex], a
	predef HideObjectExtra
	ResetEvent EVENT_OCHRE_CITY_FENCE_FORCED
	xor a
	ld [wJoyIgnore], a
	xor a
	ld [wOchreRehabilitationCenterCurScript], a
	ld [wCurMapScript], a
	ret

OchreRehabilitationCenterMovements:
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db NPC_MOVEMENT_UP
	db -1 ; end

; ======================================

OchreRehabilitationCenter_TextPointers:
	dw OchreRehabilitationCenterText1
	dw OchreRehabilitationCenterText2
	dw OchreRehabilitationCenterText3
	dw OchreRehabilitationCenterText4
	dw OchreRehabilitationCenterText5 ; boss copy, only for scolding
	; signs
	dw OchreRehabilitationCenterText6

OchreRehabilitationCenterText1:
	text_far _OchreRehabilitationCenterText1
	text_end

OchreRehabilitationCenterText2:
	text_far _OchreRehabilitationCenterText2
	text_end

OchreRehabilitationCenterText3:
	text_far _OchreRehabilitationCenterText3
	text_end

OchreRehabilitationCenterText4:
	text_far _OchreRehabilitationCenterText4
	text_end

OchreRehabilitationCenterText5:
	text_asm
	ld hl, OchreRehabilitationCenterText5_Once
	CheckEvent EVENT_OCHRE_REHABILITATION_SCOLDED_AGAIN
	jr z, .printText
	ld hl, OchreRehabilitationCenterText5_Again
.printText
	call PrintText
	jp TextScriptEnd

OchreRehabilitationCenterText5_Once:
	text_far _OchreRehabilitationCenterText5_Once
	text_end

OchreRehabilitationCenterText5_Again:
	text_far _OchreRehabilitationCenterText5_Again
	text_end

OchreRehabilitationCenterText6:
	text_far _OchreRehabilitationCenterText6
	text_end

;EVENT_OCHRE_CITY_FENCE_FORCED
;EVENT_OCHRE_REHABILITATION_SCOLDED_ONCE
;EVENT_OCHRE_REHABILITATION_SCOLDED_AGAIN
