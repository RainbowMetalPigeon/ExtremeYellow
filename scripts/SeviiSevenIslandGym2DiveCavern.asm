SeviiSevenIslandGym2DiveCavern_Script:
	call HandleFlags_SSIG2DC
	call EnableAutoTextBoxDrawing
	ld de, SeviiSevenIslandGym2DiveCavern_ScriptPointers
	ld a, [wCurMapScript]
	call ExecuteCurMapScriptInTable
	ld [wCurMapScript], a
	ret

HandleFlags_SSIG2DC:
    ld hl, wCurrentMapScriptFlags
    bit 5, [hl]
    res 5, [hl]
    ret z
	SetEvent EVENT_BATTLE_CAN_BE_LOST
	ret

SeviiSevenIslandGym2DiveCavern_ScriptPointers:
	dw SeviiSevenIslandGym2DiveCavernScript0

SeviiSevenIslandGym2DiveCavernScript0:
	ld a, [wIsInBattle]
	cp $ff
	jp nz, CheckFightingMapTrainers
; we have been defeated
	ld a, 2 ; SeviiSevenIslandGym2DiveCavernText2_PostBlackOut
	ldh [hSpriteIndexOrTextID], a
	call DisplayTextID
	predef HealParty
	ld a, SPRITE_FACING_DOWN
	ld [wSpritePlayerStateData1FacingDirection], a
	ld a, SEVII_SEVEN_ISLAND_GYM_1
	ldh [hWarpDestinationMap], a
	ld a, 2 ; -1 wrt the normal numbering
	ld [wDestinationWarpID], a
	ld hl, wd72d
	set 3, [hl] ; do scripted warp
	xor a
    ld [wWalkBikeSurfState], a
	ld [wWalkBikeSurfStateCopy], a
	ld [wIsInBattle], a
	ret

SeviiSevenIslandGym2DiveCavern_TextPointers:
	dw PickUpItemText
	dw SeviiSevenIslandGym2DiveCavernText2_PostBlackOut

; ---------------------------------------

SeviiSevenIslandGym2DiveCavernText2_PostBlackOut:
	text_far _SeviiSevenIslandGymTextBlackout
	text_end
