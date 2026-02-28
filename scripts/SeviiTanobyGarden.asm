SeviiTanobyGarden_Script:
	call HideOrShowTanobyDenEntrance
	call EnableAutoTextBoxDrawing
	ld hl, SeviiTanobyGarden_ScriptPointers
	ld a, [wCurMapScript]
	jp CallFunctionInTable

; scripts =========================================

HideOrShowTanobyDenEntrance:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	call nz, HideOrShowTanobyDenEntrance_Core
	ld hl, wCurrentMapScriptFlags
	bit 4, [hl]
	res 4, [hl]
	ret z
; fallthrough
HideOrShowTanobyDenEntrance_Core:
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_COMPLETED_MEW_CHASE
	ret nz
; replace block
	ld a, $57 ; no-entrance edge block
	ld [wNewTileBlockID], a
	lb bc,  1,  4 ; Y and X coordinates - opposite as usual
	predef_jump ReplaceTileBlock

; --------

SeviiTanobyGarden_ScriptPointers:
	dw SeviiTanobyGarden_Script0 ;  0

	dw SeviiTanobyGarden_ScriptMew1_1 ;  1
	dw SeviiTanobyGarden_ScriptMew1_2 ;  2
	
	dw SeviiTanobyGarden_ScriptMew2_1 ;  3
	dw SeviiTanobyGarden_ScriptMew2_2 ;  4

	dw SeviiTanobyGarden_ScriptMew3_1 ;  5
	dw SeviiTanobyGarden_ScriptMew3_2 ;  6

	dw SeviiTanobyGarden_ScriptMew4_1 ;  7
	dw SeviiTanobyGarden_ScriptMew4_2 ;  8

	dw SeviiTanobyGarden_ScriptMew5_1 ;  9
	dw SeviiTanobyGarden_ScriptMew5_2 ; 10

	dw SeviiTanobyGarden_ScriptMew6_1 ; 11
	dw SeviiTanobyGarden_ScriptMew6_2 ; 12

	dw SeviiTanobyGarden_ScriptMew7_1 ; 13
	dw SeviiTanobyGarden_ScriptMew7_2 ; 14

	dw SeviiTanobyGarden_ScriptMew8_1 ; 15
	dw SeviiTanobyGarden_ScriptMew8_2 ; 16

	dw SeviiTanobyGarden_ScriptMew9_1 ; 17
	dw SeviiTanobyGarden_ScriptMew9_2 ; 18

	dw SeviiTanobyGarden_ScriptN ; 19
	dw SeviiTanobyGarden_ScriptFinal ; 20

; --------------------------

SeviiTanobyGarden_Script0:
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew1_1:
; turn
	lb de, 1, SPRITE_FACING_RIGHT ; specific
	callfar ChangeSpriteFacing ; new Pigeon approach
; script handling
	ld a, 2 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew1_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_1_9 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_2 ; specific
	ld a, 100 ; 5 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew2_1:
; turn
	lb de, 2, SPRITE_FACING_UP ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 4 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew2_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_2 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_3 ; specific
	ld a, 60 ; 3 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew3_1:
; turn
	lb de, 3, SPRITE_FACING_LEFT ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 6 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew3_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_3 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_4 ; specific
	ld a, 80 ; 4 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew4_1:
; turn
	lb de, 4, SPRITE_FACING_LEFT ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 8 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew4_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_4 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_5 ; specific
	ld a, 120 ; 6 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew5_1:
; turn
	lb de, 5, SPRITE_FACING_LEFT ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 10 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew5_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_5 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_6 ; specific
	ld a, 120 ; 6 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew6_1:
; turn
	lb de, 6, SPRITE_FACING_UP ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 12 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew6_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_6 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_7 ; specific
	ld a, 180 ; 9 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew7_1:
; turn
	lb de, 7, SPRITE_FACING_DOWN ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 14 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew7_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_7 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_8 ; specific
	ld a, 255 ; 14 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew8_1:
; turn
	lb de, 8, SPRITE_FACING_UP ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 16 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew8_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_8 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_9 ; specific
	ld a, 140 ; 7 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 19
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptMew9_1:
; turn
	lb de, 1, SPRITE_FACING_UP ; specific
	callfar ChangeSpriteFacing
; script handling
	ld a, 18 ; specific
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptMew9_2:
; wait between turning and hiding
	ld c, 40
	call DelayFrames
; hide
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_1_9 ; specific
	ld [wMissableObjectIndex], a
	predef HideObjectSevii
; set proper event and waiting time
	SetEvent EVENT_SEVII_TANOBY_GARDEN_COMPLETED_MEW_CHASE ; specific
	ld a, 100 ; 7 steps x 20 frames/step ; specific
	ld [wMultipurposeTemporaryStorage], a
; script handling
	ld a, 20
	ld [wCurMapScript], a
	ret

; --------------------------

SeviiTanobyGarden_ScriptN:
	ld a, [wMultipurposeTemporaryStorage]
	ld c, a
	call DelayFrames
; script handling
	xor a
	ld [wCurMapScript], a
	ret

SeviiTanobyGarden_ScriptFinal:
	ld a, [wMultipurposeTemporaryStorage]
	ld c, a
	call DelayFrames
; tremble
	callfar ShakeScreen
	call PlayDefaultMusic
; open wall
	ld a, $06 ; yes-entrance edge block
	ld [wNewTileBlockID], a
	lb bc,  1,  4 ; Y and X coordinates - opposite as usual
	predef ReplaceTileBlock
; script handling
	xor a
	ld [wCurMapScript], a
	ret

; texts =========================================

SeviiTanobyGarden_TextPointers:
	dw SeviiTanobyGardenText1
	dw SeviiTanobyGardenText2
	dw SeviiTanobyGardenText3
	dw SeviiTanobyGardenText4
	dw SeviiTanobyGardenText5
	dw SeviiTanobyGardenText6
	dw SeviiTanobyGardenText7
	dw SeviiTanobyGardenText8
	dw SeviiTanobyGardenText9
	; scripts
	dw SeviiTanobyGardenMewText

SeviiTanobyGardenText1:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 1
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText2:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 3 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText3:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 5 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText4:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 7 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText5:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 9 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText6:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 11 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText7:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 13 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText8:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 15 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenText9:
	text_asm
	call SeviiTanobyGardenCommonCoreText
	ld a, 17 ; specific
	ld [wCurMapScript], a
	jp TextScriptEnd

SeviiTanobyGardenCommonCoreText:
	ld hl, SeviiTanobyGardenMewText
	call PrintText
	ld a, MEW
	call PlayCry
	ret

SeviiTanobyGardenMewText:
	text_far _SeviiTanobyGardenMewText
	text_end

; hidden texts ====================================

SeviiTanobyGardenHiddenTextMew2::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_2 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_2 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_2 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 2 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew3::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_3 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_3 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_3 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 3 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew4::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_4 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_4 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_4 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 4 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew5::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_5 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_5 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_5 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 5 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew6::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_6 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_6 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_6 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 6 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew7::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_7 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_7 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_7 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 7 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew8::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_8 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_8 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_8 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 8 ; specific
	ldh [hSpriteIndexOrTextID], a
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	call DisplayTextID
	ret

SeviiTanobyGardenHiddenTextMew9::
	CheckEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_9 ; specific
	ret z
	ResetEvent EVENT_SEVII_TANOBY_GARDEN_ACTIVATED_MEW_9 ; specific
	ld a, HS_SEVII_TANOBY_GARDEN_MEW_1_9 ; specific
	ld [wMissableObjectIndex], a
	predef ShowObjectSevii
	ld a, 1 ; specific
	ld [wEmotionBubbleSpriteIndex], a
	call ExclamationBubbleCommon
	ld a, 9 ; specific
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	ret

ExclamationBubbleCommon:
	ld a, EXCLAMATION_BUBBLE
	ld [wWhichEmotionBubble], a
	predef_jump EmotionBubble