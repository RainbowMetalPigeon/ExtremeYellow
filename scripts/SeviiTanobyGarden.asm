SeviiTanobyGarden_Script:
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTanobyGarden_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

SeviiTanobyGarden_ScriptPointers:
	dw SeviiTanobyGarden_Script0 ; 0
	dw SeviiTanobyGarden_Script1 ; 1
	dw SeviiTanobyGarden_Script2 ; 2

SeviiTanobyGarden_Script0:
	ret

SeviiTanobyGarden_Script1:
;	ld a, HS_SEVII_TANOBY_GARDEN_MEW
;	ld [wMissableObjectIndex], a
;	predef ShowObjectSevii
	ld de, SeviiTanobyGarden_MewMovements_1
	ld a, 1
	ldh [hSpriteIndex], a
	call MoveSprite
; script handling
	ld a, 2
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_Script2:
; wait for Beasts movements
	ld a, [wd730]
	bit 0, a
	ret nz
; other stuff TBE
	ld a, $0
	ld [wJoyIgnore], a
	ret

SeviiTanobyGarden_MewMovements_1:
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db NPC_FAST_MOVEMENT_RIGHT
	db -1

; texts =========================================

SeviiTanobyGarden_TextPointers:
	dw SeviiTanobyGardenText1
;	dw PickUpItemText
;	dw RockSmashText
;	dw BoulderText
;	dw SeviiTanobyGardenText3

SeviiTanobyGardenText1:
	text_asm
	ld hl, SeviiTanobyGardenMewText
	call PrintText
; script handling
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenMewText:
	text_far _SeviiTanobyGardenMewText
	text_end
